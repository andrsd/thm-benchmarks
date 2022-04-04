BENCHMARK = 04

include ../env.mk

# Number of elements used in strong scaling study
N_ELEMS_FCH_STRONG = 10000
# Number of elements used in weak scaling study
N_ELEMS_FCH_WEAK = 1000 2000 4000 8000 16000 32000 64000 128000 256000

all: run

run: benchmark-strong.csv benchmark-weak.csv

###############################################################################

benchmark-strong.csv: ${CSVS_STRONG}
	@python ../common/join-parallel.py $? > $@

benchmark-strong-%-out.csv: benchmark-strong.i
	@mpirun -np $(word $*,$(N_CPUS)) ${MPI_FLAGS} ${BIN} -i $< Outputs/out/file_base=benchmark-strong-$*-out

benchmark-strong.i: ../common/gen.py ../common/base.i template.i
	@python ../common/gen.py -l .. -b common/base.i -t ${BENCHMARK}/template.i \
		n_elems=${N_ELEMS_FCH_STRONG} \
		> $@


# weak scaling

benchmark-weak.csv: ${CSVS_WEAK}
	@python ../common/join-parallel.py $? > $@

benchmark-weak-%-out.csv: benchmark-weak-%.i
	@mpirun -np $(word $*,$(N_CPUS)) ${MPI_FLAGS} ${BIN} -i $< Outputs/out/file_base=benchmark-weak-$*-out

benchmark-weak-%.i: ../common/gen.py ../common/base.i template.i
	@python ../common/gen.py -l .. -b common/base.i -t ${BENCHMARK}/template.i \
		n_elems=$(word $*,$(N_ELEMS_FCH_WEAK)) \
		> $@

# clean

clean:
	@rm -f benchmark-strong.i
	@rm -f benchmark-strong*.csv
	@rm -f benchmark-weak-*.i
	@rm -f benchmark-weak*.csv
