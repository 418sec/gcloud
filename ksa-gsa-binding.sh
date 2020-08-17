#!/bin/sh
gcloud iam service-accounts add-iam-policy-binding \
  --role roles/iam.workloadIdentityUser \
  --member "serviceAccount:adhadjilambris-1.svc.id.goog[one-kservice-account]" \
  one-service-account@adhadjilambris-1.iam.gserviceaccount.com