kube-apiserver:
--hostname-override=<node-name> 覆写节点名
--dvertise-address=<ip> 
--insecure-bind-address=<ip> http监听地址
--insecure-port=<int> http监听端口
--bind-address=<ip> https监听地址
--secure-port=<int> https监听端口
--service-node-port-range=<1-65535> nodeport可分配端口范围
--service-cluster-ip-range=<CIDR> svc可分配地址范围

kube-controller-manager:
--pod-eviction-timeout=<time> 超时驱逐pod的阈值
--node-monitor-period=<time> 检查每个节点状态的周期
--leader-elect=true 高可用选举
--cluster-cidr=<CIDR> pod分配范围
--node-cidr-mask-size=<int> 节点pod子网掩码，会被网络插件掩码覆盖

kube-schedule:
--leader-elect=true 高可用选举
