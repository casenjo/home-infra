#!/bin/bash

source env-traefik

function updateTraefikConfigs {
    sed "s/DOCKER_DOMAIN_NAME_EXTENSION/$DOCKER_DOMAIN_NAME_EXTENSION/g" traefik/dynamic.toml.template > traefik/dynamic.toml
    sed "s/DOCKER_DOMAIN_NAME_EXTENSION/$DOCKER_DOMAIN_NAME_EXTENSION/g" traefik/traefik.toml.template > traefik/traefik.toml
}

function generateCerts {
    openssl genrsa -out certs/$1.key 2048
    openssl ecparam -genkey -name secp384r1 -out certs/$1.key
    openssl req -new -x509 -sha256 -key certs/$1.key -out certs/$1.crt -days 3650 -subj "/C=CA/ST=/L=/O=/OU=/CN=$1"
}

# Generate Portainer certs
PORTAINER_CERT_FILE_NAME=portainer.$DOCKER_DOMAIN_NAME_EXTENSION
if test -f "certs/$PORTAINER_CERT_FILE_NAME.key"; then
    echo "Portainer certificates already exist"
else
    generateCerts $PORTAINER_CERT_FILE_NAME
fi

# Generate Traefik certs
TRAEFIK_CERT_FILE_NAME=traefik.$DOCKER_DOMAIN_NAME_EXTENSION
if test -f "certs/$TRAEFIK_CERT_FILE_NAME.key"; then
    echo "Traefik certificates already exist"
else
    generateCerts $TRAEFIK_CERT_FILE_NAME
fi

# Generate Pi-Hole certs
PIHOLE_CERT_FILE_NAME=pihole.$DOCKER_DOMAIN_NAME_EXTENSION
if test -f "certs/$PIHOLE_CERT_FILE_NAME.key"; then
    echo "Pi-Hole certificates already exist"
else
    generateCerts $PIHOLE_CERT_FILE_NAME
fi

# Generate Firefly certs
FIREFLY_CERT_FILE_NAME=firefly.$DOCKER_DOMAIN_NAME_EXTENSION
if test -f "certs/$FIREFLY_CERT_FILE_NAME.key"; then
    echo "Firefly certificates already exist"
else
    generateCerts $FIREFLY_CERT_FILE_NAME
fi

updateTraefikConfigs