# ML Operating System

A custom operating system designed specifically for machine learning workflows.

## Project Overview

The ML Operating System provides:
- Efficient resource management for ML workloads
- Real-time monitoring of system metrics
- Specialized storage and memory management
- Network optimization for distributed ML tasks

## Components

- `CPU`: Manages general computation tasks
- `GPU`: Handles ML-specific computations
- `RAM`: Provides fast memory access for ML models
- `SSD`: Manages persistent storage for models and datasets
- `NetworkAdapter`: Handles distributed ML communication

## Building and Running

### Prerequisites
- C++ compiler with C++11 support
- Make sure the `hardware/binary` directory exists (create if needed)

### Running Tests

1. Create the binary directory if it doesn't exist:
```bash
mkdir -p hardware/binary
```

2. Compile the test file:
```bash
g++ -std=c++11 hardware/test.cpp hardware/CPU.cpp hardware/GPU.cpp hardware/RAM.cpp hardware/SSD.cpp hardware/NetworkAdapter.cpp -o hardware/binary/test
```

3. Run the test binary:
```bash
./hardware/binary/test
```

The test program will demonstrate the functionality of each hardware component by simulating various ML-related tasks and displaying metrics.