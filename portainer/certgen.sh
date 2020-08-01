#!/bin/bash

if test -f "portainer.key"; then
    echo "Portainer certificates already exist"
    exit 0
fi

openssl genrsa -out portainer.key 2048
openssl ecparam -genkey -name secp384r1 -out portainer.key
openssl req -new -x509 -sha256 -key portainer.key -out portainer.crt -days 3650
