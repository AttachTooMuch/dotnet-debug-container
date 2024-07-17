# Daniel Zaken

## Project Overview

This project helps you to debug remote offline containers by attaching via SSH into the container.

## Usage

### 1. Run with docker cli:

```sh
docker run -dt --name debugcontainer -p 22222:22 -v d:\\publish\\my-first-debuggable-dotnet:/app -e SSH_PASS=1234 -e "DOTNET_COMMAND=dotnet /app/my-first-debuggable-dotnet.dll" danielzake92/debugcontainers:ubuntu-22.04-amd64-aspnet6.0-latest
```

### 2. Run with docker-compose:

```yml
version: "3.8"
services:
  docker-debug-poc:
    image: danielzake92/debugcontainers:ubuntu-22.04-amd64-aspnet6.0-latest
    container_name: docker-debug-poc
    restart: always
    environment:
      - SSH_PASS=1234 # Password for SSHing into the container (mandatory for remote debugging)
      - DOTNET_COMMAND=dotnet /app/my-first-debuggable-dotnet.dll # Your dotnet command to run (please use absolute paths)
    volumes:
      - d:\\publish\\my-first-debuggable-dotnet:/app # Output volume for updating binaries
    ports:
      - "22222:22" # You must expose an SSH port; it is advised to not use 22 (the Docker host machine default SSH port)
```
