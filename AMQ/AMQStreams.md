# Difference between AMQ and AMQ Streams
|Area|AMQ Broker|AMQ Streams|
|----|----|----|
|Model|"Smart Broker Dumb Client"|"Dumb Broker Smart Client"|
|Durability|Volatile or Durable storage|Durable storage|
|Storage duration|Temporary storage of messages|Long term storage of messages|
|Message retention|Retained until consumed|Retained until expired or compacted|
|Consumer state|Broker managed|Client managed (can be stored in broker)|
|Selectors|Yes, per consumer|No|
|Stream replay|No|Yes|
|HA|Replication|Replication|
|Protocol|AMQP, MQTT, OpenWire, Core, STOMP|Kafka protocol|
|Delivery gaurantees|Best effort or gauranteed |Best effort or gauranteed|

# TODO
* #TODO# Run a sample ksql
* #TODO# Run a sample Kafka Streams api with AMQ Streams
* #TODO# Use Apache Samsa to prioritise the records in the kafka broker (then use AMQ Stream).
  * https://samza.apache.org/learn/documentation/latest/container/streams.html
* #TODO# Create a sample kafka streams api, quarkus and strimzi
  * Kafka streams documentation and get started code is here https://kafka.apache.org/documentation/streams/
* #TODO# Kafka stream apps on k8s
* #TODO# how to build kafka streams apps for hotspot and graalvm with quarkus and its extension
* #TODO# usage of kafka as a channel for Knative