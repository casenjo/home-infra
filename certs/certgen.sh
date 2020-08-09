#!/bin/bash

source ../env-traefik

# Needed because OSX's sed needs an extra argument
# https://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     platform=Linux;;
    Darwin*)    platform=Mac;;
    # CYGWIN*)    platform=Cygwin;;
    # MINGW*)     platform=MinGw;;
    # *)          platform="UNKNOWN:${unameOut}"
esac

function updateTraefikConfigs {
    if [ "$platform" = "Mac" ]; then
        sed -i ".bak" "s/DOCKER_DOMAIN_NAME_EXTENSION/$DOCKER_DOMAIN_NAME_EXTENSION/g" ../traefik/dynamic.toml
        sed -i ".bak" "s/DOCKER_DOMAIN_NAME_EXTENSION/$DOCKER_DOMAIN_NAME_EXTENSION/g" ../traefik/traefik.toml
    else
        sed -i "s/DOCKER_DOMAIN_NAME_EXTENSION/$DOCKER_DOMAIN_NAME_EXTENSION/g" ../traefik/dynamic.toml
        sed -i "s/DOCKER_DOMAIN_NAME_EXTENSION/$DOCKER_DOMAIN_NAME_EXTENSION/g" ../traefik/traefik.toml
    fi
}


function generateCerts {
    openssl genrsa -out $1.key 2048
    openssl ecparam -genkey -name secp384r1 -out $1.key
    openssl req -new -x509 -sha256 -key $1.key -out $1.crt -days 3650 -subj "/C=CA/ST=/L=/O=/OU=/CN=$1"
}

# Generate Portainer certs
PORTAINER_CERT_FILE_NAME=portainer.$DOCKER_DOMAIN_NAME_EXTENSION
if test -f "$PORTAINER_CERT_FILE_NAME.key"; then
    echo "Portainer certificates already exist"
else
    generateCerts $PORTAINER_CERT_FILE_NAME
fi

# Generate Traefik certs
TRAEFIK_CERT_FILE_NAME=traefik.$DOCKER_DOMAIN_NAME_EXTENSION
if test -f "$TRAEFIK_CERT_FILE_NAME.key"; then
    echo "Traefik certificates already exist"
else
    generateCerts $TRAEFIK_CERT_FILE_NAME
fi

# Generate Pi-Hole certs
PIHOLE_CERT_FILE_NAME=pihole.$DOCKER_DOMAIN_NAME_EXTENSION
if test -f "$PIHOLE_CERT_FILE_NAME.key"; then
    echo "Pi-Hole certificates already exist"
else
    generateCerts $PIHOLE_CERT_FILE_NAME
fi

updateTraefikConfigs