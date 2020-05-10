# home-infra
Docker setup to contain various containers to run at home

This set up brings up the following services to run in a home server:

- Pi-Hole: Network-wide adblocker
- Cloudflared: Provides DNS over HTTPS for Pi-Hole
- Portainer: Management of the containers

## Setup
Nothing much unless this is being set up to run in Ubuntu. If that's the case then make sure to visit [this](https://github.com/pi-hole/docker-pi-hole#installing-on-ubuntu) to see what's needed for the DNS resolving.

## How to use
- If none of the services are running: `docker-compose -d up`
- If you want to bring up just one of them: `docker-compose -d up pihole|cloudflared|portainer`
