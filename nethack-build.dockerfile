# FROM debian:jessie

# RUN apt-get update
# RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
#     byacc \
#     curl \
#     flex \
#     gcc \
#     libncursesw5-dev \
#     make \
#     ncurses-dev

# RUN curl http://jaist.dl.sourceforge.net/project/nethack/nethack/3.6.0/nethack-360-src.tgz \
# | tar xzv

# WORKDIR /nethack-3.6.0/

# RUN ./sys/unix/setup.sh sys/unix/hints/linux-chroot

# RUN sed -i \
# -e "s/^LFLAGS=/LFLAGS=-static /" \
# Makefile

# RUN HOME= make install

# WORKDIR /nh/install
# # CMD ["/nh/install/games/nethack"]
# CMD tar cz .

FROM gliderlabs/alpine:latest

RUN apk-install \
byacc \
flex \
gcc \
libc-dev \
linux-headers \
make \
ncurses-dev

RUN wget -O- http://jaist.dl.sourceforge.net/project/nethack/nethack/3.6.0/nethack-360-src.tgz \
| tar xzv

WORKDIR /nethack-3.6.0/

# set the syntax for flex and cp in the hints file
# and use a fixed directory
RUN cat sys/unix/hints/linux-chroot > hints && \
echo '#-POST' >> hints && \
echo 'LEX = flex' >> hints && \
sed -i -e 's/^HACKDIR=.*/HACKDIR=\/nh360/' hints && \
sed -i -e 's/cp -n/cp /g' hints && \
sed -i -e "/^CFLAGS/s/-O/-O2 -fomit-frame-pointer/" hints && \
./sys/unix/setup.sh hints
# echo 'LFLAGS=-static' >> hints

RUN HOME= make
RUN HOME= make install

WORKDIR /nh/install
# CMD ["/nh/install/games/nethack"]
CMD tar cz .
