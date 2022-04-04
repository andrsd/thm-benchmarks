RSTS =
RSTS += index.rst
RSTS += compile.rst
RSTS += envs.rst
RSTS += benchmarks/00.rst
RSTS += benchmarks/01.rst
RSTS += benchmarks/02.rst
RSTS += benchmarks/03.rst
RSTS += benchmarks/04.rst
RSTS += benchmarks/05.rst
RSTS += benchmarks/50.rst


all:: html

html: conf.py $(RSTS)
	@sphinx-build -b html . html

clean:
	@rm -rf html
