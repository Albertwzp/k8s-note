[TOC]

# Get cri-o
```
curl -f https://storage.googleapis.com/k8s-conform-cri-o/artifacts/crio-$(git ls-remote https://github.com/cri-o/cri-o master | cut -c1-9).tar.gz -o crio.tar.gz
```
