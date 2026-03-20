#!/bin/sh
set -eu

BOOTSTRAP_SERVER="${KAFKA_BOOTSTRAP_SERVER:-kafka:9092}"
ACTION="${KAFKA_ADMIN_ACTION:-list}"
TOPICS="${KAFKA_TOPICS:-}"
PARTITIONS="${KAFKA_PARTITIONS:-3}"
REPLICATION_FACTOR="${KAFKA_REPLICATION_FACTOR:-1}"
TOPIC_CONFIGS="${KAFKA_TOPIC_CONFIGS:-}"

wait_for_kafka() {
  attempt=1
  until kafka-topics --bootstrap-server "$BOOTSTRAP_SERVER" --list >/dev/null 2>&1; do
    if [ "$attempt" -ge 30 ]; then
      echo "Kafka broker was not ready after 30 attempts"
      exit 1
    fi
    echo "Waiting for Kafka broker... attempt $attempt/30"
    attempt=$((attempt + 1))
    sleep 2
  done
}

build_config_args() {
  CONFIG_ARGS=""
  if [ -n "$TOPIC_CONFIGS" ]; then
    OLD_IFS="$IFS"
    IFS=','
    for cfg in $TOPIC_CONFIGS; do
      CONFIG_ARGS="$CONFIG_ARGS --config $cfg"
    done
    IFS="$OLD_IFS"
  fi
}

create_topics() {
  [ -n "$TOPICS" ] || { echo "KAFKA_TOPICS is empty"; exit 1; }

  build_config_args

  OLD_IFS="$IFS"
  IFS=','
  for topic in $TOPICS; do
    echo "Creating topic: $topic"
    # shellcheck disable=SC2086
    kafka-topics \
      --bootstrap-server "$BOOTSTRAP_SERVER" \
      --create \
      --if-not-exists \
      --topic "$topic" \
      --partitions "$PARTITIONS" \
      --replication-factor "$REPLICATION_FACTOR" \
      $CONFIG_ARGS
  done
  IFS="$OLD_IFS"
}

describe_topics() {
  if [ -n "$TOPICS" ]; then
    OLD_IFS="$IFS"
    IFS=','
    for topic in $TOPICS; do
      echo "Describing topic: $topic"
      kafka-topics --bootstrap-server "$BOOTSTRAP_SERVER" --describe --topic "$topic"
    done
    IFS="$OLD_IFS"
  else
    kafka-topics --bootstrap-server "$BOOTSTRAP_SERVER" --describe
  fi
}

delete_topics() {
  [ -n "$TOPICS" ] || { echo "KAFKA_TOPICS is empty"; exit 1; }

  OLD_IFS="$IFS"
  IFS=','
  for topic in $TOPICS; do
    echo "Deleting topic: $topic"
    kafka-topics --bootstrap-server "$BOOTSTRAP_SERVER" --delete --topic "$topic"
  done
  IFS="$OLD_IFS"
}

list_topics() {
  echo "Kafka topics:"
  kafka-topics --bootstrap-server "$BOOTSTRAP_SERVER" --list
}

main() {
  wait_for_kafka

  case "$ACTION" in
    create)
      create_topics
      list_topics
      ;;
    list)
      list_topics
      ;;
    describe)
      describe_topics
      ;;
    delete)
      delete_topics
      list_topics
      ;;
    *)
      echo "Unsupported KAFKA_ADMIN_ACTION: $ACTION"
      echo "Supported actions: create, list, describe, delete"
      exit 1
      ;;
  esac
}

main "$@"