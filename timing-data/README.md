# Timing Data Tests
This test is designed to measure the duration the MeshField `Serialize` and `Deserialize` operations. The data is output to a JSON file for easy use with scripts and data analysis programs.

## Dependencies
The timing data is collected using the Kokkos Tools library - specifically the `simple-kernel-timer` and `kp_json_writer`.
Follow the [kokkos-tools](https://github.com/kokkos/kokkos-tools) instructions to build and install the library. Note that these tests were conducted using kokkos-tools `develop@dd39767`.

The other dependencies were built as specified in the root `README`, using the following sources:
* Kokkos `develop@2035e31`
* Omega_h `master@249fc9f`
* Cabana `master@0757378`
* MeshFields `main@b676032`


## Measuring Kernel Timer Overhead
To determine the accuracy of the results gathered, it is important to measure any overhead added by the `simple-kernel-timer`. This is achieved using a `Kokkos::Timer` embedded in the test code. Comparison files were manually compiled using the output of the standard tests and the output of tests run using the `submit-timer-overhead.sh`.