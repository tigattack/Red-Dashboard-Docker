# Red-Dashboard Docker

![Docker Pulls](https://img.shields.io/docker/pulls/tigattack/red-dashboard?logo=docker&style=for-the-badge)
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/tigattack/red-dashboard?label=red-dashboard%20version&logo=discord&style=for-the-badge)

[Red-Dashboard](https://github.com/Cog-Creators/Red-Dashboard), now containerised.

Note: This is an unsupported deployment method. Do not expect support from the developers of Red-Dashboard if you run into any issues.

**Table of Contents:**

- [Setup](#setup)
  - [Full Docker](#full-docker)
    - [Prerequisites](#prerequisites)
    - [Run with `docker-compose`](#run-with-docker-compose)
    - [Run with `docker run`](#run-with-docker-run)
  - [Standalone](#standalone)
    - [Prerequisites](#prerequisites-1)
    - [Run with `docker-compose`](#run-with-docker-compose-1)
    - [Run with `docker run`](#run-with-docker-run-1)

# Setup

There are two ways you can use this.

1. With Red-DiscordBot in Docker, using [rHomelab's Red-DiscordBot](https://hub.docker.com/r/rhomelab/red-discordbot) Docker container.  
  This is referred to as "full Docker" below.
2. Standalone, communicating with a non-Docker (e.g. Python venv) installation of Red-DiscordBot.

See instructions for both below.

After completing either of the below sections, Red-Dashboard will be available at http://ip:42356, where `ip` is the IP address or DNS name of your Docker host.

## Full Docker

### Prerequisites

Follow the [instructions](https://github.com/rHomelab/Red-DiscordBot-Docker#setup) to set up [rHomelab](https://github.com/rHomelab)'s Red-DiscordBot Docker container.

### Run with `docker-compose`

Copy [`docker-compose-full-example.yml` lines 13-21](docker-compose-full-example.yml#L13-L21) into your existing `docker-compose.yml` and modify to fit, per the below depedency table.

A number of configuration points between the bot service and dashboard service `docker-compose.yml` are dependent on each other and as such must be edited in pairs:

| **Line**                                  | **Depends on**                               | **Relevant value** |
|-------------------------------------------|----------------------------------------------|--------------------|
| [21](docker-compose-full-example.yml#L21) | [Line 5](docker-compose-full-example.yml#L5) | `RedBot`           |
| [22](docker-compose-full-example.yml#L22) | [Line 3](docker-compose-full-example.yml#L3) | `red-bot`          |
| [24](docker-compose-full-example.yml#L24) | [Line 7](docker-compose-full-example.yml#L7) | `42356`            |
| [25](docker-compose-full-example.yml#L25) | [Line 13](docker-compose-full-example.yml#L13) | `6133`             |

Once you've done this, run the following command.

```bash
docker-compose up -d
```

### Run with `docker run`

With this command, we are assuming there's an existing Red-DiscordBot container named `RedBot`

```bash
docker run -it --detach --name 'RedBot_Dashboard' --net=container:RedBot tigattack/red-dashboard:latest
# With custom ports
docker run -it --detach --name 'RedBot_Dashboard' --net=container:RedBot -e "RPC_PORT=6133" -e "WEB_PORT=42356" tigattack/red-dashboard:latest
```

## Standalone

After completing either of the below sections, Red-Dashboard will be available at http://ip:42356, where `ip` is the IP address or DNS name of your Docker host.

### Prerequisites

Follow the [instructions](https://docs.discord.red/en/latest/install_guides/) to install and configure Red-DiscordBot.

When running `redbot <your instance name>`, you must append the flag `--rpc` to enable RPC (required by Red-Dashboard) and, if you wish, the flag `--rpc-port <a port>` to use a different port than the default (6133).

### Run with `docker-compose`

Download [`docker-compose-standalone-example.yml`](docker-compose-standalone-example.yml#L13-L21) and rename to `docker-compose.yml`.

Modify the `RPC_PORT` and `WEB_PORT` environment variables in this file, if necessary.

Once complete, run the following command.

```bash
docker-compose up -d
```

### Run with `docker run`

With this command, we are assuming there's an existing Red-DiscordBot container named `RedBot`

```bash
docker run -it --detach --name 'RedBot_Dashboard' --net=host tigattack/red-dashboard:latest
# With custom ports
docker run -it --detach --name 'RedBot_Dashboard' --net=host -e "RPC_PORT=6133" -e "WEB_PORT=42356" tigattack/red-dashboard:latest
```

