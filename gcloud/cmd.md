# command
```shell
# list project
gcloud container images list --project google-containers
gcloud container images list --project kubernetes-helm
gcloud container images list --project knative-releases

# list repo
gcloud container images list --repository=gcr.io/google-containers

# list tag
gcloud container images list-tags gcr.io/google-containers/metrics-server
```
