FROM rabbitmq:3.9.13-management

ENV RABBITMQ_USER user
ENV RABBITMQ_PASSWORD password
ENV RABBITMQ_PID_FILE /var/lib/rabbitmq/mnesia/rabbitmq

COPY ./custom-rabbitmq.conf /etc/rabbitmq/rabbitmq.conf

ADD custom-docker-entrypoint.sh /usr/local/bin
RUN chmod 0755 /usr/local/bin/*.sh

ENTRYPOINT ["custom-docker-entrypoint.sh"]
CMD ["rabbitmq-server"]
