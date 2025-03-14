#!/bin/bash
set -x
if [ -z "$1" ]; then
    echo "Usage: $0 <group_number (1-10)>"
    exit 1
fi

if [[ "$1" -lt 1 || "$1" -gt 10 ]]; then
    echo "Error: Group number must be between 1 and 10"
    exit 1
fi

st_values=(1 2 3 4 5 6 7 8 31 133)
s_values=("5k" "50k" "500k" "10k" "100k" "5k" "1M")
r_values=("20" "200" "20" "1k" "100" "2k" "10")

total_tests=${#st_values[@]}
tests_per_group=$(( (total_tests + 9) / 10 ))

start_index=$(( ( $1 - 1 ) * tests_per_group ))
end_index=$(( start_index + tests_per_group ))
if [ $end_index -gt $total_tests ]; then
    end_index=$total_tests
fi

echo "Running tests for Group $1"

for (( st_idx=$start_index; st_idx<$end_index; st_idx++ )); do
    st=${st_values[$st_idx]}
    for i in "${!s_values[@]}"; do
        size=${s_values[$i]}
        repeat=${r_values[$i]}
        echo "Running: ./run.exe -st $st -s $size -r $repeat > \"run_${st}_${size}_${repeat}.log\""
        /sifive/litmus/run.exe -st $st -s $size -r $repeat > /home/root/litmus/run_${st}_${size}_${repeat}.log
    done
done