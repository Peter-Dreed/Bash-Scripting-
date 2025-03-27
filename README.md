# Bash Scripting Repository

## Introduction

This repository offers a set of scripts targeting common administrative tasks such as system monitoring, optimization, and log analysis.


### 1. Automation-System.sh

**Purpose:** Automates system monitoring by collecting data on CPU, memory, and disk usage, and saves the information to a CSV file for easy analysis.

**Features:**

- Captures current CPU usage.
- Monitors memory consumption.
- Checks disk utilization.
- Logs the data with timestamps into a CSV file located on the user's Desktop.

**Usage:**

```bash
./Automation-System.sh
```

### 2. Optimization.sh

**Purpose:** Optimizes the system by performing maintenance tasks such as deleting temporary files, restarting essential services, and updating the system.

**Features:**

- Clears temporary directories to free up space.
- Restarts critical services like networking, SSH, and Apache.
- Updates package lists and upgrades installed packages.
- Removes unused dependencies.

**Usage:**

```bash
./Optimization.sh
```

### 3. System-Event.sh

**Purpose:** Analyzes system logs, formats them in a table-like manner, and saves the output to a CSV file. It also allows users to specify the number of log entries to process.

**Features:**

- Extracts logs from system log files.
- Formats logs to display timestamp, log level, process, and message.
- Saves formatted logs to a CSV file on the user's Desktop.
- Allows customization of the number of log entries to analyze.

**Usage:**

```bash
./System-Event.sh [number_of_logs]
```

*Replace `[number_of_logs]` with the desired number of log entries to process. If not specified, the default is 10.*

## Getting Started

### Prerequisites

- **Operating System:** Linux-based systems (Ubuntu, CentOS, etc.).
- **Permissions:** Some scripts may require administrative privileges. It's recommended to run them with `sudo` if necessary.
- **Dependencies:** Ensure that essential utilities like `awk`, `systemctl`, and package managers (`apt` or `yum`) are installed and accessible.

### Usage

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/Peter-Dreed/Bash-Scripting-.git
   cd Bash-Scripting-
   ```

2. **Make Scripts Executable:**

   ```bash
   chmod +x *.sh
   ```

3. **Run Desired Script:**

   For example, to run the Optimization script:

   ```bash
   sudo ./Optimization.sh
   ```

   *Note: Running with `sudo` may be necessary for tasks that require elevated privileges.*
