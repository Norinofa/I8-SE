#!/bin/bash

docker build --build-arg JAR_FILE=beispielprojektt/src/target/*.jar -t myorg/myapp ..
docker run -p 8080:8080 myorg/myapp