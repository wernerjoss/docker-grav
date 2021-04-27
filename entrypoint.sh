#!/bin/sh
# see https://dev.to/natterstefan/docker-tip-how-to-get-host-s-ip-address-inside-a-docker-container-5anh
# needs iputils-ping & iproute2 to be installed, see Dockerfile
HOST_DOMAIN="host.docker.internal"
ping -q -c1 $HOST_DOMAIN > /dev/null 2>&1
if [ $? -ne 0 ]; then
    HOST_IP=$(ip route | awk 'NR==1 {print $3}')
    echo "$HOST_IP\t$HOST_DOMAIN" >> /etc/hosts
fi
