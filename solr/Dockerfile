FROM indexing/run-war:95a33eb-dirty
MAINTAINER robin <robin.github@gmail.com>

EXPOSE 80

WORKDIR /app/


RUN mkdir /wars && \
	wget -O /wars/app.war -Y on  http://central.maven.org/maven2/org/apache/solr/solr/3.4.0/solr-3.4.0.war

COPY conf/ /app/conf
COPY solr.xml /app/solr.xml
COPY jetty-env.xml /app/jetty-dev.xml
RUN mkdir -p /var/lib/solr/data && ln -s /var/lib/solr/data /app/data
