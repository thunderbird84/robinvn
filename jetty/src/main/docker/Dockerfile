FROM jeanblanchard/java:jdk-8u131
EXPOSE 80 9999 8488

WORKDIR /app/

ENTRYPOINT ["/app/bin/entrypoint.sh"]

COPY bin/ /app/bin/
COPY libs/ /app/libs/
COPY dev/ /app/env/dev/
COPY lab/ /app/env/lab/
COPY prod/ /app/env/prod/

RUN chmod a+x bin/entrypoint.sh
RUN chmod a+x bin/resolve-ip.sh

RUN ln -s /opt/jdk/bin/java bin/microservice-java


