BENCHMARK = 00

N_ELEMS = 1000 2000 5000 10000 20000 50000 100000 200000 500000 1000000

CSVS =
CSVS += benchmark_01_out.csv
CSVS += benchmark_02_out.csv
CSVS += benchmark_03_out.csv
CSVS += benchmark_04_out.csv
CSVS += benchmark_05_out.csv
CSVS += benchmark_06_out.csv
CSVS += benchmark_07_out.csv
CSVS += benchmark_08_out.csv
CSVS += benchmark_09_out.csv
CSVS += benchmark_10_out.csv

all: run

run: benchmark.csv

###############################################################################

benchmark_%.i: ../common/gen.py ../common/base.i template.i
	@python ../common/gen.py -l .. -b common/base.i -t ${BENCHMARK}/template.i n_elems=$(word $*,$(N_ELEMS)) nl_abs_tol=1e-5 > $@

benchmark_09.i: ../common/gen.py ../common/base.i template.i
	@python ../common/gen.py -l .. -b common/base.i -t ${BENCHMARK}/template.i n_elems=$(word 9,$(N_ELEMS)) nl_abs_tol=2e-5 > $@


benchmark.csv: ${CSVS}
	@python ../common/join-serial.py $? > benchmark.csv

benchmark_%_out.csv: benchmark_%.i
	@${BIN} -i $<

.PHONY: clean

clean:
	@rm -f benchmark_*_out.csv
	@rm -f benchmark.csv
	@rm -f benchmark_*.i
