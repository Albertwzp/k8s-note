# Install redis-cluster
1. deploy res to k8s
```shell
kubectl -nredis apply -f redis-cluster.yaml[./redis-cluster.yaml]
```
2. init cluster
```shell
kubectl -nredis exec -it redis-cluster-0 -- redis-cli --cluster create --cluster-replicas 1 $(kubectl -nredis get pods -l app=redis-cluster -o jsonpath='{range.items[*]}{.status.podIP}:6379 ')
yes
```
3. info cluster
```shell
kubectl -nredis exec -it redis-cluster-0 -- redis-cli cluster info
```
4. test use&node err

[https://www.cnblogs.com/passzhang/p/13455908.html]
