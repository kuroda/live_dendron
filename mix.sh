#!/bin/bash
set -eu

docker-compose run --rm app /bin/bash -c "mix $1"
