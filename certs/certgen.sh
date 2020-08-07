#!/bin/bash

source ../.env-traefik

function generateCerts {
    openssl genrsa -out $1.key 2048
    openssl ecparam -genkey -name secp384r1 -out $1.key
    openssl req -new -x509 -sha256 -key $1.key -out $1.crt -days 3650 -subj "/C=CA/ST=/L=/O=/OU=/CN=$1"
}

# Generate Portainer certs
PORTAINER_CERT_FILE_NAME=portainer.$DOMAIN_NAME_EXTENSION
if test -f "$PORTAINER_CERT_FILE_NAME.key"; then
    echo "Portainer certificates already exist"
else
    generateCerts $PORTAINER_CERT_FILE_NAME
fi

# Generate Traefik certs
TRAEFIK_CERT_FILE_NAME=traefik.$DOMAIN_NAME_EXTENSION
if test -f "$TRAEFIK_CERT_FILE_NAME.key"; then
    echo "Traefik certificates already exist"
else
    generateCerts $TRAEFIK_CERT_FILE_NAME
fi
