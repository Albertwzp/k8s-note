#! /bin/bash

for ca in $(kubectl get secret --all-namespaces -o jsonpath="{..ca\.crt}" |tr -s '[[:space:]]' '\n')
do
  echo -n ${ca} | base64 -d | openssl x509 -noout -text |grep 'CN'
done |\
sort |\
uniq -c
