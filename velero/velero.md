# velero-备份还原工具

1. download url: https://github.com/vmware-tanzu/velero/releases/download/v1.5.2/velero-v1.5.2-linux-amd64.tar.gz
2. 创建对象存储 kubectl create -f examples/minio/00-minio-deployment.yaml,构建访问密钥文件
```shell
cat <<'EOF' > credentials-velero
[default]
aws_access_key_id = minio
aws_secret_access_key = minio123
EOF
```
3. 安装velero服务端
```shell
velero install \
    --image velero/velero:v1.5.2 \
    --plugins velero/velero-plugin-for-aws:v1.1.0 \
    --provider aws \
    --bucket velero \
    --namespace velero \
    --secret-file ./credentials-velero \
    --velero-pod-cpu-request 200m \
    --velero-pod-mem-request 200Mi \
    --velero-pod-cpu-limit 1000m \
    --velero-pod-mem-limit 1000Mi \
    --use-volume-snapshots=false \
    --use-restic \
    --restic-pod-cpu-request 200m \
    --restic-pod-mem-request 200Mi \
    --restic-pod-cpu-limit 1000m \
    --restic-pod-mem-limit 1000Mi \
    --backup-location-config region=minio,s3ForcePathStyle="true",s3Url=http://10.125.224.30:31242
```
4. 检查资源创建是否正常,如果更改过kubelet运行目录，需要修改ds.spec.template.spec.volumes.hostPath.path
5. 备份指定命名空间或所有命名空间
```shell
velero backup create backup-default --include-namespaces default
velero backup create all
velero backup get 
```
6. 还原指定资源
```shell
velero restore create --from-backup default
velero restore get
velero restore logs default-{date}
velero restore describe default-{date}
7. 定时备份
```shell
velero schedule create velero-default-daily --schedule="0 1 * * *" --include-namespaces default --ttl 24
```
