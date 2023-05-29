#!/bin/bash

# cd & check
if ! cd "$(dirname "$0")"; then exit; fi

sudo docker compose down
