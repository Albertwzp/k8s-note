# rook 命名空无法删除
```
NAMESPACE=rook-ceph
# 查看命名空间资源
kubectl api-resources --namespaced=true -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found -n rook-ceph
kubectl proxy &
kubectl get namespace $NAMESPACE -o json |jq '.spec = {"finalizers":[]}' >temp.json
curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json 127.0.0.1:8001/api/v1/namespaces/$NAMESPACE/finalize
```
