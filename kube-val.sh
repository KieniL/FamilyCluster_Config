#!/bin/sh

docker pull cytopia/kubeval:latest

docker run --rm -v $(pwd):/data cytopia/kubeval:latest *.yaml > kube-val.txt