#!/bin/bash
set -eu

command1="mix deps.get"
command2="npm i --prefix=assets"

docker-compose run --rm app /bin/sh -c "$command1; $command2"
