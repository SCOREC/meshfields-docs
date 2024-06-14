#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=00:10:00
#SBATCH --constraint=gpu
#SBATCH --qos=debug
#SBATCH --account=m4274
#SBATCH --gpus-per-node=4
# set up for problem & define any environment variables here
export MPICH_GPU_SUPPORT_ENABLED=1
export KOKKOS_TOOLS_LIBS=./build-kokkos-tools-perlmutter/profiling/simple-kernel-timer/libkp_kernel_timer.so

export LD_PRELOAD=./libmpitrace/libmpitrace.so

MeshSize=$1

srun -n 4 -c 1 ./build-meshFieldDist-Perlmutter/testDist ./test-meshes/GIS-p4-$MeshSize.osh ./test-results/meshes/GIS-p4-$MeshSize-result.vtk
./build-kokkos-tools-perlmutter/profiling/simple-kernel-timer/kp_json_writer nid* > ./test-results/timing/$MeshSize-timing.json
rm -r nid*
