#!/bin/bash
#set -x #echo on
args=("$@")
mvn org.apache.maven.plugins:maven-dependency-plugin:2.8:get \
    -Dartifact=GROUPID:VERSION \
    -Dpackaging=war \
    -Ddest=microservice.war
