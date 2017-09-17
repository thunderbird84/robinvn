FROM jeanblanchard/java:jdk-8u131
MAINTAINER robin <robin.github@gmail.com>

EXPOSE 5672

WORKDIR /app/

RUN wget --output-document qpid.tar.gz http://archive.apache.org/dist/qpid/0.20/qpid-java-broker-0.20.tar.gz && \
    tar xvzf  qpid.tar.gz && rm qpid.tar.gz &&\
    cd qpid-broker-0.20 && mv * /app/

ENTRYPOINT ["/app/bin/entrypoint.sh"]

COPY bin/ /app/bin/
COPY virtualhosts.xml /app/etc/virtualhosts.xml
ADD config.xml /etc/qpid/config.xml

RUN chmod a+x bin/entrypoint.sh
RUN chmod a+x bin/resolve-ip.sh

RUN ln -s /opt/jdk/bin/java bin/qpid-java
