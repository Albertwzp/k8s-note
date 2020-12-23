## ca-config.json
```shell
{
  "signing": {
    "default": {
      "expiry": "43800h"
    },
    "profiles": {
      "default": {
        "usages": ["signing", "key encipherment", "server auth", "client auth"],
        "expiry": "43800h"
      }
    }
  }
}
```
## ca-csr.json
```shell
{
  "hosts": [
    "cluster.consul"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "Kubernetes",
      "OU": "CA",
      "ST": "Oregon"
    }
  ]
}
```
## consul-csr.json
```shell
{
  "CN": "server.dc1.cluster.consul",
  "hosts": [
    "server.dc1.cluster.consul",
    "127.0.0.1"
  ],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "Hightower Labs",
      "OU": "Consul",
      "ST": "Oregon"
    }
  ]
}
```

## CA & 
```shell
cfssl gencert -initca ca/ca-csr.json | cfssljson -bare ca
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca/ca-config.json \
  -profile=default \
  ca/consul-csr.json | cfssljson -bare consul
```

## Consul Gossip Encryption Key
```shell
GOSSIP_ENCRYPTION_KEY=$(consul keygen)
```
## secret & configmap
```shell
kubectl create ns discovery
kubectl create secret generic consul -n discovery \
  --from-literal="gossip-encryption-key=${GOSSIP_ENCRYPTION_KEY}" \
  --from-file=ca.pem \
  --from-file=consul.pem \
  --from-file=consul-key.pem
kubectl create configmap consul -n discovery --from-file=server.json
```
### Apply sts svc & rbac
```shell
kubectl create -f consul.yaml[./consul.yaml]
```
## export web
