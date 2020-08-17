#!/bin/sh
export SA_NAME="one-service-account@adhadjilambris-1.iam.gserviceaccount.com"
gcloud container clusters create one-cluster \
  --service-account=$SA_NAME \
  --region europe-north1 --num-nodes 1 && \
gcloud container clusters get-credentials one-cluster

