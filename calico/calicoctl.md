# Configurate calicoctl
/etc/calico/calicoctl.cfg
- store in  k8s

apiVersion: projectcalico.org/v3
kind: CalicoAPIConfig
metadata:
spec:
  datastoreType: "kubernetes"
  kubeconfig: "/root/.kube/config"

- store in etcd

apiVersion: projectcalico.org/v3
kind: CalicoAPIConfig
metadata:
spec:
  datastoreType: "etcdv3"
  etcdEndpoints: "https://127.0.0.1:2379"
  etcdKeyFile: /etc/kubernetes/pki/etcd/server.key
  etcdCertFile: /etc/kubernetes/pki/etcd/server.crt
  etcdCACertFile: /etc/kubernetes/pki/etcd/ca.crt
