[TOC]

# login by kubeadmin
```
PASSWORD=$(oc whoami -t)
podman login -u kubeadmin -p $(oc whoami -t) image-registry.openshift-image-registry.svc:5000
curl --insecure -s -u kubeadmin:${PASSWORD}  https://image-registry.openshift-image-registry.svc:5000/extensions/v2/metrics
```
