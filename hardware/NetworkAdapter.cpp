#include "NetworkAdapter.h"

NetworkAdapter& NetworkAdapter::getInstance() {
    static NetworkAdapter instance;
    return instance;
}

NetworkAdapter::NetworkAdapter() : packetCount(0) {}

void NetworkAdapter::sendPacket(const std::string& packet) {
    std::cout << "NetworkAdapter sending packet: " << packet << std::endl;
    packetCount++;
}

std::string NetworkAdapter::getMetrics() {
    return "network_packets_sent " + std::to_string(packetCount) + "\n";
}