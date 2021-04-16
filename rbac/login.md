[TOC]
# curl apiserver
kubectl config view -o jsonpath='{"Cluster name\tServer\n"}{range .clusters[*]}{.name}{"\t"}{.cluster.server}{"\n"}{end}'
export CLUSTER_NAME="kubernetes"
APISERVER=$(kubectl config view -o jsonpath="{.clusters[?(@.name==\"$CLUSTER_NAME\")].cluster.server}")
TOKEN=$(kubectl get secrets -o jsonpath="{.items[?(@.metadata.annotations['kubernetes\.io/service-account\.name']=='${SA}')].data.token}"|base64 -d)
curl --header "Authorization: Bearer $TOKEN" --insecure  -X GET $APISERVER/api/v1/namespaces/kube-system/pods?limit=1
