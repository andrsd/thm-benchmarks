BENCHMARK = 05

include ../env.mk

CONF=10x10
CONF_FILE=${CONF}-conf.py
# Number of elements used in strong scaling study
N_ELEMS_FCH_STRONG = 1000
# Number of elements used in weak scaling study
N_ELEMS_FCH_WEAK = 100 200 400 800 1600 3200 6400 12800 25600
N_SM_ELEMS_WEAK = 1 2 4 8 16 32 64 128 256

all: run

run: benchmark-strong.csv benchmark-weak.csv

###############################################################################

# strong scaling

block.jou: ../common/gen.py ${CONF}.jou.template
	@python ../common/gen.py -l . -t ${CONF}.jou.template \
		mesh_file=block.e \
		n_axial_elems=${N_ELEMS_FCH_STRONG} > $@

block.e: block.jou
	@echo Meshing block.e
	@cubitclx -noecho -nojournal block.jou > /dev/null

benchmark-strong.csv: ${CSVS_STRONG}
	@python ../common/join-parallel.py $? > $@

benchmark-strong-%-out.csv: benchmark-strong.i
	@mpirun -np $(word $*,$(N_CPUS)) ${MPI_FLAGS} ${BIN} -i $< Outputs/out/file_base=benchmark-strong-$*-out

benchmark-strong.i: ../common/gen.py ../common/base.i template.i ${CONF_FILE} block.e
	@python ../common/gen.py -l .. -b common/base.i -t ${BENCHMARK}/template.i -f ${CONF_FILE} \
		mesh_file=block.e \
		n_axial_elems=${N_ELEMS_FCH_STRONG} > $@

# weak scaling

block-%.jou: ../common/gen.py ${CONF}.jou.template
	@python ../common/gen.py -l . -t ${CONF}.jou.template \
		mesh_file=block-$*.e \
		n_axial_elems=$(word $*,$(N_ELEMS_FCH_WEAK)) > $@

block-%.e: block-%.jou
	@echo Meshing block-$*.e
	@cubitclx -noecho -nojournal block-$*.jou &> /dev/null

benchmark-weak.csv: ${CSVS_WEAK}
	@python ../common/join-parallel.py $? > $@

benchmark-weak-%-out.csv: benchmark-weak-%.i
	@mpirun -np $(word $*,$(N_CPUS)) ${MPI_FLAGS} ${BIN} -i $< Outputs/out/file_base=benchmark-weak-$*-out

benchmark-weak-%.i: ../common/gen.py ../common/base.i template.i block-%.e ${CONF_FILE}
	@python ../common/gen.py -l .. -b common/base.i -t ${BENCHMARK}/template.i -f ${CONF_FILE} \
		mesh_file=block-$*.e \
		n_axial_elems=$(word $*,$(N_ELEMS_FCH_WEAK)) \
		n_sm_elems=$(word $*,$(N_SM_ELEMS_WEAK)) \
		> $@

# clean

clean:
	@rm -f benchmark-strong.i
	@rm -f benchmark-strong*.csv
	@rm -f benchmark-weak-*.i
	@rm -f benchmark-weak*.csv
	@rm -f block*.e
	@rm -f block*.jou
