#!/bin/bash

# cd & check
if ! cd "$(dirname "$0")"; then exit; fi

if [ "$1" = "--reset" -o "$1" = "-b" ]; then
  sudo docker system prune --all
  sudo docker volume prune
  sudo docker compose up -d
  #sudo docker compose up --build --force-recreate --no-deps
elif [ "$1" = "--build" -o "$1" = "-b" ]; then
  sudo docker compose up --build -d
else
  sudo docker compose up -d
fi
