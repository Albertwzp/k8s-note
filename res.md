[TOC]
nodeAffinity:
```
    spec:
      affinity:
        nodeAffinity:
          [required|preferred]DuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: [label|node-role.kubernetes.io/master]
                operator: [Exists|In|Exists|DoesNotExist|Gt|Lt]
                [value: value]
```

