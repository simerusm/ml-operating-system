#ifndef NETWORKADAPTER_H
#define NETWORKADAPTER_H

#include <iostream>
#include <string>

class NetworkAdapter {
public:
    static NetworkAdapter& getInstance();
    void sendPacket(const std::string& packet);
    std::string getMetrics();

private:
    NetworkAdapter();
    int packetCount;
};

#endif