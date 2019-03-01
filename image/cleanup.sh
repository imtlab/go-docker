#!/bin/bash
set -e
source /golang_build/buildconfig
set -x

apt-get clean
rm -rf /usr/local/go1.4
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

rm -f /etc/ssh/ssh_host_*
rm -rf /golang_build