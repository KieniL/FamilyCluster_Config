#!/bin/sh

docker pull zegl/kube-score:latest

docker run --rm -v $(pwd):/project zegl/kube-score:latest score *.yaml --ignore-test pod-networkpolicy -o ci > kube-score.txt