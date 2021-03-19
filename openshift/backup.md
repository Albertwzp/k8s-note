[TOC]
# 1. backup etcd
```shell
oc debug node/<node_name>
chroot /host
/usr/local/bin/cluster-backup.sh /home/core/assets/backup
```

# 2. Repaire etcd
```shell
# 命令检查 EtcdMembersAvailable
oc get etcd -o=jsonpath='{range .items[0].status.conditions[?(@.type=="EtcdMembersAvailable")]}{.message}{"\n"}'
# 检查机器是否没有运行:
oc get machines -A -ojsonpath='{range .items[*]}{@.status.nodeRef.name}{"\t"}{@.status.providerStatus.instanceState}{"\n"}'

```
