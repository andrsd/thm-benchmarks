Thermal Hydraulics Module Benchmarks
====================================

Thermal Hydraulics Module is part of Multi-physics Object-Oriented Simulation Environment (MOOSE_)

The following list of benchmarks were performed:

1. :doc:`benchmarks/00`
2. :doc:`benchmarks/01`
3. :doc:`benchmarks/02`
4. :doc:`benchmarks/03`
5. :doc:`benchmarks/04`
6. :doc:`benchmarks/05`
7. :doc:`benchmarks/50`

.. toctree::
   :maxdepth: 1
   :hidden:
   :caption: Benchmarks

   benchmarks/00
   benchmarks/01
   benchmarks/02
   benchmarks/03
   benchmarks/04
   benchmarks/05
   benchmarks/50


.. toctree::
   :maxdepth: 1
   :hidden:
   :caption: Procedure

   compile.rst


Test environment
----------------

.. tabs::

   .. tab:: macOS

      Software:

      ==============  ============
      OS              macOS Monterrey 12.2.1
      compiler        clang-12.0.1
      MPICH           3.3
      PETSc version   3.14.2
      libMesh         FIXME
      MOOSE version   FIXME

      ==============  ============

      Hardware:

      ==============  ========
      CPU             2.4 GHz 8-Core Intel Core i9
      Memory          32 GB 2400 MHz DDR4
      ==============  ========

   .. tab:: lemhi

      Software

      =============  =======
      OS             CentOS 7.6 operating system
      compiler       gcc-9.4.0
      MVAPICH        2.3.6
      PETSc version  3.15.1
      libMesh        FIXME
      MOOSE          FIXME
      =============  =======

      Hardware:

      ========  =========
      CPU       2 Intel Xeon Gold 6148 CPUs (20 cores per CPU), 2.40 GHz
      Chipset   Skylake
      Memory    192 GB of 2666MHz DDR4 RAM
      ========  =========

.. _MOOSE: https://mooseframework.inl.gov/
