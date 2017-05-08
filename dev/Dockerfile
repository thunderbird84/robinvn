FROM isuper/java-oracle:jdk_8
MAINTAINER robin <robin.github@gmail.com>
ENV TOMCAT_MAJOR_VERSION 6
ENV TOMCAT_MINOR_VERSION 6.0.53
ENV CATALINA_HOME /local/java/tomcat/${TOMCAT_MINOR_VERSION}
ENV JPDA_TRANSPORT="dt_socket"
ENV JPDA_ADDRESS="8888"
ENV PDA_SUSPEND="y"
ENV JRE_HOME /usr/lib/jvm/java-8-oracle
ENV SOLR_OPTS " -Dsolr.solr.home=/var/lib/solr -Dsolr.data.dir=/var/lib/solr/data -Dsolr.slave.url=http://localhost:8080/solr -Dsolr.master.url=http://localhost:8080/solr "
ENV DB_OPTS " "
ENV MORE_OPTS " "
ENV CATALINA_OPTS ${SOLR_OPTS} ${DB_OPTS} ${MORE_OPTS}
# INSTALL TOMCAT

RUN  mkdir -p /local/java/tomcat;
RUN curl -s -o  /apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz  https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz
#ADD https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz /
#ADD apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz /
#RUN mv apache-tomcat-${TOMCAT_MINOR_VERSION} ${CATALINA_HOME}
RUN \    
    tar zxf apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz  && \
    rm apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
    mv apache-tomcat-${TOMCAT_MINOR_VERSION} ${CATALINA_HOME}
ENV PATH $PATH:$CATALINA_HOME/bin:$JRE_HOME

RUN apt-get update && apt-get install -y telnet vim memcached nginx qpidd

# Remove unneeded apps

RUN \
   rm -rf ${CATALINA_HOME}/webapps/examples  ;\
   rm -rf ${CATALINA_HOME}/webapps/docs/ ;\
   rm -rf ${CATALINA_HOME}/webapps/ROOT

RUN curl -s -o ${CATALINA_HOME}/lib/mail-1.4.3.jar  http://central.maven.org/maven2/javax/mail/mail/1.4.3/mail-1.4.3.jar && \
    curl -s -o ${CATALINA_HOME}/lib/mysql-connector-java-5.1.14.jar http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.14/mysql-connector-java-5.1.14.jar && \
    curl -s -o ${CATALINA_HOME}/webapps/solr.war  http://central.maven.org/maven2/org/apache/solr/solr/3.4.0/solr-3.4.0.war
ADD log4j.xml ${CATALINA_HOME}/lib/
ADD tomcatuser.xml ${CATALINA_HOME}/conf/tomcat-users.xml
ADD solr /var/lib/solr
RUN sed -i -e 's/-l 127\.0.\0\.1/-l 0\.0\.0\.0/g' /etc/memcached.conf
RUN ln -sf ${CATALINA_HOME} /tomcat
# tomcat conf
#ADD conf ${CATALINA_HOME}/conf
#ADD tomcat_wrapper.sh /opt/tomcat/bin/
#RUN ${CATALINA_HOME}/bin/catalina.sh run
ENTRYPOINT service memcached start && service qpidd start && service nginx start &&  ${CATALINA_HOME}/bin/catalina.sh start && tail -f ${CATALINA_HOME}/logs/*.log
EXPOSE 8080 11211 11212 80 5672 8888



