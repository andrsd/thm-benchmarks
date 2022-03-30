#!/usr/bin/env python3

import argparse
import csv
import re

parser = argparse.ArgumentParser(
    prog = 'join-parallel.py',
    description = 'Join CSV files into a one'
)

parser.add_argument(
    'files',
    nargs = '*',
    help = ''
)

args = parser.parse_args()

# this needs to match the N_CPUS variable of the Makefile that produced the CSV
N_CPUS = [1, 2, 4, 8]

all_file_names = vars(args)['files']

print("n_cpus,jac_time,res_time,solve_time")
for filename in all_file_names:
    m = re.match("benchmark.+-(\d+)-out\.csv", filename)
    with open(filename) as f:
        reader = csv.DictReader(f)
        for row in reader:
            print(",".join([str(N_CPUS[int(m.group(1)) - 1]), row['jac_time'], row['res_time'], row['solve_time']]))
