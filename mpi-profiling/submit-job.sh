#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=00:10:00
#SBATCH --constraint=gpu
#SBATCH --qos=debug
#SBATCH --account=XXXXX
#SBATCH --gpus-per-node=4
# set up for problem & define any environment variables here
export MPICH_GPU_SUPPORT_ENABLED=1

export LD_PRELOAD=./libmpitrace/libmpitrace.so
export SAVE_ALL_TASKS=yes

MeshSize=$1

srun -n 4 -c 1 ./build-meshFieldsDist-cuda/testDist ./test-meshes/GIS-p4-$MeshSize.osh ./test-results/meshes/GIS-p4-$MeshSize-result.vtk
