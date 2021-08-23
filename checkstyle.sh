#!/bin/sh

docker pull mattias/checkstyle:latest

docker run --rm -v $(pwd):/src mattias/checkstyle:latest -c /sun_checks.xml /src > checkstyle.txt