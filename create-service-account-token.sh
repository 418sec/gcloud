#!/bin/sh
kubectl create secret docker-registry gcr-access-token \
 --docker-server=gcr.io \
 --docker-username=oauth2accesstoken \
 --docker-password="$(gcloud auth print-access-token)" \
 --docker-email=alexi.hadjilambris@gmail.com