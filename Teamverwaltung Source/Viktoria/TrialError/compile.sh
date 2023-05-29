#!/bin/bash
docker run -it --rm --name my-maven-project -v "$PWD/beispielprojektt":/usr/src/app -w /usr/src/app maven mvn clean install
