## Goals

The primary goal of this project is to create a custom operating system that can run shell commands such as `ls`, `cd`, and `mkdir`. This OS will leverage the hardware emulator QEMU to simulate actual hardware components, allowing for a flexible and efficient development environment for machine learning workflows.

## Installing QEMU on macOS

To set up QEMU on your macOS, follow these steps:

1. **Install Homebrew** (if you haven't already):
   Open your terminal and run the following command to install Homebrew, a package manager for macOS:
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install QEMU**:
   Once Homebrew is installed, you can install QEMU by running:
   ```bash
   brew install qemu
   ```

3. **Verify the Installation**:
   After the installation is complete, verify that QEMU is installed correctly by checking its version:
   ```bash
   qemu-system-x86_64 --version
   ```

4. **Create a Virtual Disk Image**:
   Use qemu-img to create a virtual disk that will serve as the OS’s storage:
   ```bash
   qemu-img create -f qcow2 os_disk.qcow2 20G
   ```
  	•	-f qcow2: Specifies the QCOW2 disk format (supports features like snapshots).
	•	os_disk.qcow2: The name of the disk image file.
	•	20G: Allocates 20 GB of disk space (adjust as needed).

5. **Boot from an OS Installation ISO**:
   Assuming you have an ISO file for your OS installation, boot the virtual machine using:
   ```bash
   qemu-system-x86_64 -boot d -cdrom /path/to/your.iso -m 2048 -hda os_disk.qcow2
   ```
  	•	-boot d: Boots from the CD-ROM (ISO) first.
	•	-cdrom /path/to/your.iso: Path to your OS installation ISO.
	•	-m 2048: Allocates 2 GB of RAM.
	•	-hda os_disk.qcow2: Uses the virtual disk you created.

6. **Configure Additionl Hardware**:
   CPU and Memory
   ```bash
   qemu-system-x86_64 -cpu host -smp 2 -m 2048 -hda os_disk.qcow2
   ```
  	•	-cpu host: Leverages your host’s CPU capabilities.
	•	-smp 2: Sets up 2 CPU cores.