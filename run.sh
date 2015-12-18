#!/bin/sh -eux

docker build -t nethack-build - < nethack-build.dockerfile
docker run --rm nethack-build > nh.tgz
docker build -t nethack .

docker run --rm -it -v "$PWD/save":/nh360/var/save nethack

# TODO:
# also run hearse, possibly in a separate container
# dgamelaunch?
