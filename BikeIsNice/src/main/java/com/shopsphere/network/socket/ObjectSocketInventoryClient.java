package com.shopsphere.network.socket;

import com.shopsphere.model.Product;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;

/**
 * Academic Demonstration: Socket Client with Java Object Serialization.
 * Demonstrates RTU Syllabus Section 20 & Section 3:
 * Receiving and deserializing Product POJOs over TCP using ObjectInputStream.
 */
public class ObjectSocketInventoryClient {

    public static void main(String[] args) {
        String host = (args.length > 0) ? args[0] : "localhost";
        int port = (args.length > 1) ? Integer.parseInt(args[1]) : ObjectSocketInventoryServer.DEFAULT_PORT;

        System.out.println("==================================================================");
        System.out.println("[ObjectSocketClient] Connecting to Serialization Server at " + host + ":" + port);
        System.out.println("==================================================================");

        try (Socket socket = new Socket(host, port);
             // Create ObjectOutputStream first to send header, then ObjectInputStream
             ObjectOutputStream oos = new ObjectOutputStream(socket.getOutputStream());
             ObjectInputStream ois = new ObjectInputStream(socket.getInputStream())) {

            oos.flush();

            String[] requestedSkus = {"SKU-MTB-PRO", "SKU-ROAD-AERO", "SKU-EBIKE-URBAN"};

            for (String sku : requestedSkus) {
                System.out.println("\n[Client -> Server] Requesting serialized Product with SKU: " + sku);
                oos.writeObject(sku);
                oos.flush();

                Object response = ois.readObject();
                if (response instanceof Product product) {
                    System.out.println("[Server -> Client] Deserialized Product Object Received:");
                    System.out.println("   * Product ID    : " + product.getProductId());
                    System.out.println("   * Name          : " + product.getName());
                    System.out.println("   * SKU           : " + product.getSku());
                    System.out.println("   * Regular Price : ₹" + product.getPrice());
                    System.out.println("   * Sale Price    : ₹" + (product.getSalePrice() != null ? product.getSalePrice() : "N/A"));
                    System.out.println("   * Live Stock    : " + product.getStockQuantity() + " units available");
                    System.out.println("   * Description   : " + product.getDescription());
                } else {
                    System.out.println("[Server -> Client] Product not found for SKU: " + sku);
                }
            }

            System.out.println("\n==================================================================");
            System.out.println("[ObjectSocketClient] Object Serialization transmission completed successfully!");
            System.out.println("==================================================================");

        } catch (IOException | ClassNotFoundException e) {
            System.err.println("[ObjectSocketClient] Error communicating with server: " + e.getMessage());
        }
    }
}
