#!/usr/bin/env bash
# ==============================================================================
# ShopSphere Automated Networking & Syllabus Demonstration Test Suite
# Fulfills RTU Syllabus Sections 18 (RMI), 19 (Sockets), 20 (Serialization),
# 23 (Internationalization), and 24 (JNDI & URL Protocol Handlers).
# ==============================================================================
set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_DIR"

echo "=================================================="
echo " 1. Compiling All Java Classes with Maven"
echo "=================================================="
mvn compile -DskipTests

echo "Compilation successful!"

echo ""
echo "=================================================="
echo " 2. Testing Low-Level TCP Socket Client-Server (Text Protocol)"
echo "=================================================="
# Launch Socket Server in background on port 8092
java -cp target/classes com.shopsphere.network.socket.SocketInventoryServer 8092 &
SOCKET_PID=$!
sleep 1

# Run Socket Client
java -cp target/classes com.shopsphere.network.socket.SocketInventoryClient localhost 8092

# Terminate Socket Server
kill $SOCKET_PID 2>/dev/null || true
wait $SOCKET_PID 2>/dev/null || true

echo ""
echo "=================================================="
echo " 3. Testing Object Serialization TCP Socket (RTU Section 20)"
echo "=================================================="
# Launch Object Socket Server in background on port 8096
java -cp target/classes com.shopsphere.network.socket.ObjectSocketInventoryServer 8096 &
OBJ_SOCKET_PID=$!
sleep 1

# Run Object Socket Client
java -cp target/classes com.shopsphere.network.socket.ObjectSocketInventoryClient localhost 8096

# Terminate Object Socket Server
kill $OBJ_SOCKET_PID 2>/dev/null || true
wait $OBJ_SOCKET_PID 2>/dev/null || true

echo ""
echo "=================================================="
echo " 4. Testing Java RMI Client-Server (RTU Section 18)"
echo "=================================================="
# Launch RMI Server in background
java -cp target/classes com.shopsphere.network.rmi.RmiInventoryServer &
RMI_PID=$!
sleep 1

# Run RMI Client
java -cp target/classes com.shopsphere.network.rmi.RmiInventoryClient localhost 1099

# Terminate RMI Server
kill $RMI_PID 2>/dev/null || true
wait $RMI_PID 2>/dev/null || true

echo ""
echo "=================================================="
echo " 5. Testing Internationalization (RTU Section 23)"
echo "=================================================="
java -cp target/classes com.shopsphere.util.I18nUtil

echo ""
echo "=================================================="
echo " 6. Testing JNDI & URL Handlers (RTU Section 24)"
echo "=================================================="
java -cp target/classes com.shopsphere.syllabus.JndiDemo
java -cp target/classes com.shopsphere.syllabus.UrlProtocolDemo

echo ""
echo "=================================================="
echo " All RTU Syllabus Modules Tested Successfully!"
echo "=================================================="
