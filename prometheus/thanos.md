# Set object store secret
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: thanos-objectstorage
  namespace: thanos
type: Opaque
stringData:
  objectstorage.yaml: |
    type: s3
    config:
      signature_version2: true
      insecure: true
      endpoint: <ip:port>
      bucket: thanos
      access_key:
      secret_key:
```
# Add sidecar for prometheus


