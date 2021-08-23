#!/bin/bash

version=$(<./VERSION.txt)

echo $Version

kubectl set image deployment/frontend frontend=luke19/familyfrontend:$version -n family
kubectl set image deployment/authservice authservice=luke19/familyauthservice:$version -n family
kubectl set image deployment/apiservice apiservice=luke19/familyapiservice:$version -n family
kubectl set image deployment/ansparservice ansparservice=luke19/familyansparservice:$version -n family
kubectl set image deployment/ansparservice ansparservice=luke19/familycertservice:$version -n family
kubectl set image deployment/ansparservice ansparservice=luke19/familytestsuite:$version -n family


kubectl rollout status deployment/frontend -n family
kubectl rollout status deployment/authservice -n family
kubectl rollout status deployment/apiservice -n family
kubectl rollout status deployment/ansparservice -n family
kubectl rollout status deployment/certservice -n family
kubectl rollout status deployment/testsuite -n family