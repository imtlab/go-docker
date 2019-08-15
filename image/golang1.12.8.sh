#!/bin/bash
set -e
source /golang_build/buildconfig
source /golang_build/golang_prep.sh
source /golang_build/golang_install
set -x

golang_VERSION=1.12.8
golang_DOWNLOAD_SHA256=11ad2e2e31ff63fcf8a2bdffbe9bfa2e1845653358daed593c8c2d03453c9898

golang_install
