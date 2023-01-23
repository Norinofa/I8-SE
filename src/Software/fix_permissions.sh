#!/bin/bash

if ! cd "$(dirname "$0")"; then exit; fi

# fix permissions
find docker -type d -exec chmod 0775 {} \;
find docker -type f -exec chmod 0664 {} \;
find src -type d -exec chmod 0775 {} \;
find src -type f -exec chmod 0664 {} \;

chmod 775 docker/django/start
chmod 775 docker/django/wait