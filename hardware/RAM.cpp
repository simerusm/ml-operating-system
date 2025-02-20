#include "RAM.h"

RAM& RAM::getInstance() {
    static RAM instance;
    return instance;
}

RAM::RAM() {
    memory.resize(2048, ""); // Simulate 2048 blocks
}

void RAM::writeData(int address, const std::string& data) {
    if (address < 0 || address >= memory.size()) {
        std::cerr << "RAM write: Address out of range\n";
        return;
    }
    memory[address] = data;
}

std::string RAM::readData(int address) {
    if (address < 0 || address >= memory.size()) {
        std::cerr << "RAM read: Address out of range\n";
        return "";
    }
    return memory[address];
}

std::string RAM::getMetrics() {
    int usedBlocks = 0;
    for (const auto &block : memory) {
        if (!block.empty()) usedBlocks++;
    }
    return "ram_total_blocks " + std::to_string(memory.size()) + "\nram_used_blocks " + std::to_string(usedBlocks) + "\n";
}