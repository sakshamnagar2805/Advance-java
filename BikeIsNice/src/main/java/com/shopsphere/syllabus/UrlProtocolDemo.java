package com.shopsphere.syllabus;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import java.util.Map;

/**
 * Educational Demonstration: Java URL & Protocol Handlers.
 * Demonstrates RTU Syllabus Section 24 & Section 3:
 * Parsing URLs, opening URLConnections, reading protocol headers, and processing network content streams.
 */
public class UrlProtocolDemo {

    public static void main(String[] args) {
        System.out.println("==================================================================");
        System.out.println("RTU Syllabus Section 24: URL & Content/Protocol Handler Demo");
        System.out.println("==================================================================");

        try {
            String targetUrl = "https://httpbin.org/get";
            System.out.println("[URL Protocol Demo] Constructing URI/URL target: " + targetUrl);

            URI uri = URI.create(targetUrl);
            URL url = uri.toURL();

            System.out.println("   * Protocol : " + url.getProtocol());
            System.out.println("   * Host     : " + url.getHost());
            System.out.println("   * Port     : " + (url.getPort() == -1 ? url.getDefaultPort() : url.getPort()));
            System.out.println("   * Path     : " + url.getPath());

            System.out.println("\n[URL Protocol Demo] Establishing URLConnection...");
            URLConnection connection = url.openConnection();
            connection.setConnectTimeout(3000);
            connection.setReadTimeout(3000);

            if (connection instanceof HttpURLConnection httpConn) {
                httpConn.setRequestMethod("GET");
                httpConn.setRequestProperty("User-Agent", "ShopSphere-RTU-Demo/1.0");

                System.out.println("   * Response Code : " + httpConn.getResponseCode());
                System.out.println("   * Content-Type  : " + httpConn.getContentType());
                System.out.println("   * Content-Length: " + httpConn.getContentLength());

                System.out.println("\n[URL Protocol Demo] Protocol Response Headers:");
                for (Map.Entry<String, List<String>> header : httpConn.getHeaderFields().entrySet()) {
                    if (header.getKey() != null) {
                        System.out.println("   " + header.getKey() + " -> " + String.join(", ", header.getValue()));
                    }
                }

                System.out.println("\n[URL Protocol Demo] Stream Reading First 3 Lines of Content:");
                try (BufferedReader reader = new BufferedReader(new InputStreamReader(httpConn.getInputStream()))) {
                    String line;
                    int linesRead = 0;
                    while ((line = reader.readLine()) != null && linesRead < 3) {
                        System.out.println("   | " + line);
                        linesRead++;
                    }
                }
            }

            System.out.println("==================================================================");
            System.out.println("URL & Protocol Handler executed successfully!");
            System.out.println("==================================================================");

        } catch (Exception e) {
            System.out.println("[URL Protocol Demo Notice] Simulated network handler: " + e.getMessage());
            System.out.println("Concept demonstrated: java.net.URL, java.net.URLConnection, HttpURLConnection request lifecycle.");
        }
    }
}
