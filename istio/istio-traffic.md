[TOC]

## Gateway
```shell
# 自签根证书
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=example Inc./CN=example.com' -keyout example.com.key -out example.com.crt
# 利用根证书签证
openssl req -out httpbin.example.com.csr -newkey rsa:2048 -nodes -keyout httpbin.example.com.key -subj "/CN=httpbin.example.com/O=httpbin organization"
openssl x509 -req -days 365 -CA example.com.crt -CAkey example.com.key -set_serial 0 -in httpbin.example.com.csr -out httpbin.example.com.crt
# 创建并挂载证书
kubectl create -n istio-system secret tls istio-ingressgateway-certs --key httpbin.example.com.key --cert httpbin.example.com.crt
kubectl exec -it -n istio-system $(kubectl -n istio-system get pods -l istio=ingressgateway -o jsonpath='{.items[0].metadata.name}') -- ls -al /etc/istio/ingressgateway-certs
# 单向认证访问
curl -v -HHost:httpbin.example.com --resolve httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST --cacert example.com.crt https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418
# 双向认证
kubectl create -n istio-system secret generic istio-ingressgateway-ca-certs --from-file=example.com.crt
# 双向认证访问
curl -HHost:httpbin.example.com --resolve httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST --cacert example.com.crt --cert httpbin-client.example.com.crt --key httpbin-client.example.com.key https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418

```

```YAML
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: httpbin-gateway
spec:
  selector:
    istio: ingressgateway # use Istio default gateway implementation
  servers:
  - port:
      number: [80|443]
      name: http[s]
      protocol: HTTP[S]
    tls:
      mode: [SIMPLE|MUTUAL]
      serverCertificate: /etc/istio/ingressgateway-certs/tls.crt
      privateKey: /etc/istio/ingressgateway-certs/tls.key
    hosts:
    - "*[httpbin.example.com]"
```

## DestinationRule
```YAML
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: tcp-echo-destination
spec:
  host: tcp-echo
# 熔断器
  trafficPolicy:
    connectionPool:
      tcp:
        maxConnections: 1
      ttp:
        http1MaxPendingRequests: 1
        maxRequestsPerConnection: 1
    outlierDetection:
      consecutiveErrors: 1
      interval: 1s
      baseEjectionTime: 3m
      maxEjectionPercent: 100
# 熔断器
  subsets:
  - name: v1
    labels:
      version: v1
  - name: v2
    labels:
      version: v2
```

## VirtualService
```YAML
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: [productpage -> [detail|reviews(1|2|3)] -> ratings]
spec:
  hosts:
    - "*"
    - [productpage -> [detail|reviews(1|2|3)] -> ratings]
  http:
// 两秒延迟
  - fault:
      delay:
        percentage:
          value: 100
        [percent: 100]
        fixedDelay: 2s
// HTTP abort 的故障注入
      abort:
        httpStatus: 500
        percentage:
          value: 100
// 基于用户路由
  - match:
    - headers:
        end-user:
          exact: jason
// 基于路径路由
    -  uri:
        prefix: /headers
    route:
    - destination:
        host: reviews
        subset: v2
      weight: 50
// 流量转移50%
    - destination:
        host: reviews
        subset: v3
      weight: 50
// 默认路由
  - route:
    - destination:
        host: reviews
        subset: v1
// 镜像流量
    mirror:
      host: reviews
      subset: v2
    mirror_percent: 100
// 半秒请求超时
    timeout: 0.5s
```
