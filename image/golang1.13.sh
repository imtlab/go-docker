#!/bin/bash
set -e
source /golang_build/buildconfig
source /golang_build/golang_prep.sh
source /golang_build/golang_install
set -x

golang_VERSION=1.13
golang_DOWNLOAD_SHA256=3fc0b8b6101d42efd7da1da3029c0a13f22079c0c37ef9730209d8ec665bf122

golang_install
