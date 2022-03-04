#!/bin/bash

source $MODULESHOME/init/bash
module purge
module load DefApps xl cuda cmake

../../cmakeclean.sh

unset GATOR_DISABLE

export CC=mpicc
export CXX=mpic++
export FC=mpif90
unset CXXFLAGS
unset FFLAGS

cmake -DYAKL_CXX_FLAGS="-O3" \
      -DYAKL_F90_FLAGS="-O3"                          \
      -DYAKL_C_FLAGS="-O3"                            \
      -DMPI_COMMAND="jsrun -n 1 -c 1 -a 1 -g 1" \
      ../../..

