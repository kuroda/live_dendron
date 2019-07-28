#!/bin/bash
set -eu

command1="mix deps.get"
command2="mix ecto.reset"
command3="MIX_ENV=test mix ecto.reset"
command4="npm i --prefix=assets"

docker-compose stop app
docker-compose up -d db
docker-compose run --rm app /bin/sh -c "$command1; $command2; $command3; $command4"
