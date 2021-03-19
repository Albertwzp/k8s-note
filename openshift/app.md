[TOC]
# 1.1 Create projects
```shell
#openshift-*, kube-*是特殊的默认项目，只有管理员可以通过 oc adm new-project创建
oc new-project <project_name> \
  --description="<description>" --display-name="<display_name>"
  [--as=<user> --as-group=system:authenticated --as-group=system:authenticated:oauth] #代表其他用户创建项目请求
oc get projects
oc project <project_name> #切换
oc status
oc delete project <project_name>
```
# 1.3 Template projects
```shell
oc adm create-bootstrap-project-template -o yaml > template.yaml
oc create -f template.yaml -n openshift-config
oc edit project.config.openshift.io/cluster
```
