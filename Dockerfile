FROM rabbitmq:3.9.13-management

# Define environment variables.
ENV RABBITMQ_USER user
ENV RABBITMQ_PASSWORD password
ENV RABBITMQ_PID_FILE /var/lib/rabbitmq/mnesia/rabbitmq

COPY ./myrabbit.conf /etc/rabbitmq/rabbitmq.conf

ADD init.sh /init.sh
RUN chmod +x /init.sh

# Define default command
CMD ["/init.sh"]
