FROM python:3.8

WORKDIR /var/django/app
COPY docker/django/requirements.txt .

RUN apt update
RUN pip install virtualenv
COPY env /usr/bin/
RUN set -eux; \
	apt-get update; \
	apt-get install -y 	python3-mysqldb \
						default-mysql-client \
						libsasl2-dev \
						libldap2-dev \
						libssl-dev && \
	python -m pip install --upgrade pip && \
	pip install -r requirements.txt

EXPOSE 8000
