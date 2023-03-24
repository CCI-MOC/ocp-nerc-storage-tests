#!/bin/bash

testLocations=("/mounts/nese-hdd" "/mounts/nese-ssd")
fioTests=(
    "--size=100m --direct=1 --rw=randread --bs=4k --ioengine=libaio --iodepth=1 --runtime=60 --time_based --group_reporting --name=latency-test-job --write_lat_log=read4k"
    "--size=100m --direct=1 --rw=randread --bs=4k --ioengine=libaio --iodepth=8 --runtime=60 --time_based --group_reporting --name=latency-test-job --write_lat_log=read4k"
    "--size=100m --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=1 --runtime=60 --time_based --group_reporting --name=latency-test-job --write_lat_log=read4k"
)

for i in "${testLocations[@]}"
do
    printf "Starting FIO tests on $i\n"

    cur_index=0
    for j in "${fioTests[@]}"
    do
        printf "\nTest $cur_index Arguments: $j\n\n"
        fio --filename=$i/file$cur_index $j
        cur_index=$((cur_index + 1))
    done

    printf "\nFIO tests on $i complete\n\n"
done

# Keep container running (24 hours each loop)
while true; do
  sleep 86400
done
