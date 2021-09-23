#! /bin/bash
gcloud auth login

gcloud container clusters get-credentials helm-gke-cluster --zone asia-south1-c

helm init --history-max 200