#!/bin/bash

find . -type f -printf "%s\n" > file_sizes.txt

# MEAN, MEDIAN
python3 -c "import statistics; sizes = [int(line.strip()) for line in open('file_sizes.txt')]; print('Mean:', statistics.mean(sizes)); print('Median:', statistics.median(sizes))" > stats.txt

# MODE
python3 -c "import statistics; sizes = [int(line.strip()) for line in open('file_sizes.txt')]; print('Mode:', statistics.mode(sizes))" >> stats.txt

