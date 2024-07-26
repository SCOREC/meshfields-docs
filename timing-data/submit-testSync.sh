#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=00:10:00
#SBATCH --constraint=gpu
#SBATCH --qos=debug
#SBATCH --account=XXXXX
#SBATCH --gpus-per-node=4
#SBATCH --gpu-bind=none
# set up for problem & define any environment variables here
export MPICH_GPU_SUPPORT_ENABLED=1
export KOKKOS_TOOLS_LIBS=$root/build-kokkos-tools-perlmutter/profiling/simple-kernel-timer/libkp_kernel_timer.so
bin=/pscratch/sd/c/ckegel/Dist-Sync-Testing/build-meshFieldsDist-cuda/testSync

MeshSize=$1

dir=${SLURM_JOB_ID}-syncTest-$MeshSize/time_pool
mkdir -p $dir
srun -n 4 -c 1 --chdir $dir --output=time_pool.%t $bin $root/test-meshes/GIS-p4-$MeshSize.osh $root/test-results/meshes/GIS-p4-$MeshSize-result.vtk --osh-pool
cd $dir
$root/build-kokkos-tools-perlmutter/profiling/simple-kernel-timer/kp_json_writer nid* > ./timing.json
cd $root

dir=${SLURM_JOB_ID}-syncTest-$MeshSize/time
mkdir -p $dir
srun -n 4 -c 1 --chdir $dir --output=time.%t $bin $root/test-meshes/GIS-p4-$MeshSize.osh $root/test-results/meshes/GIS-p4-$MeshSize-result.vtk
cd $dir
$root/build-kokkos-tools-perlmutter/profiling/simple-kernel-timer/kp_json_writer nid* > ./timing.json
cd $root
