[TOC]
# Install kafka by strimzi
```shell
# install kafka operator
wget -o kafka-op.yaml https://strimzi.io/install/latest?namespace=kafka
kubectl -nkafka apply -f kafka-op.yaml
# create kafka cluster
kubectl apply -f https://strimzi.io/examples/latest/kafka/kafka-persistent-single.yaml -n kafka
# test producer & consumer
kubectl -n kafka run kafka-producer -ti --image=quay.io/strimzi/kafka:0.21.1-kafka-2.7.0 --rm=true --restart=Never -- bin/kafka-console-producer.sh --broker-list my-cluster-kafka-bootstrap:9092 --topic my-topic
kubectl -n kafka run kafka-consumer -ti --image=quay.io/strimzi/kafka:0.21.1-kafka-2.7.0 --rm=true --restart=Never -- bin/kafka-console-consumer.sh --bootstrap-server my-cluster-kafka-bootstrap:9092 --topic my-topic --from-beginning
```
