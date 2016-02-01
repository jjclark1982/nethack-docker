#!/bin/sh -eux

docker build -t nethack-build .
docker run --rm nethack-build > nh.tgz

# docker build -t nethack - < nh.tgz
# This doesn't work because of a permissions error
# so we create a temporary directory to work around it.
# Slated for fix in Docker 1.10: https://github.com/docker/docker/issues/15785
(
    mkdir -p install
    cd install
    tar xzvf ../nh.tgz
    docker build -t nethack .
) || echo ok
rm -rf nh.tgz install

echo 'Usage: docker run --rm -it -v "$PWD/save":/nh360/var/save nethack'
