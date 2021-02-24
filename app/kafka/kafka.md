[TOC]

```shell
# kafka operate
./bin/kafka-topics.sh --create --zookeeper :2181  --replication-factor 3 --partitions 5 --topic my-replicated-topic5
./bin/kafka-topics.sh --describe --zookeeper :2181   --topic my-replicated-topic5
./bin/kafka-console-producer.sh --broker-list :9092 --topic my-replicated-topic5
./bin/kafka-console-consumer.sh --bootstrap-server :2181 --from-beginning --topic my-replicated-topic5
./bin/kafka-leader-election.sh --bootstrap-server :2181 --all-topic-partitions --election-type preferred
```

