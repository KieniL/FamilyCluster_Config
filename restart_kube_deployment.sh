#!/bin/bash


kubectl rollout restart \
deployment/frontend \
deployment/authservice \
deployment/apiservice \
deployment/ansparservice \
deployment/certservice \
deployment/testsuite \
-n family


kubectl rollout status deployment/frontend -n family
kubectl rollout status deployment/authservice -n family
kubectl rollout status deployment/apiservice -n family
kubectl rollout status deployment/ansparservice -n family
kubectl rollout status deployment/certservice -n family
kubectl rollout status deployment/testsuite -n family

