#!/bin/bash
set -eu

command1="mix ecto.setup"
command2="MIX_ENV=test mix ecto.setup"

docker-compose stop app
docker-compose up -d db
docker-compose run --rm app /bin/sh -c "$command1; $command2"
