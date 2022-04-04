How to execute these benchmarks
===============================

1. Build thermal hydraulics module

   .. code-block::

      cd /path/to/moose/modules/thermal_hydraulics
      make

2. Setup environment

   Either have `/path/to/moose/modules/thermal_hydraulics` in your `PATH` or export `BIN` variable:

   .. code-block::

      export BIN=/path/to/thermal_hydraulics-opt

   The benchmarks rely on existence of the `benchmarks/env.mk` file.
   There are pre-defined ones available in `benchmarks` directory.
   They are called `env-<name>.mk`.
   You will need to use one or build your own.

3. Execute benchmark

   .. code-block::

      cd benchmarks/<number>
      make
