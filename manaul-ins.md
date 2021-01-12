[TOC]
# manaul install k8s
1. install require package
```shell
yum install -y container-selinux containerd.io
yum install -y docker-ce docker-ce-cli
yum install -y kubeadm kubelet kubectl kubernetes-cni
```
2. init kubeadm-config.yaml
```
kubeadm config print init-defaults >kubeadm-config.yaml
```

```
export K8S_VERSION=
export APISERVER_NAME=
export POD_SUBNET=
cat <<EOF > ./kubeadm-config.yaml
apiVersion: kubeadm.k8s.io/v1beta2
kind: ClusterConfiguration
kubernetesVersion: v${K8S_VERSION}
imageRepository: registry.aliyuncs.com/k8sxio
controlPlaneEndpoint: "${APISERVER_NAME}:6443"
networking:
  serviceSubnet: "10.96.0.0/16"
  podSubnet: "${POD_SUBNET}"
  dnsDomain: "cluster.local"
EOF
```
3. init kubernetes
```shell
kubeadm init --config=kubeadm-config.yaml --upload-certs
```
4. set .kube/config
```shell
rm -rf /root/.kube/
mkdir /root/.kube/
cp -i /etc/kubernetes/admin.conf /root/.kube/config
```

5. join master
```
# 重新上传证书并生成新的解密密钥（2小时过期）
kubeadm init phase upload-certs --upload-certs
# 生成join control-plane密钥
kubeadm alpha certs certificate-key
kubeadm join $HA:6443 --token ${token} \
  --discovery-token-ca-cert-hash sha256:${cert} \
  --control-plane \
  --certificate-key ${join密钥}
```
6. join worker
```
- kubeadm token create --ttl 0 --print-join-command
- kubeadm config print join-defaults > kubeadm-config.yaml
  kubeadm join --config kubeadm-config.yaml
- token=$(kubeadm token list|awk '{print $1}')
  cert=$(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //')
  kubeadm join $MASTER:6443 --token $token \
    --discovery-token-ca-cert-hash sha256:$cert
```
