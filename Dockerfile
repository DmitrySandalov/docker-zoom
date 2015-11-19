FROM phusion/baseimage
MAINTAINER Dmitry Sandalov <dmitry@sandalov.org>

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install \
  dbus fontconfig-config fonts-dejavu-core gcc-4.8-base:i386 gcc-4.9-base:i386 \
  iso-codes libapparmor1 libasyncns0:i386 libc6:i386 libcgmanager0:i386 \
  libdbus-1-3:i386 libdrm-intel1:i386 libdrm-nouveau2:i386 libdrm-radeon1:i386 \
  libdrm2:i386 libelf1:i386 libexpat1:i386 libffi6:i386 libflac8:i386 \
  libfontconfig1:i386 libfreetype6:i386 libgcc1:i386 libgcrypt11:i386 \
  libgl1-mesa-dri:i386 libgl1-mesa-glx:i386 libglapi-mesa:i386 \
  libglib2.0-0:i386 libgpg-error0:i386 libgstreamer-plugins-base0.10-0:i386 \
  libgstreamer0.10-0:i386 libice6:i386 libjson-c2:i386 libllvm3.4:i386 \
  liblzma5:i386 libnih-dbus1:i386 libnih1:i386 libogg0:i386 liborc-0.4-0:i386 \
  libpam-systemd libpciaccess0:i386 libpcre3:i386 libpng12-0:i386 \
  libpulse0:i386 libselinux1:i386 libsm6:i386 libsndfile1:i386 \
  libsqlite3-0:i386 libssl1.0.0:i386 libstdc++6:i386 libsystemd-daemon0 \
  libsystemd-login0 libtinfo5:i386 libtxc-dxtn-s2tc0:i386 libudev1:i386 \
  libuuid1:i386 libvorbis0a:i386 libvorbisenc2:i386 libwrap0 libwrap0:i386 \
  libx11-6:i386 libx11-data libx11-xcb1:i386 libxau6:i386 libxcb-dri2-0:i386 \
  libxcb-dri3-0:i386 libxcb-glx0:i386 libxcb-present0:i386 libxcb-randr0:i386 \
  libxcb-shape0:i386 libxcb-shm0:i386 libxcb-sync1:i386 libxcb-xfixes0:i386 \
  libxcb1:i386 libxcomposite1:i386 libxdamage1:i386 libxdmcp6:i386 \
  libxext6:i386 libxfixes3:i386 libxi6:i386 libxml2:i386 libxrender1:i386 \
  libxshmfence1:i386 libxslt1.1:i386 libxxf86vm1:i386 systemd-services \
  systemd-shim tcpd uuid-runtime x11-common zlib1g:i386 desktop-file-utils

RUN curl -L https://zoom.us/client/latest/ZoomInstaller_i386.deb > /tmp/ZoomInstaller_i386.deb
RUN dpkg -i /tmp/ZoomInstaller_i386.deb && rm /tmp/ZoomInstaller_i386.deb
RUN rm -rf /var/lib/apt/lists/*

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    mkdir -p /home/developer/.config && \
    mkdir -p /home/developer/.zoom && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer

COPY conf/zoomus.conf /home/developer/.config/zoomus.conf
VOLUME ["/home/developer/.zoom"]

ADD ./bin /usr/local/sbin
CMD run
