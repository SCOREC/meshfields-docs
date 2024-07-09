# MPI Profiling
This test is designed to measure how close the Dist structure is to an ideal communication structure. We measure this by comparing the Dist's throughput and latency and comparing it to results obtained from the OSU Micro Benchmarks.

# Dependencies
MPI Profiling data is collected using [libmpitrace](https://github.com/walkup/libmpitrace). The data in this repository was collected using libmpitrace `master@d64cca0`. No modifications to the provided build instructions were required.

The other dependencies were built as specified in the root `README`, using the following sources:
* Kokkos `develop@2035e31`
* Omega_h `master@249fc9f`
  * Note that as a result of issue [102](https://github.com/SCOREC/omega_h/issues/102) Omega_H is currently built without CUDA_AWARE_MPI. Ensure that `DOmega_h_USE_CUDA_AWARE_MPI=OFF` in your build configuration when running this test.
* Cabana `master@0757378`
* MeshFields `main@b676032`

# OSU Benchmarks
Ideal performance was measured using the [OSU Micro-Benchmarks](https://mvapich.cse.ohio-state.edu/benchmarks/) v7.4. The benchmarks were built using the instructions found in the C Benchmarks README. When running the configuration script, be sure to point `CC` and `CXX` must to the cray compiler wrappers `./configure CC=cc CXX=CC`.

The All-to-All (`alltoall`), Bi-Directional Bandwidth (`bibw`), and Latency (`latency`) benchmarks were all run on an interactive node.