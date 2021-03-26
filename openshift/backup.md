[TOC]
# 1. backup etcd
```shell
oc debug node/<node_name>
chroot /host
/usr/local/bin/cluster-backup.sh /home/core/assets/backup
```

# 2. Repaire etcd
```shell
2.1 节点不正常的etcd环境
# 命令检查 EtcdMembersAvailable
oc get etcd -o=jsonpath='{range .items[0].status.conditions[?(@.type=="EtcdMembersAvailable")]}{.message}{"\n"}'
# 检查机器是否没有运行:
oc get machines -A -ojsonpath='{range .items[*]}{@.status.nodeRef.name}{"\t"}{@.status.providerStatus.instanceState}{"\n"}'
# 删除etcd member, etcd peer/serving/metric secret, 重建machine,如果未成功加入etcd，执行下一步
oc patch etcd cluster -p='{"spec": {"forceRedeploymentReason": "recovery-'"$( date --rfc-3339=ns )"'"}}' --type=merge
2.2 crush 的etcd,删除etcd执行如下命令,重新部署
oc patch etcd cluster -p='{"spec": {"forceRedeploymentReason": "single-master-recovery-'"$( date --rfc-3339=ns )"'"}}' --type=merge 
```
# 3. recover
```shell

# expired control plane certificates
oc get csr
oc describe csr <csr_name>
oc adm certificate approve <csr_name>
```
