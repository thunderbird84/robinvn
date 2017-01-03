FROM isuper/java-oracle:jre_8
MAINTAINER Vu Anh Tuan <tuan.vu@niteco.se>
ENV TOMCAT_MAJOR_VERSION 7
ENV TOMCAT_MINOR_VERSION 7.0.34
ENV CATALINA_HOME /local/java/tomcat/${TOMCAT_MINOR_VERSION}
ENV JRE_HOME /usr/lib/jvm/java-8-oracle
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

RUN apt-get update && apt-get install -y telnet

# Remove unneeded apps

RUN \
   rm -rf ${CATALINA_HOME}/webapps/host-manager ; \   
   rm -rf ${CATALINA_HOME}/webapps/manager ; \ 
   rm -rf ${CATALINA_HOME}/webapps/examples  ;\
   rm -rf ${CATALINA_HOME}/webapps/docs/ ;\
   rm -rf ${CATALINA_HOME}/webapps/ROOT

ADD index.html ${CATALINA_HOME}/webapps/ROOT/index.html
ADD http://central.maven.org/maven2/javax/mail/mail/1.4.3/mail-1.4.3.jar ${CATALINA_HOME}/lib/mail-1.4.3.jar
ADD http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.14/mysql-connector-java-5.1.14.jar ${CATALINA_HOME}/lib/mysql-connector-java-5.1.14.jar
ADD log4j.xml ${CATALINA_HOME}/lib/

# tomcat conf
#ADD conf ${CATALINA_HOME}/conf
#ADD tomcat_wrapper.sh /opt/tomcat/bin/
#RUN ${CATALINA_HOME}/bin/catalina.sh run
#ENTRYPOINT ${CATALINA_HOME}/bin/catalina.sh start
EXPOSE 8080




