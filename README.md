# home-infra
Docker setup to contain various containers to run at home. It uses a big part of [this](https://demyx.sh/tutorial/how-to-run-openvpn-and-pi-hole-using-docker-in-a-vps/) guide to make the link between OpenVPN and Pi-Hole and then adds cloudflared for DNSSEC.

The following services will run:

- Pi-Hole: Network-wide adblocker
- Cloudflared: Provides DNS over HTTPS for Pi-Hole
- Portainer: Management of the containers
- Firefly III: Self-hosted finance management

## Setup
- Make a copy of `env-example` and save it as `.env`
- In `.env`, fill out and/or change the values for the necessary environment variables
- If you're running Ubuntu then make sure to visit [this](https://github.com/pi-hole/docker-pi-hole#installing-on-ubuntu) to see what's needed for the DNS resolving.
- Build the OpenVPN service by going into the `openvpn` folder and running `docker build -t ovpn:latest .`
- Follow [the Quick Start](https://github.com/kylemanna/docker-openvpn) steps to configure the VPN. For the value of `$OVPN_DATA` use `ovpn-data-lair`

## How to use
- If none of the services are running: `docker-compose -d up`
- If you want to bring up just one of them: `docker-compose -d up pihole|cloudflared|portainer|firefly|openvpn`
