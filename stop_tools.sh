#!/bin/bash


docker stop sonarqube

sudo systemctl stop jenkins

docker-compose down