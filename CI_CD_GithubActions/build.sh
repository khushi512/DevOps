#!/bin/bash
set -e

echo "Starting application build..."

rm -rf build
mkdir -p build

cp app/calculator.py build/calculator.py

echo "Build completed successfully" > build/build-info.txt
echo "Build timestamp: $(date -u)" >> build/build-info.txt
echo "Python version: $(python --version 2>&1)" >> build/build-info.txt

echo "Build artifacts created:"
ls -la build
