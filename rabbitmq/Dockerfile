FROM rabbitmq:3.6.11-alpine
MAINTAINER robin <robin.github@gmail.com>

COPY rabbitmq.config /etc/rabbitmq/rabbitmq.config
COPY definitions.json /etc/rabbitmq/definitions.json

RUN chmod 644 /etc/rabbitmq/rabbitmq.config
RUN chmod 644 /etc/rabbitmq/definitions.json