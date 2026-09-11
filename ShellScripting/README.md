# Shell Scripting Homework – System Information Script

## Objective

Create a shell script that displays system information and demonstrates the use of variables, user input, directory and file creation, commands, and output redirection.

## Files

* `system_info.sh` – Shell script for the system information task.
* `README.md` – Commands used and their outputs.

---

## 1. mkdir

### Command

```bash
mkdir system_info
```

### Output

```text
No output. Directory created successfully.
```

---

## 2. touch

### Command

```bash
touch system_info.txt
```

### Output

```text
No output. File created successfully.
```

---

## 3. echo

### Command

```bash
echo "System Information"
```

### Output

```text
System Information
```

---

## 4. df

### Command

```bash
df
```

### Output

```text
Filesystem     1K-blocks     Used Available Use% Mounted on
tmpfs            1567636     2308   1565328   1% /run
/dev/nvme0n1p7  82312520 19032712  59052584  25% /
tmpfs            7838172    17164   7821008   1% /dev/shm
tmpfs               5120       16      5104   1% /run/lock
efivarfs             128       52        72  43% /sys/firmware/efi/efivars
/dev/nvme0n1p1    262144    95160    166984  37% /boot/efi
tmpfs            1567632      128   1567504   1% /run/user/1000
```

---

## 5. ps

### Command

```bash
ps
```

### Output

```text
    PID TTY          TIME CMD
   7901 pts/1    00:00:00 bash
   7966 pts/1    00:00:00 ps
```

---

## 6. read -p

### Command

```bash
read -p "Enter your name: " kartik
```

### Output

```text
Enter your name: kartik
```

The `read -p` command was used to take input from the user.

---

## 7. Variables

The script uses variables to store and use information such as the username, hostname, current date, and user input.

### Example

```bash
username=$(whoami)
hostname=$(hostname)
current_date=$(date)
```

---

## 8. Output Redirection

The `>` output redirection operator is used to store the running process information in a file.

### Command

```bash
ps > system_info/processes.txt
```

### Output

```text
The running process information is stored in system_info/processes.txt
```

---

## 9. System Information Script

### Command

```bash
./system_info.sh
```

### Output

```text
===== System Information =====
Enter your name: kartik
Name: kartik
Username: khushboo
Hostname: khushboo-HP-Pavilion-Laptop-15-eh1xxx
Current Date: Thu Sep  3 10:57:50 PM IST 2026

===== Disk Usage =====
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           1.5G  2.3M  1.5G   1% /run
/dev/nvme0n1p7   79G   19G   57G  25% /
tmpfs           7.5G   13M  7.5G   1% /dev/shm
tmpfs           5.0M   16K  5.0M   1% /run/lock
efivarfs        128K   52K   72K  43% /sys/firmware/efi/efivars
/dev/nvme0n1p1  256M   93M  164M  37% /boot/efi
tmpfs           1.5G  136K  1.5G   1% /run/user/1000

===== Running Processes =====
    PID TTY          TIME CMD
   8551 pts/0    00:00:00 bash
   8567 pts/0    00:00:00 system_info.sh
   8576 pts/0    00:00:00 ps

Running processes have been stored in system_info/processes.txt
```

---

## Commands and Concepts Used

* `mkdir`
* `touch`
* `echo`
* `df`
* `ps`
* `read -p`
* Variables
* `>` output redirection
