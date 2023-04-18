FROM debian:bullseye-slim

RUN usermod -u 99 nobody

# Install WireGuard, OpenVPN and other dependencies for running qbittorrent-nox and the container scripts
RUN apt update \
    && apt -y install --no-install-recommends \
    ca-certificates \
    curl \
    dos2unix \
    inetutils-ping \
    ipcalc \
    iptables \
    kmod \
    libssl1.1 \
    moreutils \
    net-tools \
    openresolv \
    openvpn \
    procps \
    wireguard-tools \
    && apt-get clean \
    && apt -y autoremove \
    && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

VOLUME /config

ADD openvpn/ /etc/openvpn/
ADD passthrough/ /etc/passthrough/

RUN chmod +x /etc/openvpn/*.sh /etc/passthrough/*.sh

CMD ["/bin/bash", "/etc/openvpn/start.sh"]
