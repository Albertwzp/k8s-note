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
## get crd by ns
kubectl api-resources -o name --verbs=list --namespaced | xargs -n 1 kubectl get --show-kind --ignore-not-found -n $NS
## clean Terminating ns
kubectl  delete ns $NS --force --grace-period=0
kubectl  get ns $NS  -o json > ${NS}.json 		//delete spec.finalizers value
curl --cacert /etc/kubernetes/pki/ca.crt --cert /etc/kubernetes/pki/apiserver-kubelet-client.crt --key /etc/kubernetes/pki/apiserver-kubelet-client.key -k -H "Content-Type:application/json" -X PUT --data-binary @${NS}.json https://x.x.x.x:6443/api/v1/namespaces/${NS}/finalize

# delete Evicted pod
kubectl delete po --field-selector status.phase=Evicted
# delete Complated pod
oc delete pod -A --field-selector status.phase=Succeeded

# Retain pv
kubectl patch pv <pv> -p '{"spec":{"claimRef": null}}'
