#!/bin/bash

echo "===== System Information ====="

read -p "Enter your name: " name

username=$(whoami)
hostname=$(hostname)
current_date=$(date)

echo "Name: $name"
echo "Username: $username"
echo "Hostname: $hostname"
echo "Current Date: $current_date"

echo ""
echo "===== Disk Usage ====="
df -h

mkdir -p system_info
touch system_info/processes.txt

ps > system_info/processes.txt

echo ""
echo "===== Running Processes ====="
cat system_info/processes.txt

echo ""
echo "Running processes have been stored in system_info/processes.txt"