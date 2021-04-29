# etcd config
```
存储扩容
 --quota-backend-bytes=8589934592 
```

# etcd status
```
etcdctl --endpoints=https://9.30.2.97:2379 --ca-file=/etc/kubernetes/ssl/ca.pem --cert-file=/etc/etcd/ssl/etcd.pem --key-file=/etc/etcd/ssl/etcd-key.pem [cluster-health|member list]
export ETCDCTL_ENDPOINTS=https://192.168.121.47:2379
export ETCDCTL_CACERT=/PATH/etcd/ca.crt
export ETCDCTL_CERT=/PATH/etcd/server.crt
export ETCDCTL_KEY=/PATH/etcd/server.key
export ETCDCTL_API=3
# 列出告警
etcdctl alarm list/disarm
# 获取当前revision
etcdctl endpoint status --write-out="json" | egrep -o '"revision":[0-9]*' | egrep -o '[0-9].*')
# 压缩revision
etcdctl compact $revision
# 去碎片化
etcdctl defrag
# 获取键值对
etcdctl get /tshift/clusters/ --prefix --keys-only
etcdctl get /tshift/clusters/global |tail -1 |jq

# backup & restore
etcdctl -w table  endpoint status
etcdctl snapshot save /backup/etcd-snapshot-`date +%Y%m%d`.db
etcdctl snapshot restore /backup/etcd-snapshot-20210122.db --data-dir=/var/lib/etcd
```
