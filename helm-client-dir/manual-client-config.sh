#! /bin/bash
gcloud auth activate-service-account --key-file=/home/pgan432_gmail_com/gke-creator-level-epoch.json

gcloud container clusters get-credentials helm-gke-cluster --zone asia-south1-c

