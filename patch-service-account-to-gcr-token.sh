#!/bin/sh
kubectl patch serviceaccount one-kservice-account \
 -p '{"imagePullSecrets": [{"name": "gcr-json-token"}]}'