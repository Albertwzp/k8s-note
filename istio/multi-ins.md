[TOC]
## plugin CA
```shell
# create certificates
mkdir -p certs
make -f ../tools/certs/Makefile.selfsigned.mk root-ca
make -f ../tools/certs/Makefile.selfsigned.mk tke-cacerts
make -f ../tools/certs/Makefile.selfsigned.mk box-cacerts
kubectl --context="${CTX_CLUSTER2}" create secret generic cacerts -n istio-system \
      --from-file=tke/ca-cert.pem \
      --from-file=tke/ca-key.pem \
      --from-file=tke/root-cert.pem \
      --from-file=tke/cert-chain.pem

kubectl --context="${CTX_CLUSTER1}" create secret generic cacerts -n istio-system \
      --from-file=box/ca-cert.pem \
      --from-file=box/ca-key.pem \
      --from-file=box/root-cert.pem \
      --from-file=box/cert-chain.pem
```
## install istio
```shell
export CTX_CLUSTER1=box
export CTX_CLUSTER2=box89

cat <<EOF |istioctl install --context="${CTX_CLUSTER1}" -f -
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
spec:
  values:
    global:
      meshID: mesh1
      multiCluster:
        clusterName: cluster1
      network: network1
EOF

cat <<EOF |istioctl install --context="${CTX_CLUSTER2}" -f -
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
spec:
  values:
    global:
      meshID: mesh1
      multiCluster:
        clusterName: cluster2
      network: network1
EOF
```

## upgrade istio
```shell
# upgrade controller-panel
istioctl upgrade -f cluster1.yaml --context="${CTX_CLUSTER1}"
# restart data-panel on work load
kubectl rollout restart deployment
```

## 端点发现
```shell
# 在 cluster2 中安装远程集群的 secret，该 secret 提供 cluster1’s API 服务器的访问权限
istioctl x create-remote-secret \
    --context="${CTX_CLUSTER1}" \
    --name=cluster1 | \
    kubectl apply -f - --context="${CTX_CLUSTER2}"

# 在 cluster1 中安装远程集群的 secret，该 secret 提供 cluster2’s API 服务器的访问权限
istioctl x create-remote-secret \
    --context="${CTX_CLUSTER2}" \
    --name=cluster2 | \
    kubectl apply -f - --context="${CTX_CLUSTER1}"
```


[multicluster](https://istio.io/latest/zh/docs/setup/install/multicluster/verify/)
