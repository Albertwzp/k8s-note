#ETCDCTL_API=3 
#etcdctl --endpoints=9.30.2.97:2380 --cacert=/etc/kubernetes/ssl/ca.pem --cert=/etc/etcd/ssl/etcd.pem --key=/etc/etcd/ssl/etcd-key.pem member list
etcdctl --endpoints=https://9.30.2.97:2379 --ca-file=/etc/kubernetes/ssl/ca.pem --cert-file=/etc/etcd/ssl/etcd.pem --key-file=/etc/etcd/ssl/etcd-key.pem cluster-health
