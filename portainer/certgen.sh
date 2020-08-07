#!/bin/bash

DOMAIN_NAME=portainer.docker

if test -f "$DOMAIN_NAME.key"; then
    echo "Portainer certificates already exist"
    exit 0
fi

openssl genrsa -out $DOMAIN_NAME.key 2048
openssl ecparam -genkey -name secp384r1 -out $DOMAIN_NAME.key
openssl req -new -x509 -sha256 -key $DOMAIN_NAME.key -out $DOMAIN_NAME.crt -days 3650 -subj "/C=CA/ST=/L=/O=/OU=/CN=$DOMAIN_NAME"
