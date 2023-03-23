#!/bin/bash

testLocations=("/mounts/nese-hdd" "/mounts/nese-ssd")

for i in "${testLocations[@]}"
do
    echo "Testing $i..."
    fio --filename=$i/file --size=100m --direct=1 --rw=randread --bs=4k --ioengine=libaio --iodepth=1 --runtime=60 --time_based --group_reporting --name=latency-test-job --write_lat_log=read4k
done
