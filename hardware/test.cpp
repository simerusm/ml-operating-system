#include <iostream>
#include "SSD.h"
#include "RAM.h"
#include "CPU.h"
#include "GPU.h"
#include "NetworkAdapter.h"

void printSeparator() {
    std::cout << "-------------------------------------\n";
}

void testSSD() {
    printSeparator();
    std::cout << "TESTING SSD...\n";

    SSD& ssd = SSD::getInstance();
    
    std::cout << "Writing data to SSD...\n";
    ssd.writeData(10, "ML Model Checkpoint 1");
    ssd.writeData(20, "Dataset Partition 1");
    ssd.writeData(50, "Temporary Cache Data");

    std::cout << "Reading data from SSD:\n";
    std::cout << "Block 10: " << ssd.readData(10) << "\n";
    std::cout << "Block 20: " << ssd.readData(20) << "\n";
    std::cout << "Block 50: " << ssd.readData(50) << "\n";

    std::cout << "SSD Metrics:\n" << ssd.getMetrics();
}

void testRAM() {
    printSeparator();
    std::cout << "TESTING RAM...\n";

    RAM& ram = RAM::getInstance();
    
    std::cout << "Allocating memory...\n";
    ram.writeData(100, "Tensor Processing Buffer");
    ram.writeData(200, "Activation Map");
    ram.writeData(300, "Batch Normalization Cache");

    std::cout << "Reading data from RAM:\n";
    std::cout << "Address 100: " << ram.readData(100) << "\n";
    std::cout << "Address 200: " << ram.readData(200) << "\n";
    std::cout << "Address 300: " << ram.readData(300) << "\n";

    std::cout << "RAM Metrics:\n" << ram.getMetrics();
}

void testCPU() {
    printSeparator();
    std::cout << "TESTING CPU...\n";

    CPU& cpu = CPU::getInstance();
    
    cpu.executeTask("Forward Propagation");
    cpu.executeTask("Backpropagation");
    cpu.executeTask("Gradient Descent Optimization");

    std::cout << "CPU Metrics:\n" << cpu.getMetrics();
}

void testGPU() {
    printSeparator();
    std::cout << "TESTING GPU...\n";

    GPU& gpu = GPU::getInstance();
    
    gpu.processMLTask("Matrix Multiplication for CNN");
    gpu.processMLTask("Batch Inference on 1000 Images");
    gpu.processMLTask("Neural Network Training - 10 Epochs");

    std::cout << "GPU Metrics:\n" << gpu.getMetrics();
}

void testNetworkAdapter() {
    printSeparator();
    std::cout << "TESTING NETWORK ADAPTER...\n";

    NetworkAdapter& net = NetworkAdapter::getInstance();
    
    net.sendPacket("Training Data Chunk 1");
    net.sendPacket("Model Parameters Update");
    net.sendPacket("Real-time Prediction Request");

    std::cout << "Network Metrics:\n" << net.getMetrics();
}

int main() {
    testSSD();
    testRAM();
    testCPU();
    testGPU();
    testNetworkAdapter();
    
    return 0;
}