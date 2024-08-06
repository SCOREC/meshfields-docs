#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=00:10:00
#SBATCH --constraint=gpu
#SBATCH --qos=debug
#SBATCH --account=m4274
#SBATCH --gpus-per-node=4
#SBATCH --gpu-bind=none
# set up for problem & define any environment variables here
export MPICH_GPU_SUPPORT_ENABLED=1
#export KOKKOS_TOOLS_LIBS=${root}/build-kokkos-tools-perlmutter/profiling/simple-kernel-timer/libkp_kernel_timer.so

MeshSize=160M
dir=${SLURM_JOB_ID}-testDist-sweep/${MeshSize}
mkdir -p $dir
srun -n 4 -c 1 --chdir $dir ${root}/build-meshFieldsDist-cuda/testDist ${root}/test-meshes/GIS-p4-$MeshSize.osh ./GIS-p4-$MeshSize-result.vtk --osh-pool

MeshSize=40M
dir=${SLURM_JOB_ID}-testDist-sweep/${MeshSize}
mkdir -p $dir
srun -n 4 -c 1 --chdir $dir ${root}/build-meshFieldsDist-cuda/testDist ${root}/test-meshes/GIS-p4-$MeshSize.osh ./GIS-p4-$MeshSize-result.vtk --osh-pool

MeshSize=10M
dir=${SLURM_JOB_ID}-testDist-sweep/${MeshSize}
mkdir -p $dir
srun -n 4 -c 1 --chdir $dir ${root}/build-meshFieldsDist-cuda/testDist ${root}/test-meshes/GIS-p4-$MeshSize.osh ./GIS-p4-$MeshSize-result.vtk --osh-pool

MeshSize=2-5M
dir=${SLURM_JOB_ID}-testDist-sweep/${MeshSize}
mkdir -p $dir
srun -n 4 -c 1 --chdir $dir ${root}/build-meshFieldsDist-cuda/testDist ${root}/test-meshes/GIS-p4-$MeshSize.osh ./GIS-p4-$MeshSize-result.vtk --osh-pool

MeshSize=600k
dir=${SLURM_JOB_ID}-testDist-sweep/${MeshSize}
mkdir -p $dir
srun -n 4 -c 1 --chdir $dir ${root}/build-meshFieldsDist-cuda/testDist ${root}/test-meshes/GIS-p4-$MeshSize.osh ./GIS-p4-$MeshSize-result.vtk --osh-pool

MeshSize=160k
dir=${SLURM_JOB_ID}-testDist-sweep/${MeshSize}
mkdir -p $dir
srun -n 4 -c 1 --chdir $dir ${root}/build-meshFieldsDist-cuda/testDist ${root}/test-meshes/GIS-p4-$MeshSize.osh ./GIS-p4-$MeshSize-result.vtk --osh-pool

MeshSize=40k
dir=${SLURM_JOB_ID}-testDist-sweep/${MeshSize}
mkdir -p $dir
srun -n 4 -c 1 --chdir $dir ${root}/build-meshFieldsDist-cuda/testDist ${root}/test-meshes/GIS-p4-$MeshSize.osh ./GIS-p4-$MeshSize-result.vtk --osh-pool
