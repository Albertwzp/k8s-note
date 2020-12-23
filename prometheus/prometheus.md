## Feature
1. support consul, etcd, kubernetes automatic discovery
2. exporter cover all infrastructure & middleware
3. tool library  cover all main language
4. its CNCF oss, deepin combine with kubernetes, all addon on k8s open metric
5. work with pushgateway and alertmanager in full monitor life cycle
6. self contain TSDB

## Defect
1. not support distribute mode

## Federation
### hierarchy federation
### across-service federation
### Split by env

## LTS
1. Cortex
2. Thanos
3. M3
4. Infuxdb
5. Victoria
6. Clickhouse
7. Elasticsarch

## Burst by hash mod
```yaml
- job_name: burst
  relabel_configs:
  - source_labels: [__addresss__]
    modulus: 4
    target_label: __tmp_hash
    action: hashmod
  - source_labels: [__tmp_hash]
    regex: ^1$
    action: keep
```

## Automatic discover

## Data model
$key{$label_name: $label_value} $value
1. Counter
2. Gauge
3. Histogram
4. Summary

## Exporter
## Arg
> --web.enable-lifecycle #Enable shutdown and reload via HTTP request.

[extensibility]: https://zhuanlan.zhihu.com/p/135358305
