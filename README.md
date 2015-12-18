### Description

This is a minimal Nethack installation on Alpine Linux. It uses one Dockerfile to download source code and compile Nethack, and another Dockerfile to publish the result as a 6MB image.

### Usage

    ./run.sh
    docker run -it -v "$PWD/save:/nh360/var/save" nethack

### TODO

Would like to make a separate container that runs [Hearse](http://www.argon.org/~roderick/hearse/) with a shared volume.
