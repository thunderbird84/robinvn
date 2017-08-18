#!/bin/sh

exec bin/runWar-java \
    -cp $(cat bin/classpath) \
    -XX:+UseG1GC \
    -Xms32m \
    -Xmx128m \
    -Duser.timezone="Europe/Stockholm" \
    -Dfile.encoding="UTF-8" \
    -Duser.language=en \
    -Duser.country=US \
    -Djava.io.tmpdir=/tmp \
    -Denv=$ENV \
    -XX:+ExitOnOutOfMemoryError \
    -XX:+PrintCommandLineFlags \
    -XX:+PrintGC \
    -XX:+PrintGCTimeStamps \
    -Dcom.sun.management.jmxremote.port=9999 \
    -Dcom.sun.management.jmxremote.authenticate=false \
    -Dcom.sun.management.jmxremote.ssl=false \
    -Dcom.sun.management.jmxremote.rmi.port=9999 \
    -Djava.rmi.server.hostname=$(/app/bin/resolve-ip.sh) \
  robin.jetty.JettyMain
