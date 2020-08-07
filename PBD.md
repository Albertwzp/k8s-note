# PDB
- 非自愿中断(意外故障引起):
 - 后端节点物理机的硬件故障
 - 误删或云管理后台故障导致脱机
 - kernel panic
 - 节点网络故障,导致机器脱离集群
 - 节点资源不足,导致开始容器驱逐
- 自愿中断(人为计划发起):
 - 删除控制器
 - 控制器模板更新
 - 直接删除pod
 - drain node
 - 自动缩放功能

<https://jimmysong.io/kubernetes-handbook/concepts/pod-disruption-budget.html>
