#!/bin/sh

URL=$1

echo "URL: $URL"
docker pull instrumentisto/nmap:latest

docker run --rm -v /etc/ssl/certs:/etc/ssl/certs --network host instrumentisto/nmap:latest -A -T4 $URL > nmap-$URL.txt