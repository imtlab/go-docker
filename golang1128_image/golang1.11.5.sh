#!/bin/bash
set -e
source /golang_build/buildconfig
source /golang_build/golang_prep.sh
source /golang_build/golang_install
set -x

golang_VERSION=1.11.5
golang_DOWNLOAD_SHA256=bc1ef02bb1668835db1390a2e478dcbccb5dd16911691af9d75184bbe5aa943e

golang_install
