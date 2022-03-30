BIN ?= thermal_hydraulics-opt
# Number of CPUs use in both strong and weak scaling study
N_CPUS = 1 2 4 8

# Number of elements used in strong scaling study
# N_ELEMS_STRONG = 1000000
N_ELEMS_STRONG = 10000

CSVS_STRONG =
CSVS_STRONG += benchmark-strong-1-out.csv
CSVS_STRONG += benchmark-strong-2-out.csv
CSVS_STRONG += benchmark-strong-3-out.csv
CSVS_STRONG += benchmark-strong-4-out.csv

# Number of elements used in weak scaling study
# N_ELEMS_WEAK = 10000 20000 40000 80000 160000
N_ELEMS_WEAK = 1000 2000 4000 8000
CSVS_WEAK =
CSVS_WEAK += benchmark-weak-1-out.csv
CSVS_WEAK += benchmark-weak-2-out.csv
CSVS_WEAK += benchmark-weak-3-out.csv
CSVS_WEAK += benchmark-weak-4-out.csv
