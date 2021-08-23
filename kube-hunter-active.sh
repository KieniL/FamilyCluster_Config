#!/bin/sh

docker pull aquasec/kube-hunter:latest

docker run -it --rm --network host aquasec/kube-hunter:latest --cidr 192.168.0.0/24 --active