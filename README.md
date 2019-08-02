# Live Dendron - a Phoenix LiveView demo

![Screenshot](https://github.com/kuroda/live_dendron/blob/media/screenshot.png)

On this demo, you can manipulate an organization chart that has groups and members as nodes.

Specifically, you can

* expand or shrink a group node
* edit the name of a group or a member
* add a new group or member
* delete a new group or member

## Requirements

* Docker 18 or above
* Docker Compose 1.13 or abover

## Setting up a Docker container

```
$ git clone git@github.com:kuroda/live_dendron.git
$ cd live_dendron
$ ./install.sh
```

## Starting the server

```
$ docker-compose up
```

You can play with this demo by opening http://localhost:4000 with you browser.

## Running tests

```
$ ./mix.sh test
```
