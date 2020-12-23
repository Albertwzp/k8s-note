# Command
## docker manifest
> unlock experimental feature
```shell
daemon.json
"experimental": true
~/.docker/config.json
"experimental": "enabled"
```

```shell
> build manifest list & push
docker push image-arch
docker manifest create imge image-arch ...
docker manifest push image
docker manifest inspect image
```
