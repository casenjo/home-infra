# home-infra
Docker setup to contain various containers to run at home

This set up brings up the following services to run in a home server:

- Pi-Hole: Network-wide adblocker
- Cloudflared: Provides DNS over HTTPS for Pi-Hole
- Portainer: Management of the containers
- Firefly III: Self-hosted finance management

## Setup
- Make a copy of `env-example` and save it as `.env`
- In `.env`, fill out and/or change the values for the necessary environment variables
- If you're running Ubuntu then make sure to visit [this](https://github.com/pi-hole/docker-pi-hole#installing-on-ubuntu) to see what's needed for the DNS resolving.

## How to use
- If none of the services are running: `docker-compose -d up`
- If you want to bring up just one of them: `docker-compose -d up pihole|cloudflared|portainer|firefly`
