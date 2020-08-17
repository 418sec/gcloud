#!/bin/sh
kubectl annotate serviceaccount \
   one-kservice-account \
   iam.gke.io/gcp-service-account=one-kservice-account@adhadjilambris-1.iam.gserviceaccount.com