#ifndef RAM_H
#define RAM_H

#include <iostream>
#include <vector>
#include <string>

class RAM {
public:
    static RAM& getInstance();
    void writeData(int address, const std::string& data);
    std::string readData(int address);
    std::string getMetrics();

private:
    RAM();
    std::vector<std::string> memory;
};

#endif