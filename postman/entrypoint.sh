#!/bin/sh

newman run FamilyCluster.postman_collection.json \
  --env-var "ANSPAREN_HOST=$ANSPAREN_HOST" \
  --env-var "API_HOST=$API_HOST" \
  --env-var "AUTH_HOST=$AUTH_HOST" \
  --env-var "CERT_HOST=$CERT_HOST" \
  $FOLDERS