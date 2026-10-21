package com.shopsphere.network.socket;

import com.shopsphere.model.Product;

import java.io.EOFException;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.math.BigDecimal;
import java.net.ServerSocket;
import java.net.Socket;
import java.time.LocalDateTime;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Academic Demonstration: Socket Server with Java Object Serialization.
 * Demonstrates RTU Syllabus Section 20 & Section 3:
 * Transferring serialized Product POJOs over TCP using ObjectOutputStream and ObjectInputStream.
 */
public class ObjectSocketInventoryServer {

    public static final int DEFAULT_PORT = 8096;
    private final int port;
    private final Map<String, Product> productCatalog = new ConcurrentHashMap<>();
    private volatile boolean running = true;

    public ObjectSocketInventoryServer(int port) {
        this.port = port;
        seedInventory();
    }

    private void seedInventory() {
        productCatalog.put("SKU-MTB-PRO", new Product(
                101L, 1, "SKU-MTB-PRO", "Apex Trailblazer Mountain Bike", "apex-trailblazer",
                "Carbon fiber full-suspension downhill MTB", new BigDecimal("1299.99"),
                new BigDecimal("1199.99"), 24, "active", LocalDateTime.now(), LocalDateTime.now()
        ));
        productCatalog.put("SKU-ROAD-AERO", new Product(
                102L, 2, "SKU-ROAD-AERO", "Veloce Aero Carbon Road Racer", "veloce-aero",
                "Ultra-lightweight aerodynamic road bicycle", new BigDecimal("1849.50"),
                new BigDecimal("1699.00"), 12, "active", LocalDateTime.now(), LocalDateTime.now()
        ));
        productCatalog.put("SKU-EBIKE-URBAN", new Product(
                103L, 3, "SKU-EBIKE-URBAN", "VoltRide Urban Commuter E-Bike", "voltride-urban",
                "500W pedal-assist city e-bike with 80km range", new BigDecimal("2199.00"),
                null, 8, "active", LocalDateTime.now(), LocalDateTime.now()
        ));
    }

    public void start() throws IOException {
        try (ServerSocket serverSocket = new ServerSocket(port)) {
            System.out.println("[ObjectSocketServer] Binary Object Serialization Server listening on port " + port);
            System.out.println("[ObjectSocketServer] Ready to stream serialized Product objects.");

            while (running) {
                Socket clientSocket = serverSocket.accept();
                System.out.println("[ObjectSocketServer] Client connected: " + clientSocket.getRemoteSocketAddress());
                new Thread(() -> handleClient(clientSocket)).start();
            }
        }
    }

    private void handleClient(Socket socket) {
        try (
                // Note: Always create ObjectOutputStream before ObjectInputStream to avoid stream header deadlocks
                ObjectOutputStream oos = new ObjectOutputStream(socket.getOutputStream());
                ObjectInputStream ois = new ObjectInputStream(socket.getInputStream())
        ) {
            oos.flush();

            while (!socket.isClosed()) {
                try {
                    // Receive requested SKU as serialized String
                    Object input = ois.readObject();
                    if (input instanceof String sku) {
                        System.out.println("[ObjectSocketServer] Received request for SKU: " + sku);
                        Product product = productCatalog.get(sku.trim().toUpperCase());

                        if (product != null) {
                            // Send serialized Product object back across the network stream
                            oos.writeObject(product);
                            oos.flush();
                            System.out.println("[ObjectSocketServer] Transmitted serialized Product: " + product.getName());
                        } else {
                            // Send null or dummy object if SKU not found
                            oos.writeObject(null);
                            oos.flush();
                        }
                    }
                } catch (EOFException e) {
                    break; // Client closed connection
                }
            }
        } catch (IOException | ClassNotFoundException e) {
            System.err.println("[ObjectSocketServer] Communication notice: " + e.getMessage());
        } finally {
            try {
                socket.close();
            } catch (IOException ignored) {}
        }
    }

    public static void main(String[] args) {
        int port = DEFAULT_PORT;
        if (args.length > 0) {
            try {
                port = Integer.parseInt(args[0]);
            } catch (NumberFormatException ignored) {}
        }
        try {
            new ObjectSocketInventoryServer(port).start();
        } catch (IOException e) {
            System.err.println("[ObjectSocketServer] Failed to start server: " + e.getMessage());
        }
    }
}
