#!/bin/bash

MAX_ATTEMPTS=10
INTERVAL=1

check_sshd_status(){
    ps aux | grep -q '[s]shd'
    return $?
}

GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}© 2024 Daniel Zaken and Tzach Halfon.${NC}"
dotnet --list-runtimes

if [ -z "${SSH_PASS}" ]; then
    echo "SSH_PASS is not set. Exiting."
    exit 1
else
    echo "running ${0} .... :)"

    echo "root:${SSH_PASS}" | chpasswd

    nohup /usr/sbin/sshd -D &
    for ((attempt=1; attempt<=$MAX_ATTEMPTS; attempt++)); do
        echo "Attempt $attempt of $MAX_ATTEMPTS"

        if check_sshd_status; then
            echo "sshd is running"
            break
        else
            echo "sshd is not running."

            # if [$attempt = $MAX_ATTEMPTS]; then
            #     exit 1
            # fi
        fi
        sleep $INTERVAL
    done

    if [ -z "${DOTNET_COMMAND}" ]; then
        echo "DOTNET_COMMAND is not set running bash instead"
        bash
    fi

    echo "running DOTNET_COMMAND: \"${DOTNET_COMMAND}\""
    eval "${DOTNET_COMMAND}" 
fi
