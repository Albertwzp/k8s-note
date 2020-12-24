[TOC]
# psp pod container 的安全上下文设置，局部会覆盖全局的设置
## runAsUser,runAsGroup,runAsNonRoot (psp,p,c)
> 进程（组）和文件属主
```
securityContext:
  runAsUser:
  runAsGroup:
  runAsNonRoot:
```

## fsGroup (p)
> 文件属组
```
securityContext:
  fsGroup:
```

## fsGroupChangePolicy (p)
> 控制 Kubernetes 检查和管理卷属主和访问权限的方式
```
securityContext:
  fsGroupChangePolicy: [OnRootMismatch | Always]
```

## allowPrivilegeEscalation (psp,c)
```
securityContext:
  allowPrivilegeEscalation:
```
## capabilities (psp,p,c)
> 赋予或者移除Linux权能,
效果:
```
securityContext:
  capabilities:
    add: ["NET_ADMIN", "SYS_TIME"]

cat /proc/${PID}/status |grep -i cap
```

## seccompProfile
> 设置 Seccomp 样板(Profile),容器系统调用设置集
```
securityContext:
  seccompProfile:
    type: (RuntimeDefault | Unconfined | Localhost)
    [localhostProfile: my-profiles/profile-allow.json]

Localhost时,Seccomp 的样板设置位于<kubelet-根目录>/seccomp/my-profiles/profile-allow.json
```

## seLinuxOptions (p,c, psp.seLinux.)
> SELinux配置
```
securityContext:
  seLinuxOptions:
    level:
    role:
    type:
    user:
    
```
[capabilitiy.h](https://github.com/torvalds/linux/blob/master/include/uapi/linux/capability.h)
[pod securityContext](https://kubernetes.io/zh/docs/tasks/configure-pod-container/security-context/)
