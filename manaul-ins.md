# manaul install k8s
1. install require package
```shell
yum install -y container-selinux containerd.io
yum install -y docker-ce docker-ce-cli
yum install -y kubeadm kubelet kubectl kubernetes-cni
```
2. set kubeadm-config.yaml

```shell
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
