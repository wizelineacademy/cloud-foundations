#!/bin/bash

RSA_FILENAME=academy-user-rsa
COUNT="${1}"
echo $COUNT


[ -z "${COUNT}" ] && exit 1

[[ ! ${COUNT} =~ ^[[:digit:]]+$ ]] && exit 1

pushd keys
for x in $(seq 0 $COUNT); do
  echo y | ssh-keygen -t rsa -f "${RSA_FILENAME}-${x}" -q -N "" -b 2048 -C "academy@wizeline"
  openssl rsa -in "${RSA_FILENAME}-${x}" -outform pem >"${RSA_FILENAME}-${x}.pem"
  echo "academy-user-${x}:$(cat ${RSA_FILENAME}-${x}.pub)" >gcloud-ssh-${RSA_FILENAME}-${x}
  echo gcloud compute instances add-metadata "lab-machine-${x}" --metadata-from-file ssh-keys=keys/gcloud-ssh-${RSA_FILENAME}-${x} >>../add-gcloud-ssh
  chmod 600 *.pem "${RSA_FILENAME}-${x}" *.pub
done
popd
