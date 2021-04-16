[TOC]
# 验证不通过apiserver返回401
# auth认证路由
oc get route oauth-openshift -n openshift-authentication -o json | jq .spec.host
2. 内部 OAuth 服务器
```shell
oc get oauth
oc get clusteroperators authentication
oc get clusteroperators kube-apiserver
oc get events | grep ServiceAccount
oc describe sa/proxy
```
3. oc get oauthclient
4. 管理用户拥有的 OAUTH 访问令牌
oc get useroauthaccesstokens


## 7.5 
查看[集群用户]角色[绑定]
oc describe [cluster]role[binding].rbac[/admin]
创建角色及绑定
oc create [cluster]role <name> --verb=<verb> --resource=<resource> -n <project>
oc adm policy add-[cluster-]role-to-<user|group> <role> <user|group> [--role-namespace=<ns> -n <ns>]
oc adm policy remove-[cluster-]role-from-<user|group> <role> <user|group> [--role-namespace=<ns> -n <ns>]
oc adm policy remove-<user|group> <username|groupname>
## 9.1
sa自动属于两个组system:serviceaccounts和system:serviceaccounts:<project>
自动包含两个secret
- API 令牌(*-token-*)
- OpenShift Container Registry 的凭证(*-dockercfg-*)
## 9.3
oc policy add-role-to-user view system:serviceaccount[:<ns>[:<sa>]] [-n ns]
oc policy add-role-to-user <role_name> -z <service_account_name>
## 11.1
获取令牌
oc sa get-token <service_account_name>

