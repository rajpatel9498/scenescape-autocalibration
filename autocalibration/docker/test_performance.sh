#!/bin/bash

# Copyright (C) 2024-2025 Intel Corporation
#
# This software and the related documents are Intel copyrighted materials,
# and your use of them is governed by the express license under which they
# were provided to you ("License"). Unless the License provides otherwise,
# you may not use, modify, copy, publish, distribute, disclose or transmit
# this software or the related documents without Intel's prior written permission.
#
# This software and the related documents are provided as is, with no express
# or implied warranties, other than those that are expressly stated in the License.

set -e

# Configuration
IMAGE=scenescape-camcalibration
VERSION=$(cat ../version.txt)
RESULTS_DIR="performance_results"
ITERATIONS=3

# Create results directory
mkdir -p "$RESULTS_DIR"

# Function to get current timestamp
timestamp() {
    date +%s.%N
}

# Function to format time difference
format_time() {
    local diff=$1
    printf "%.2f seconds" $diff
}

# Function to get container size
get_container_size() {
    local image=$1
    docker image inspect $image --format='{{.Size}}' | numfmt --to=iec-i --suffix=B --format="%.2f"
}

# Function to run a single build test
run_build_test() {
    local test_name=$1
    local build_cmd=$2
    local results_file="$RESULTS_DIR/${test_name}_results.txt"
    
    echo "Running $test_name test..."
    echo "Test: $test_name" > "$results_file"
    echo "Date: $(date)" >> "$results_file"
    echo "----------------------------------------" >> "$results_file"
    
    # Clean up before test
    make clean > /dev/null 2>&1 || true
    
    # Run multiple iterations
    for ((i=1; i<=$ITERATIONS; i++)); do
        echo "Iteration $i of $ITERATIONS"
        
        # Measure build time
        start_time=$(timestamp)
        eval "$build_cmd"
        end_time=$(timestamp)
        build_time=$(echo "$end_time - $start_time" | bc)
        
        # Get container size
        container_size=$(get_container_size "$IMAGE:$VERSION")
        
        # Record results
        echo "Iteration $i:" >> "$results_file"
        echo "Build Time: $(format_time $build_time)" >> "$results_file"
        echo "Container Size: $container_size" >> "$results_file"
        echo "----------------------------------------" >> "$results_file"
        
        # Clean up
        make clean > /dev/null 2>&1 || true
    done
    
    # Calculate and append averages
    echo "Averages:" >> "$results_file"
    avg_time=$(grep "Build Time:" "$results_file" | awk '{sum+=$3} END {print sum/NR}')
    echo "Average Build Time: $(format_time $avg_time)" >> "$results_file"
    echo "----------------------------------------" >> "$results_file"
}

# Test 1: Full build with clean cache
echo "Testing full build with clean cache..."
run_build_test "full_build" "make all"

# Test 2: Build with cache
echo "Testing build with cache..."
run_build_test "cached_build" "make all"

# Test 3: Build stage only
echo "Testing build stage only..."
run_build_test "build_stage" "make build"

# Test 4: Runtime stage only (with cached build)
echo "Testing runtime stage only..."
run_build_test "runtime_stage" "make runtime"

# Test 5: Dependency installation time
echo "Testing dependency installation time..."
run_build_test "deps_install" "docker build --no-cache --target builder -f build/Dockerfile.build ."

# Print summary
echo "----------------------------------------"
echo "Performance Test Summary"
echo "----------------------------------------"
echo "Results are stored in $RESULTS_DIR/"
echo "Check individual test files for detailed metrics"
echo "----------------------------------------"

# Print quick comparison
echo "Quick Comparison:"
for test in full_build cached_build build_stage runtime_stage deps_install; do
    avg_time=$(grep "Average Build Time:" "$RESULTS_DIR/${test}_results.txt" | awk '{print $4}')
    echo "$test: $avg_time"
done 