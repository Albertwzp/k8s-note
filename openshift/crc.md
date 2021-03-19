[TOC]
## Install openshift
```shell
# Login RedHat account & download CodeReady Containers in [web](https://cloud.redhat.com/openshift/create/local)
tar -xvf crc-linux-amd64.tar.xz
./crc config set cpus 16 #C
./crc config set memory 49152 #M
./crc config set http-proxy http://proxy:8080
./crc config set https-proxy http://proxy:8080
./crc config set no-proxy 127.0.0.1,localhost, 192.168.130.1, 192.168.130.11
./crc config view
./crc setup
./crc start --log-level debug
eval $(./crc oc-env)
# 查询用户及登陆
crc console --credentials
# 登陆平台终端
oc login -u developer https://api.crc.testing:6443
oc get co
```
## Ops
```shell
# Login VM
ssh -p22  -i ~/.crc/machines/crc/id_ecdsa core@$(./crc ip)
# Login Console
>set Haproxy & hosts
https://console-openshift-console.apps-crc.testing
```
