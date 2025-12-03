FROM ghcr.io/void-linux/void-musl-full:20251201r1

ENV XBPS_CHROOT_CMD=uchroot
ENV XBPS_ALLOW_CHROOT_BREAKOUT=yes

RUN mkdir -p /etc/xbps.d
RUN cp /usr/share/xbps.d/*-repository-*.conf /etc/xbps.d/
RUN xbps-install -Syu xbps
RUN xbps-install -Syu sudo git bash gnupg openssh

RUN useradd -G xbuilder -M builder
RUN mkdir /build
RUN chown builder:xbuilder /build

WORKDIR /build
