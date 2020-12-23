# SubCommand
## Get Fomate Output
> kubectl get pod -A  -o json |jq -r '.items[] | [.metadata.name, .spec.terminationGracePeriodSeconds] | @tsv'
> kubectl get pod -A -o=custom-columns=NAME:'.metadata.name',TERM:'.spec.terminationGracePeriodSeconds' 
## Set resource
> kubectl -n $ns set resources deployment --containers='*' --requests=cpu=5m,memory=16Mi --all
## taint
kubectl taint node --all node-role.kubernetes.io/master=:NoSchedule
kubectl taint node --all node-role.kubernetes.io/master-
