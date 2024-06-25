# meshfields-docs
documents associated with meshfields field serialization testing

## Build Instructions
The following was tested on NERSC Perlmutter and may require adaptation for use on another system. Should you be working on another system, be sure to alter the filenames to reflect your systems name.

Select or create a directory that will contain all of your source code and build directories. That directory will be referred to as `root` from this point onward.

Create a file named `env_Perlmutter.sh` with the following contents:
```
export root=$PWD

function getname() {
   name=$1
   machine=perlmutter
   buildSuffix=${machine}-cuda
   echo "build-${name}-${buildSuffix}"
 }
export kk=$root/`getname kokkos`/install
export oh=$root/`getname omegah`/install
export cab=$root/`getname cabana`/install
export mf=$root/`getname meshFields`/install
export CMAKE_PREFIX_PATH=$kk:$kk/lib64/cmake:$oh:$cab:$mf/lib64/cmake:$CMAKE_PREFIX_PATH

cm=`which cmake`
echo "cmake: $cm"
echo "kokkos install dir: $kk"
```

Create a file named `cloneBuildAll_Perlmutter.sh` with the following contents:

```
#!/bin/bash -e
#kokkos
cd $root
#tested with kokkos develop@9dff8cc
git clone -b develop git@github.com:kokkos/kokkos.git
cmake -S kokkos -B ${kk%%install} \
   -DCMAKE_BUILD_TYPE="Release" \
   -DCMAKE_CXX_COMPILER=$root/kokkos/bin/nvcc_wrapper \
   -DKokkos_ARCH_AMPERE80=ON \
   -DKokkos_ENABLE_SERIAL=ON \
   -DKokkos_ENABLE_OPENMP=off \
   -DKokkos_ENABLE_CUDA=on \
   -DKokkos_ENABLE_CUDA_LAMBDA=on \
   -DCMAKE_INSTALL_PREFIX=$kk
cmake --build ${kk%%install} -j8 --target install

#omegah
cd $root
git clone git@github.com:SCOREC/omega_h.git
cmake -S omega_h -B ${oh%%install} \
   -DCMAKE_BUILD_TYPE="Release" \
   -DCMAKE_INSTALL_PREFIX=$oh \
   -DBUILD_SHARED_LIBS=OFF \
   -DOmega_h_USE_Kokkos=ON \
   -DOmega_h_USE_CUDA=ON \
   -DOmega_h_CUDA_ARCH=80 \
   -DOmega_h_USE_MPI=ON  \
   -DBUILD_TESTING=OFF \
   -DCMAKE_CXX_COMPILER=CC \
   -DCMAKE_C_COMPILER=cc \
   -DKokkos_PREFIX=$kk/lib64/cmake \
   -DOmega_h_USE_CUDA_AWARE_MPI=ON
cmake --build ${oh%%install} -j20 --target install

#cabana
cd $root
git clone git@github.com:ECP-copa/Cabana.git cabana
cmake -S cabana -B ${cab%%install} \
   -DCMAKE_BUILD_TYPE="Release" \
   -DCMAKE_CXX_COMPILER=$root/kokkos/bin/nvcc_wrapper \
   -DCabana_ENABLE_MPI=OFF \
   -DCabana_ENABLE_CAJITA=OFF \
   -DCabana_ENABLE_TESTING=OFF \
   -DCabana_ENABLE_EXAMPLES=OFF \
   -DCabana_ENABLE_Cuda=ON \
   -DCMAKE_INSTALL_PREFIX=$cab
cmake --build ${cab%%install} -j8 --target install

#meshfields
cd $root
#git clone git@github.com:SCOREC/meshFields
cmake -S meshFields -B ${mf%%install} -DCMAKE_INSTALL_PREFIX=$mf -DCMAKE_CXX_COMPILER=CC
cmake --build ${mf%%install} -j20 --target install
```
Note that any test-specific changes to the build configuration will be noted in the respective tests sub-directory.

Make the script executable:
`chmod +x cloneBuildAll_Perlmutter.sh`
Source the environment script from your chosen working directory:
`source env_Perlutter.sh`
Run the build script:
`./cloneBuildAll_Perlmutter.sh`

### Build MeshFieldsDist
The following assumes that the `env_Perlmutter.sh` file has been `source`d.

```
cmake -S ./meshFieldsDist -B build-meshFieldsDist-cuda \
   -DCMAKE_CXX_COMPILER=CC -DCMAKE_C_COMPILER=cc
cmake --build build-meshFieldDist-cuda
```

## Running Tests
Each sub-directory of this repository contains a `README` file that describes the test and it's dependencies along with a `submit-job.sh` slurm script.