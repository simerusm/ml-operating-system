#ifndef GPU_H
#define GPU_H

#include <iostream>
#include <string>

class GPU {
public:
    static GPU& getInstance();
    void processMLTask(const std::string& task);
    std::string getMetrics();

private:
    GPU();
    int cores;
    int utilization;
};

#endif