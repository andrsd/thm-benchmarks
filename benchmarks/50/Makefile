BENCHMARK = 50

all: run

run: benchmark_out.csv

###############################################################################

benchmark.i: ../common/gen.py ../common/base.i template.i
	@python ../common/gen.py -l .. -t ${BENCHMARK}/template.i \
		num_steps=1000 > $@

benchmark_out.csv: benchmark.i
	@${BIN} -i $<

clean:
	@rm -f benchmark_out.csv
	@rm -f benchmark.i
