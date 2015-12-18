FROM gliderlabs/alpine:latest

RUN apk-install ncurses

ADD nh.tgz /
ADD defaults.nh /root/.nethackrc

VOLUME /nh360/var/save

CMD ["/games/nethack"]
