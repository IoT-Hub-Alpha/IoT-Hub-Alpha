## Kafka Admin Utility
### Overview

kafka-admin is a lightweight helper container used to perform administrative operations on the Kafka cluster inside the development environment.

It is primarily used for:
- Creating required Kafka topics
- Listing existing topics
- Describing topic configuration
- Deleting topics when needed

This utility allows infrastructure setup to remain explicit and reproducible instead of relying on Kafka's automatic topic creation.

It runs as a one-shot container that executes administrative commands and exits.

## Supported Actions
### Create Topics

Creates topics defined in KAFKA_TOPICS.

`KAFKA_ADMIN_ACTION=create`

Example:
```
telemetry.raw
telemetry.clean
telemetry.dlq
event.topic
```
Each topic will be created using:
- defined partitions
- replication factor
- optional topic configs
- Kafka will skip topics that already exist.

### List Topics

Lists all topics in the cluster.

`KAFKA_ADMIN_ACTION=list`

Example output:
```
telemetry.raw
telemetry.clean
telemetry.dlq
event.topic
```
### Describe Topics

Shows metadata about topics.

`KAFKA_ADMIN_ACTION=describe`

Example output:
```
Topic: telemetry.raw
PartitionCount: 3
ReplicationFactor: 1
Configs: retention.ms=604800000
```
### Delete Topics

Deletes topics listed in KAFKA_TOPICS.

`KAFKA_ADMIN_ACTION=delete`

**Use with caution — topic deletion permanently removes stored messages.**

### Running Kafka Admin Manually

## Examples using Docker Compose.

**List topics**
```
docker compose run --rm \
-e KAFKA_ADMIN_ACTION=list \
kafka-admin
```
**Create topics**
```
docker compose run --rm \
-e KAFKA_ADMIN_ACTION=create \
-e KAFKA_TOPICS=test.topic \
kafka-admin
```
**Describe a topic**
```
docker compose run --rm \
-e KAFKA_ADMIN_ACTION=describe \
-e KAFKA_TOPICS=telemetry.raw \
kafka-admin
```
**Delete a topic**
```
docker compose run --rm \
-e KAFKA_ADMIN_ACTION=delete \
-e KAFKA_TOPICS=test.topic \
kafka-admin
```