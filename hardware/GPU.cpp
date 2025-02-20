#include "GPU.h"

GPU& GPU::getInstance() {
    static GPU instance;
    return instance;
}

GPU::GPU() : cores(256), utilization(0) {}

void GPU::processMLTask(const std::string& task) {
    std::cout << "GPU processing ML task: " << task << std::endl;
    utilization = (utilization + 20) % 100; // note: increase utilization by 20 per task, meaningless calculation right now
}

std::string GPU::getMetrics() {
    return "gpu_cores " + std::to_string(cores) + "\ngpu_utilization " + std::to_string(utilization) + "\n";
}