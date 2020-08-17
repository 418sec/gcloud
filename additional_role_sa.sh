#!/bin/sh
export NODE_SA_EMAIL="one-service-account@adhadjilambris-1.iam.gserviceaccount.com"
export PROJECT=`gcloud config get-value project`
gcloud projects add-iam-policy-binding $PROJECT \
  --member serviceAccount:default \
  --role roles/owner
gcloud projects add-iam-policy-binding $PROJECT \
  --member serviceAccount:default \
  --role roles/secretmanager.secretAccessor
