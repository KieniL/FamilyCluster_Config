#!/bin/bash


docker start sonarqube

sudo systemctl start jenkins

docker-compose up -d