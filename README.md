# helm-poc
Purpose - install and test helm

prerequisute
enable kubernetes, compute and gcr api
need 3 service accounts to Create GKE_cluster, Compute Instance and access GCR

Implementation instructions:

1. enable access on GCP using GKE service account

$ gcloud auth activate-service-account --key-file=/home/pgan432_gmail_com/gke-creator-level-epoch.json

$ gcloud container clusters get-credentials helm-gke-cluster --zone asia-south1-c

create secrete in k8s to access gcr
  
$kubectl create secret docker-registry gcr-json-key \
 --docker-server=gcr.io \
 --docker-username=_json_key \
 --docker-password="$(cat ~/gke-creator-level-epoch.json)" \
 --docker-email=pgan@gmail.email

$kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "gcr-json-key"}]}'

check if image is right using $kubectl run javademoapp --image=gcr.io/level-epoch-329208/javademoappwithcloudbuild:latest --overrides='{"apiVersion": "v1", "spec": {"template":{"spec":{"imagePullSecrets": [{"name": "gcr-json-key"}]}}}}'

#instructions to create chart on Clent server

$helm create mychart

update values in values.yaml
    update image name
    add imagepull secret if needed

$helm install example ./mychart --set service.type=NodePort

NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=mychart,app.kubernetes.io/instance=mychart-1634979261" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT