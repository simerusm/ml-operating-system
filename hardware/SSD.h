#ifndef SSD_H
#define SSD_H

#include <iostream>
#include <vector>
#include <string>

class SSD {
public:
    static SSD& getInstance();
    void writeData(int address, const std::string& data);
    std::string readData(int address);
    std::string getMetrics();

private:
    SSD();
    std::vector<std::string> storage;
};

#endif