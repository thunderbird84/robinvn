FROM isuper/java-oracle:jre_8
MAINTAINER Vu Anh Tuan <robin.github@gmail.com>

ENV PLAY_HOME /local/play
ENV JRE_HOME /usr/lib/jvm/java-8-oracle
# INSTALL TOMCAT

RUN apt-get update && apt-get install -y telnet zip && \
    mkdir -p /local/java/play && \
    curl -s -o  /play-1.3.2.zip  https://github.com/playframework/play1/releases/download/1.3.2/play-1.3.2.zip && \
    unzip play-1.3.2 -d   play-1.3.2 && \
    rm play-1.3.2.zip && \
    mv play-1.3.2 $PLAY_HOME


ENV PATH $PATH:$PLAY_HOME:$JRE_HOME


# Remove unneeded apps



# tomcat conf
#ADD conf ${CATALINA_HOME}/conf
#ADD tomcat_wrapper.sh /opt/tomcat/bin/
#RUN ${CATALINA_HOME}/bin/catalina.sh run
#ENTRYPOINT ${CATALINA_HOME}/bin/catalina.sh start
#EXPOSE




