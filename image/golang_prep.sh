#!/bin/bash
set -ex

locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8
echo '/root' > /etc/container_environment/HOME
packages='build-essential'

# Installing golang requires golang 1.4.x
curl -fSL -o go1.4.3.linux-amd64.tar.gz https://dl.google.com/go/go1.4.3.linux-amd64.tar.gz
echo "332b64236d30a8805fc8dd8b3a269915b4c507fe go1.4.3.linux-amd64.tar.gz" | sha1sum -c -
mkdir -p /usr/local/go1.4
mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
tar -zxf go1.4.3.linux-amd64.tar.gz -C /usr/local/go1.4 --strip-components=1
rm -rf go1.4.3.linux-amd64.tar.gz
export GOROOT_BOOTSTRAP=/usr/local/go1.4