[TOC]
# Operator 是一种打包、部署和管理 Kubernetes 应用程序的方法
ClusterServiceVersion csv
Subscription sub
InstallPlan ip

# Install Operator by CLI
```shell
oc get packagemanifests -n openshift-marketplace
oc describe packagemanifests <operator_name> -n openshift-marketplace
oc apply -f - << EOF
---
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  name: <operatorgroup_name>
  namespace: <namespace>
spec:
  serviceAccountName: <sa>
  targetNamespaces:
  - <namespace>

---
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: <subscription_name>
  namespace: <openshift-operators>
spec:
  channel: alpha
  installPlanApproval: <Manual|Automatic>
  name: <operator_name> 
  source: redhat-operators 
  sourceNamespace: openshift-marketplace 
  startingCSV: <csv>
# 设置代理
  config:
    env:
    - name: HTTP_PROXY
      value: test_http
    - name: HTTPS_PROXY
      value: test_https
    - name: NO_PROXY
      value: test
# 注入自定义 CA 证书
    selector:
      matchLabels:
        <labels_for_pods> 
    volumes: 
    - name: trusted-ca
      configMap:
        name: trusted-ca
        items:
          - key: ca-bundle.crt 
            path: tls-ca-bundle.pem 
    volumeMounts: 
    - name: trusted-ca
      mountPath: /etc/pki/ca-trust/extracted/pem
      readOnly: true

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: trusted-ca 
  labels:
    config.openshift.io/inject-trusted-cabundle: "true"

EOF
```

# Build Operator
```shell
# example memcached-operator
RELEASE_VERSION=v0.13.0
mkdir -p $GOPATH/src/github.com/example-inc/
cd $GOPATH/src/github.com/example-inc/
operator-sdk new memcached-operator
cd memcached-operator
operator-sdk add api \
    --api-version=cache.example.com/v1alpha1 \
    --kind=Memcached
#edit pkg/apis/cache/v1alpha1/memcached_types.go(MemcachedSpec, MemcachedStatus)
operator-sdk generate k8s
operator-sdk add controller \
    --api-version=cache.example.com/v1alpha1 \
    --kind=Memcached
```
