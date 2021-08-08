# home-infra

Docker setup to run various containers at home in a self-hosted environment. It uses a big part of [this](https://demyx.sh/tutorial/how-to-run-openvpn-and-pi-hole-using-docker-in-a-vps/) guide to make the link between OpenVPN and Pi-Hole and then adds cloudflared for DNSSEC.

The following services will run:

- Traefik: Reverse proxy
- Pi-Hole: Network-wide adblocker
- Cloudflared: Provides DNS over HTTPS for Pi-Hole
- Portainer: Management of the containers
- Firefly III: Self-hosted finance management
- OpenVPN: Private VPN setup to allow use of Pi-Hole from outside
- UniFi Controller: Management of Ubiquiti gear
- Tandoor Recipes: Host your family's recipe book
- Wireguard: Private VPN setup
- Plex Media Server: Stream all your media while connected to your VPN

## Setup
- Make a copy of `env-example` and save it as `.env`
- Make a copy of `env-traefik.example` and save it as `env-traefik`
- Make a copy of `env-recipes.example` and save it as `env-recipes`
- In `.env`, fill out and/or change the values for the necessary environment variables
  **Note:** The value for DOCKER_DOMAIN_NAME_EXTENSION in `env-traefik` must match the one in `.env`
- In `env-recipes` generate a value for SECRET_KEY and a Postgres password (if desired)
- Create the directories for the Plex containers volumes (`/plex/media`, `/plex/transcode`, `/plex/database`)
- Run `setup.sh` to generate self-signed certs and the Traefik config files.
- If you're running Ubuntu then make sure to visit [this](https://github.com/pi-hole/docker-pi-hole#installing-on-ubuntu) to see what's needed for the DNS resolving
- Build the OpenVPN service by going into the `openvpn` folder and running `docker build -t ovpn:latest .`
- Follow [the Quick Start](https://github.com/kylemanna/docker-openvpn) steps to configure the VPN. For the value of `$OVPN_DATA` use `ovpn-data-lair`

## How to use

- If none of the services are running: `docker-compose -d up`
- If you need to bring up just one of them: `docker-compose -d up pihole|cloudflared|traefik|portainer|firefly|openvpn|unifi|recipes_nginx|recipes_web|recipes_db|wireguard`
