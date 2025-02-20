#include "SSD.h"

SSD& SSD::getInstance() {
    static SSD instance;
    return instance;
}

SSD::SSD() {
    storage.resize(1024, ""); // Simulate 1024 blocks
}

void SSD::writeData(int address, const std::string& data) {
    if (address < 0 || address >= storage.size()) {
        std::cerr << "SSD write: Address out of range\n";
        return;
    }
    storage[address] = data;
}

std::string SSD::readData(int address) {
    if (address < 0 || address >= storage.size()) {
        std::cerr << "SSD read: Address out of range\n";
        return "";
    }
    return storage[address];
}

std::string SSD::getMetrics() {
    int usedBlocks = 0;
    for (const auto &block : storage) {
        if (!block.empty()) usedBlocks++;
    }
    return "ssd_total_blocks " + std::to_string(storage.size()) + "\nssd_used_blocks " + std::to_string(usedBlocks) + "\n";
}