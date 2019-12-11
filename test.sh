#!/bin/bash
TIMEFORMAT=%R
#echo "Compiling openmp..."
#g++ -O2 -o p2omp -std=c++14 -fopenmp p2.cpp

#echo "Compiling mpi..."
#mpic++ -o p2mpi -std=c++14 p2mpi.cpp 

for l in 1 2 3
do
  echo ""
  for n in 1 2 4 8 16 32 64
  do
    #echo -n "[OpenMP] $n thread ($l. test): "
    #time ./p2omp $n
    echo -n "[MPI] $n thread ($l. test): "
    time mpiexec -n $n Task2.exe 
  done
done
sleep 100