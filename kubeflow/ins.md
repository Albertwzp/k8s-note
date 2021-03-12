[TOC]
# install
```shell
export BASE_DIR=kubeflow
export KF_NAME=kfc
export KF_DIR=${BASE_DIR}/${KF_NAME}
mkdir -p ${KF_DIR}
cd ${KF_DIR}
export CONFIG_URI="https://raw.githubusercontent.com/kubeflow/manifests/v1.2-branch/kfdef/kfctl_k8s_istio.v1.2.0.yaml"
wget ${CONFIG_URI}
kfctl apply -V -f kfctl_k8s_istio.v1.2.0.yaml
```
# err:
>  Required value: this property is in x-kubernetes-list-map-keys, so it must have a default or be a required property]  filename="kustomize/kustomize.go:266"
>  "MountVolume.SetUp failed for volume "istio-token" : failed to fetch token: the API server does not have TokenRequest endpoints enabled"
[reslove](https://stackoverflow.com/questions/64641078/how-to-install-kubeflow-on-existing-on-prem-kubernetes-cluster)
    - --service-account-signing-key-file=/etc/kubernetes/pki/sa.key
    - --service-account-issuer=kubernetes.default.svc

