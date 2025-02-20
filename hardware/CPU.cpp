#include "CPU.h"

CPU& CPU::getInstance() {
    static CPU instance;
    return instance;
}

CPU::CPU() : cores(4), utilization(0) {}

void CPU::executeTask(const std::string& task) {
    std::cout << "CPU executing task: " << task << std::endl;
    utilization = (utilization + 10) % 100; // note: increase utilization by 10 per task, meaningless calculation right now
}

std::string CPU::getMetrics() {
    return "cpu_cores " + std::to_string(cores) + "\ncpu_utilization " + std::to_string(utilization) + "\n";
}