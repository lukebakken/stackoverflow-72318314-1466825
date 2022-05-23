import logging
import time
import pika

logfmt = (
    "%(levelname) -10s %(asctime)s %(name) -30s %(funcName) "
    "-35s %(lineno) -5d: %(message)s"
)
logging.basicConfig(level=logging.INFO, format=logfmt)
logger = logging.getLogger(__name__)


def callback(ch, method, properties, body):
    logger.info("received %r, %r" % (body, properties))
    logger.info("sleeping for 15 seconds")
    ch.connection.sleep(15)
    logger.info("acking message")
    ch.basic_ack(delivery_tag=method.delivery_tag)


def consume():
    userid = "guest"
    password = "guest"
    url = "localhost"
    port = 5672
    credentials = pika.PlainCredentials(userid, password)
    parameters = pika.ConnectionParameters(url, port, "/", credentials)
    connection = pika.BlockingConnection(parameters=parameters)
    channel = connection.channel()
    channel.queue_declare(queue="queuename", durable=True)
    channel.basic_consume("queuename", callback)
    logger.info("waiting for messages. To exit press CTRL+C")
    channel.start_consuming()


if __name__ == "__main__":
    consume()
    print("Exiting!")
