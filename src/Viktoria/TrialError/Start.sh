#!/bin/bash

docker pull httpd
docker build -t my-apache2 .
docker run -dit --name beispielprojektt -p 8080:80 my-apache2