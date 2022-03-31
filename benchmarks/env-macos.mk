BIN ?= thermal_hydraulics-opt
# Number of CPUs use in both strong and weak scaling study
N_CPUS = 1 2 4 8

CSVS_STRONG =
CSVS_STRONG += benchmark-strong-1-out.csv
CSVS_STRONG += benchmark-strong-2-out.csv
CSVS_STRONG += benchmark-strong-3-out.csv
CSVS_STRONG += benchmark-strong-4-out.csv

CSVS_WEAK =
CSVS_WEAK += benchmark-weak-1-out.csv
CSVS_WEAK += benchmark-weak-2-out.csv
CSVS_WEAK += benchmark-weak-3-out.csv
CSVS_WEAK += benchmark-weak-4-out.csv
