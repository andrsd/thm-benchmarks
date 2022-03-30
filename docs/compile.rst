How to execute these benchmarks
===============================

1. Build thermal hydraulics module

   .. code-block::

      cd /path/to/moose/modules/thermal_hydraulics
      make

2. Setup environment

   .. code-block::

      export BIN=/path/to/thermal_hydraulics-opt

3. Execute benchmark

   .. code-block::

      cd benchmarks/<number>
      make
