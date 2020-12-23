# Test ingress gateway
## Long
wrk -c1000 -d30s -t8 --latency http://k8s.xx.me
## Short
wrk -c1000 -d30s -t8 -H “Connection:Close” --latency http://k8s.xx.me
