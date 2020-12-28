## User authenticate
1. X509 client file
> --client-certificate= --client-key=
```bash
openssl genrsa -out cli.key 2048
openssl req -new -key cli.key -out cli.csr -subj "/CN=cli/O=MGM"
# certificate by k8s ca
openssl x509 -req -in cli.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out cli.crt -days 365
# set credenticate user
kubectl config set-credentials cli --client-certificate=path/to/cli.crt --client-key=path/to/cli.key
# set context
kubectl config set-context cli@global --cluster=global --namespace=ns --user=tom
# set current context
kubectl config use-context cli@global
# base and wrap
cat <cli.crt|cli.key> | base64 --wrap=0
```
2. static token file
> --token-auth-file=
3. static password

## create RoleBinding
```yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: admin-binding
  namespace: cli
subjects:
- kind: User
  name: cli
  apiGroup: ""
roleRef:
  kind: ClusterRole
  name: admin
  apiGroup: ""
```

## Build anonymous rbac binding for local debug
```shell
kubectl create clusterrolebinding system:anonymous --clusterrole=cluster-admin --user=system:anonymous
```
