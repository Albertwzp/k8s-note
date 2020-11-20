# SubCommand
## Get Fomate Output
> kubectl get pod -A  -o json |jq -r '.items[] | [.metadata.name, .spec.terminationGracePeriodSeconds] | @tsv'
> kubectl get pod -A -o=custom-columns=NAME:'.metadata.name',TERM:'.spec.terminationGracePeriodSeconds' 
