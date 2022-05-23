# stackoverflow-72318314-1466825
https://stackoverflow.com/q/72318314/1466825

To reproduce:

## Docker network

```
docker network create rabbitmq
```

## Docker image

```
docker build --tag stackoverflow-72318314:latest .
docker run --rm --publish 5672:5672 --publish 15672:15672 --network rabbitmq --name stackoverflow-72318314 stackoverflow-72318314:latest
```

## Python consumer

NOTE: start this before the producer to ensure the queue is declared as expected.

```
virtualenv venv
source venv/bin/activate
pip install pika
python repro.py
```

## PerfTest producer

```
docker run --interactive --tty --rm --network rabbitmq pivotalrabbitmq/perf-test:latest \
    --uri amqp://stackoverflow-72318314 --producers 1 --consumers 0 --predeclared --queue queuename --publishing-interval 15
```
