#/bin/bash
KP_READER=/pscratch/sd/c/ckegel/Dist-Sync-Testing/build-kokkos-tools-perlmutter/profiling/simple-kernel-timer/kp_json_writer
cat /dev/null > allTimings.txt
for mesh in 40k 160k 600k 2-5M 10M 40M 160M; do
  $KP_READER $mesh/*.dat > $mesh/timings.json
  echo $mesh
  cat /dev/null > $mesh/timings.txt
  for kernel in meshField-sync meshField-Serialize meshField-Deserialize; do
    grep -A 4 $kernel $mesh/timings.json  | awk '/time-per-call/ {print $2}' >> $mesh/timings.txt
  done
  paste allTimings.txt $mesh/timings.txt > tmp.txt
  mv tmp.txt	allTimings.txt
done

