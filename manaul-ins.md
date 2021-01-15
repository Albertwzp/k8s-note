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

# example: kubeadm-config.yaml
```YAML
---
apiVersion: kubeadm.k8s.io/v1beta2
bootstrapTokens:
- description: k8s kubeadm bootstrap token
  token: fix14c.2v183du3yeqq5tmm
  ttl: 0s
certificateKey: 84cdf6bfc57c302f15f67e774072c0a5c9cb8ad76ab67c73e17aba95daddf894
kind: InitConfiguration
localAPIEndpoint:
  advertiseAddress: 192.168.79.81
nodeRegistration:
  kubeletExtraArgs:
    enable-cadvisor-json-endpoints: "true"
    max-pods: "256"
    pod-infra-container-image: registry.com/library/pause:3.1
    root-dir: /data/kubelet
  name: 192.168.79.81
  taints: null
---
apiServer:
  certSANs:
  - 127.0.0.1
  - 192.168.79.81
  - 192.168.79.80
  - localhost
  extraArgs:
    service-node-port-range: 80-32767
    token-auth-file: /etc/kubernetes/known_tokens.csv
  extraVolumes:
  - hostPath: /etc/kubernetes
    mountPath: /etc/kubernetes
    name: vol-dir-0
apiVersion: kubeadm.k8s.io/v1beta2
clusterName: global
controlPlaneEndpoint: 192.168.79.81:6443
controllerManager:
  extraArgs:
    allocate-node-cidrs: "true"
    cluster-cidr: 172.27.0.0/16
    node-cidr-mask-size: "24"
    service-cluster-ip-range: 10.96.0.0/12
  extraVolumes:
  - hostPath: /etc/kubernetes
    mountPath: /etc/kubernetes
    name: vol-dir-0
dns:
  imageTag: 1.6.7
  type: CoreDNS
etcd:
  local:
    dataDir: /data/etcd
    extraArgs:
      data-dir: /data/etcd
    imageTag: v3.4.7
    serverCertSANs:
    - etcd
imageRepository: registry.com/library
kind: ClusterConfiguration
kubernetesVersion: 1.18.3
networking:
  dnsDomain: cluster.local
  serviceSubnet: 10.96.0.0/12
scheduler:
  extraArgs:
    policy-config-file: /etc/kubernetes/scheduler-policy-config.json
    use-legacy-policy-config: "true"
  extraVolumes:
  - hostPath: /etc/kubernetes
    mountPath: /etc/kubernetes
    name: vol-dir-0
---
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous: {}
  webhook:
    cacheTTL: 0s
  x509: {}
authorization:
  webhook:
    cacheAuthorizedTTL: 0s
    cacheUnauthorizedTTL: 0s
cpuManagerReconcilePeriod: 0s
evictionPressureTransitionPeriod: 0s
fileCheckFrequency: 0s
httpCheckFrequency: 0s
imageMinimumGCAge: 0s
kind: KubeletConfiguration
kubeReserved:
  cpu: 100m
  memory: 500Mi
maxPods: 256
nodeStatusReportFrequency: 0s
nodeStatusUpdateFrequency: 0s
runtimeRequestTimeout: 0s
streamingConnectionIdleTimeout: 0s
syncFrequency: 0s
systemReserved:
  cpu: 100m
  memory: 500Mi
volumeStatsAggPeriod: 0s
---
apiVersion: kubeproxy.config.k8s.io/v1alpha1
clientConnection:
  acceptContentTypes: ""
  burst: 0
  contentType: ""
  kubeconfig: ""
  qps: 0
clusterCIDR: 172.27.0.0/16
configSyncPeriod: 0s
conntrack: {}
iptables:
  masqueradeAll: false
  minSyncPeriod: 0s
  syncPeriod: 0s
ipvs:
  minSyncPeriod: 0s
  strictARP: false
  syncPeriod: 0s
  tcpFinTimeout: 0s
  tcpTimeout: 0s
  udpTimeout: 0s
kind: KubeProxyConfiguration
mode: ipvs
udpIdleTimeout: 0s
winkernel: {}
```
