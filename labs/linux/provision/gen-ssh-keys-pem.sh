#!/bin/bash

RSA_FILENAME=academy-user-rsa
COUNT="${1}"
echo $COUNT


[ -z "${COUNT}" ] && exit 1

[[ ! ${COUNT} =~ ^[[:digit:]]+$ ]] && exit 1

pushd keys
for x in $(seq 0 $COUNT); do
  ssh-keygen -t rsa -f "${RSA_FILENAME}-${x}" -q -N "" -b 2048 -y
  openssl rsa -in "${RSA_FILENAME}-${x}" -outform pem >"${RSA_FILENAME}-${x}.pem"
done
popd
