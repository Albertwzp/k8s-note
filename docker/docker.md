# Command
## docker manifest
> unlock experimental feature
```shell
cat >>daemon.json <<EOF
"experimental": true
EOF
cat >>~/.docker/config.json <<EOF
"experimental": "enabled"
EOF
```

> build manifest list & push
```shell
docker push image-arch
docker manifest create imge image-arch ...
docker manifest push image
docker manifest inspect image
```
