FROM ubuntu:noble

ENV GMPRIS_VERSION="2.2.1-12"
ENV LIBGUPNP_VERSION="1.6-0_1.6.6-2"
ENV HQPLAYERD_VERSION="5.16.1-45"

RUN apt update \
  && apt install -y curl udev sudo \
  && mkdir -p /etc/udev/rules.d \
  && mkdir -p /etc/sudoers.d \
  && curl -O https://www.sonarnerd.net/src/noble/libgmpris_${GMPRIS_VERSION}_amd64.deb \
  && curl -O https://www.sonarnerd.net/src/noble/libgupnp-${LIBGUPNP_VERSION}_amd64.deb \
  && curl -O https://www.signalyst.eu/bins/hqplayerd/noble/hqplayerd_${HQPLAYERD_VERSION}intel_amd64.deb \
  && apt install -y ./libgmpris_${GMPRIS_VERSION}_amd64.deb \
    ./libgupnp-${LIBGUPNP_VERSION}_amd64.deb \
    ./hqplayerd_${HQPLAYERD_VERSION}intel_amd64.deb \
  && rm -rf ./*.deb \
  && apt clean \
  && rm -rf /var/lib/apt/lists/*

RUN hqplayerd -s hqplayer hqplayer

ENV HOME="/var/lib/hqplayer/home"

ENTRYPOINT ["/usr/bin/hqplayerd"]
