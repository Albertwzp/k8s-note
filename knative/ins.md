## 下载istioctl && 安装istio
```
curl -L https://istio.io/downloadIstio | sh -
cp istio-1.8.1/bin/istioctl /usr/local/bin/
istioctl install -f istio-minimal-operator.yaml
```
## 安装knative
```
kubectl apply -f https://github.com/knative/operator/releases/download/v0.19.2/operator.yaml

