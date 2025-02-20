#ifndef CPU_H
#define CPU_H

#include <iostream>
#include <string>

class CPU {
public:
    static CPU& getInstance();
    void executeTask(const std::string& task);
    std::string getMetrics();

private:
    CPU();
    int cores;
    int utilization;
};

#endif