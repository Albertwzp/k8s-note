#! /bin/bash

function get_info() {
echo -n '' >map.txt
docker ps -a |grep -v 'CONTAINER ID' | grep -v 'goharbor/' | while read line; do
    k8s_ns=$(echo $line | awk '{print $NF}' | awk -F_ '{print $4}')
    pod=$(echo $line | awk '{print $NF}' $i | awk -F_ '{print $3}')
    contain_id=$(echo $line | awk '{print $1}')
    full_id=$(docker inspect -f '{{.ID}}' $contain_id)
#    cmd=$(docker top $contain_id |akw '{print $NF}')
    if [ -f /run/runc/$full_id/state.json ]; then
        pid=$(cat /run/runc/$full_id/state.json  |jq '.init_process_pid')
        sid=$(cat /run/runc/$full_id/state.json  |jq '.init_process_start')
        ns=$(ls -l /proc/$pid/ns/ |grep pid |awk -F: '{print $3}')
    else
        pid='?'
        sid='?'
        ns='?'
    fi
    echo "$k8s_ns $pod $contain_id  $pid $ns" >>map.txt
done
sort -k 1 -k2 -k 4n map.txt -o map.txt
}

if [ ! -f map.txt ]; then
    get_info
fi
if [ -d /proc/$1 ]; then
    echo 'K8S_NS POD containerID PID [0PID_NS]'
    pid_ns=$(ls -l /proc/$1/ns |grep pid |awk -F: '{print $3}' |sed 's/\[//' |sed 's/\]//')
    grep $pid_ns map.txt
else
    echo 'process not run by k8s or docker'
fi
