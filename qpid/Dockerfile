FROM jeanblanchard/java:jdk-8u131
MAINTAINER robin <robin.github@gmail.com>

EXPOSE 5672

WORKDIR /app/

RUN wget -O qpid.tar.gz http://mirrors.viethosting.com/apache/qpid/0.32/binaries/qpid-broker-0.32-bin.tar.gz && \
    tar xvzf  qpid.tar.gz && rm qpid.tar.gz &&\
    cd qpid-broker/0.32 && mv * /app/

ENTRYPOINT ["/app/bin/entrypoint.sh"]

COPY bin/ /app/bin/
COPY config.json /etc/qpid/config.json
COPY vhost.json /etc/qpid/vhost.json

RUN chmod a+x bin/entrypoint.sh
RUN chmod a+x bin/resolve-ip.sh

RUN ln -s /opt/jdk/bin/java bin/qpid-java
RUN ln -s /etc/qpid/config.json /app/config.json