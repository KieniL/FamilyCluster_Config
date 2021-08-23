#!/bin/sh

URL=$1

echo "URL: $URL"

docker pull simonthomas/theharvester:latest

docker run --rm simonthomas/theharvester:latest theharvester -d $URL -b all