#!/bin/bash

DOMAIN_NAME_EXTENSION=docker

# Generate Portainer certs
PORTAINER_CERT_FILE_NAME=portainer.$DOMAIN_NAME_EXTENSION
if test -f "$PORTAINER_CERT_FILE_NAME.key"; then
    echo "Portainer certificates already exist"
fi

openssl genrsa -out $PORTAINER_CERT_FILE_NAME.key 2048
openssl ecparam -genkey -name secp384r1 -out $PORTAINER_CERT_FILE_NAME.key
openssl req -new -x509 -sha256 -key $PORTAINER_CERT_FILE_NAME.key -out $PORTAINER_CERT_FILE_NAME.crt -days 3650 -subj "/C=CA/ST=/L=/O=/OU=/CN=$PORTAINER_CERT_FILE_NAME"

# Generate Traefik certs
TRAEFIK_CERT_FILE_NAME=traefik.$DOMAIN_NAME_EXTENSION
if test -f "$TRAEFIK_CERT_FILE_NAME.key"; then
    echo "Traefik certificates already exist"
fi

openssl genrsa -out $TRAEFIK_CERT_FILE_NAME.key 2048
openssl ecparam -genkey -name secp384r1 -out $TRAEFIK_CERT_FILE_NAME.key
openssl req -new -x509 -sha256 -key $TRAEFIK_CERT_FILE_NAME.key -out $TRAEFIK_CERT_FILE_NAME.crt -days 3650 -subj "/C=CA/ST=/L=/O=/OU=/CN=$TRAEFIK_CERT_FILE_NAME"