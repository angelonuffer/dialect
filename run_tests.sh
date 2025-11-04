#!/bin/bash

for test_file in tests/*.0; do
  echo "Running $test_file"
  ./run_test.sh "$test_file"
done
