#!/bin/sh

if [ -n "$EXCHANGE" ]
then   
    sed -i -e "s/robin.event/$EXCHANGE/g" /app/etc/virtualhosts.xml
fi

exec bin/qpid-java \
    -cp $(cat bin/classpath) \
    -XX:+UseG1GC \
    -Xms32m \
    -Xmx128m \
    -Duser.timezone="Asia/Ho_Chi_Minh" \
    -Dfile.encoding="UTF-8" \
    -Duser.language=en \
    -Duser.country=US \
    -Djava.io.tmpdir=/tmp \
    -Denv=$ENV \
    -DPNAME=QPBRK \
    -XX:+HeapDumpOnOutOfMemoryError -Xmx2g \
    -DQPID_HOME=/app \
    -DQPID_WORK=/app \
    -Damqj.logging.level=info \
    -Damqj.read_write_pool_size=32 \
    -XX:+ExitOnOutOfMemoryError \
    -XX:+PrintCommandLineFlags \
    -XX:+PrintGC \
    -XX:+PrintGCTimeStamps \
    -Dcom.sun.management.jmxremote.port=9999 \
    -Dcom.sun.management.jmxremote.authenticate=false \
    -Dcom.sun.management.jmxremote.ssl=false \
    -Dcom.sun.management.jmxremote.rmi.port=9999 \
    -Djava.rmi.server.hostname=$(/app/bin/resolve-ip.sh) \
    -DQPID_LOG_APPEND= \
     org.apache.qpid.server.Main



