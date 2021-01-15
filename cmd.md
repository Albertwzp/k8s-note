# SubCommand
## Get Fomate Output
```
kubectl get pod -A  -o json |jq -r '.items[] | [.metadata.name, .spec.terminationGracePeriodSeconds] | @tsv'
kubectl get pod -A -o=custom-columns=NAME:'.metadata.name',TERM:'.spec.terminationGracePeriodSeconds' 
# 获取所有镜像
kubectl get pods --all-namespaces -o go-template --template="{{range .items}}{{range .spec.containers}}{{.image}} {{end}}{{end}}" |tr -s '[[:space:]]' '\n' |sort |uniq

```
## Set resource
> kubectl -n $ns set resources deployment --containers='*' --requests=cpu=5m,memory=16Mi --all
## taint
kubectl taint node --all node-role.kubernetes.io/master=:NoSchedule
kubectl taint node --all node-role.kubernetes.io/master-

