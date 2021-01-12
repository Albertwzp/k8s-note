## 手动更新
```
kubeadm alpha certs check-expiration	//查询过期时间
// 备份/etc/kubernetes和/var/lib/etcd
kubeadm alpha certs renew all --config=/etc/kubenetes/kubeadm-config.yaml	//更新证书
kubeadm init phase kubeconfig all --config /etc/kubenetes/kubeadm-config.yaml		//更新kubeconfig文件
echo | openssl s_client -showcerts -connect 127.0.0.1:6443 -servername api 2>/dev/null | openssl x509 -noout -enddate	//检查apiserver证书是否更新
```

## 接口自动签发更新
```
# 备份/etc/kubernetes和/var/lib/etcd
# controller-manager添加如下参数
- --experimental-cluster-signing-duration=87600h
# 申请证书更新
kubeadm alpha certs renew all --use-api --config /etc/kubernetes/kubeadm-config.yaml &
while true
do
  csr=$(kubectl get csr |grep Pending |awk '{print $1}')
  kubectl certificate approve $csr
  sleep 3
done
# 因为所有证书都是用的/etc/kubernetes/pki/ca.{crt,key}签发的，而原来etcd的证书自己也有根证书，所以需要换成前面签发的,可以直接替换，或者修改etcd.yaml的挂载路径
cp /etc/kubernetes/pki/ca.crt /etc/kubernetes/pki/front-proxy-ca.crt
cp /etc/kubernetes/pki/ca.key /etc/kubernetes/pki/front-proxy-ca.key
# 还需要替换 requestheader-client-ca-file 文件,默认是 /etc/kubernetes/pki/front-proxy-ca.crt 文件
cp /etc/kubernetes/pki/ca.crt /etc/kubernetes/pki/front-proxy-ca.crt
cp /etc/kubernetes/pki/ca.key /etc/kubernetes/pki/front-proxy-ca.key
```

## 删除kubelet证书，重启kubelet，自动更新kubelet签发证书
```
rm -rf /var/lib/kubelet/pki/ && systemctl restart kubelet
# 检查kubelet证书到期时间
openssl x509 -in /var/lib/kubelet/pki/kubelet-client-current.pem -noout -enddate
```
