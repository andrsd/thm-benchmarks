#!/usr/bin/env python3

import argparse
import csv
import re

parser = argparse.ArgumentParser(
    prog = 'join.py',
    description = 'Join CSV files into a one'
)

parser.add_argument(
    'files',
    nargs = '*',
    help = ''
)

args = parser.parse_args()

all_file_names = vars(args)['files']

print("num_elems,jac_time,res_time,solve_time")
for filename in all_file_names:
    with open(filename) as f:
        reader = csv.DictReader(f)
        for row in reader:
            print(",".join([row['num_elems'], row['jac_time'], row['res_time'], row['solve_time']]))
