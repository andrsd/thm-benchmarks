BIN ?= thermal_hydraulics-opt
# Number of CPUs use in both strong and weak scaling study
N_CPUS = 1 2 4 8 16 32 64 128 256

CSVS_STRONG =
CSVS_STRONG += benchmark-strong-1-out.csv
CSVS_STRONG += benchmark-strong-2-out.csv
CSVS_STRONG += benchmark-strong-3-out.csv
CSVS_STRONG += benchmark-strong-4-out.csv
CSVS_STRONG += benchmark-strong-5-out.csv
CSVS_STRONG += benchmark-strong-6-out.csv
CSVS_STRONG += benchmark-strong-7-out.csv
CSVS_STRONG += benchmark-strong-8-out.csv
CSVS_STRONG += benchmark-strong-9-out.csv

CSVS_WEAK =
CSVS_WEAK += benchmark-weak-1-out.csv
CSVS_WEAK += benchmark-weak-2-out.csv
CSVS_WEAK += benchmark-weak-3-out.csv
CSVS_WEAK += benchmark-weak-4-out.csv
CSVS_WEAK += benchmark-weak-5-out.csv
CSVS_WEAK += benchmark-weak-6-out.csv
CSVS_WEAK += benchmark-weak-7-out.csv
CSVS_WEAK += benchmark-weak-8-out.csv
CSVS_WEAK += benchmark-weak-9-out.csv

MPI_FLAGS="-ppn 32"
