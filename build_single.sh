#!/bin/bash

# Exit on any error
set -e

# Function to convert test name to directory name
# e.g., LB+poss -> LB-poss
convert_name() {
    echo "$1" | tr '+' '-'
}

# For each hw-single-test-src-* directory
for src_dir in hw-single-test-src-*; do
    if [ -d "$src_dir" ]; then
        # Extract test name (e.g., LB+poss from hw-single-test-src-LB+poss)
        test_name=${src_dir#hw-single-test-src-}

        # Find the corresponding litmus file
        litmus_file=$(find . -name "${test_name}.litmus")
        if [ -z "$litmus_file" ]; then
            echo "Warning: Could not find litmus file for ${test_name}"
            continue
        fi

        echo "Processing test: ${test_name}"

        # Step 1: Copy to hw-single-test-src
        rm -rf hw-single-test-src
        cp -r "$src_dir" hw-single-test-src

        # Step 2: Run make command
        echo "Building test..."
        make hw-single-test LITMUSFILE="$(pwd)/${litmus_file}" CORES=4 GCC=riscv64-unknown-linux-gnu-gcc -j30

        # Step 3: Copy to final destination
        dest_dir="hw-single-test-$(convert_name ${test_name})"
        rm -rf "$dest_dir"
        cp -r hw-single-test "$dest_dir"

        echo "Completed processing ${test_name}"
        echo "----------------------------------------"
    fi
done

# Cleanup
rm -rf hw-single-test-src hw-single-test

echo "All tests processed successfully"