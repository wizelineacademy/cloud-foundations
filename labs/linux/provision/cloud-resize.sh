#!/bin/bash

COUNT="${1}"
echo $COUNT

[ -z "${COUNT}" ] && exit 1

[[ ! ${COUNT} =~ ^[[:digit:]]+$ ]] && exit 1

for i in $(seq 0 ${COUNT}); do
  gcloud compute disks  resize lab-machine-${i} --size 15 --zone us-west1-b -q
done
