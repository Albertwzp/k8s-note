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
--node-monitor-period=<time> 检查每个节点状态的周期，默认5s
--node-monitor-grace-period	//当 node 失联一段时间后，kubernetes 判定 node 为 notready 状态，这段时长通过--node-monitor-grace-period参数配置，默认 40s
--node-startup-grace-period	//当 node 失联一段时间后，kubernetes 判定 node 为 unhealthy 状态，这段时长通过--node-startup-grace-period参数配置，默认 1m0s
--pod-eviction-timeout=<time>	//当 node 失联一段时间后，kubernetes 开始驱逐原 node 上的 pod，这段时长是通过--pod-eviction-timeout参数配置，默认 5m0s
--leader-elect=true 高可用选举
--cluster-cidr=<CIDR> pod分配范围
--node-cidr-mask-size=<int> 节点pod子网掩码，会被网络插件掩码覆盖

kube-schedule:
--leader-elect=true 高可用选举

kubelet:
--fail-swap-on=false	//如果swap开启状态, kubelet启动是否失败.
--node-status-update-frequency	//kubelet上报到apiserver频率，默认10s

[kubelet状态更新机制](https://www.qikqiak.com/post/kubelet-sync-node-status/)
