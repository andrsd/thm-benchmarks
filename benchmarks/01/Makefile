BENCHMARK = 01

include ../env.mk

all: run

run: benchmark-strong.csv benchmark-weak.csv

###############################################################################

benchmark-strong.csv: ${CSVS_STRONG}
	@python ../common/join-parallel.py $? > $@

benchmark-strong-%-out.csv: benchmark-strong.i
	@mpirun -np $(word $*,$(N_CPUS)) ${BIN} -i $< Outputs/out/file_base=benchmark-strong-$*-out

benchmark-strong.i: ../common/gen.py ../common/base.i template.i
	@python ../common/gen.py -l .. -b common/base.i -t ${BENCHMARK}/template.i n_elems=${N_ELEMS_STRONG} nl_abs_tol=1e-5 > $@


# weak scaling

benchmark-weak.csv: ${CSVS_WEAK}
	@python ../common/join-parallel.py $? > $@

benchmark-weak-%-out.csv: benchmark-weak-%.i
	@mpirun -np $(word $*,$(N_CPUS)) ${BIN} -i $< Outputs/out/file_base=benchmark-weak-$*-out

benchmark-weak-%.i: ../common/gen.py ../common/base.i template.i
	@python ../common/gen.py -l .. -b common/base.i -t ${BENCHMARK}/template.i n_elems=$(word $*,$(N_ELEMS_WEAK)) nl_abs_tol=1e-5 > $@

# clean

clean:
	@rm -f benchmark-strong.i
	@rm -f benchmark-strong*.csv
	@rm -f benchmark-weak-*.i
	@rm -f benchmark-weak*.csv
