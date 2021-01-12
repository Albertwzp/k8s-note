docker save $(docker images --digests |grep '^gcr.io' |awk -v OFS=@ '{print $1,$3}' |tr '\n' ' ') |gzip -cv >knative.tgz
