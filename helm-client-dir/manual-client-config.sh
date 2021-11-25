#! /bin/bash
gcloud auth activate-service-account --key-file=/home/pgan432_gmail_com/gke-creator-level-epoch.json

gcloud container clusters get-credentials helm-gke-cluster --zone asia-south1-c

helm create mychart

#get mysql pass


#install mysql client
kubectl run -i --tty ubuntu --image=ubuntu:16.04 --restart=Never -- bash -il

#install tools inside container
apt-get update && apt-get install mysql-client -y

mysql -h <my-release-name> -p

#to inspect helm chart
helm inspect stable/mysql

