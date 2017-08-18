FROM jeanblanchard/java:jdk-8u131
EXPOSE 80

WORKDIR /app/

ENTRYPOINT ["/app/bin/entrypoint.sh"]

COPY bin/ /app/bin/
COPY libs/ /app/libs/

RUN chmod a+x bin/entrypoint.sh
RUN chmod a+x bin/resolve-ip.sh

RUN ln -s /opt/jdk/bin/java bin/runWar-java


