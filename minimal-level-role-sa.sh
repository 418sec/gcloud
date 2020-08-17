#!/bin/sh
export NODE_SA_EMAIL="one-service-account@adhadjilambris-1.iam.gserviceaccount.com"
export PROJECT=`gcloud config get-value project`

gcloud projects add-iam-policy-binding $PROJECT \
  --member serviceAccount:$NODE_SA_EMAIL \
  --role roles/monitoring.metricWriter  --role roles/monitoring.viewer --role roles/logging.logWriter \
      --role roles/storage.objectViewer --role roles/cloudsql.editor --role roles/secretmanager.secretAccessor






