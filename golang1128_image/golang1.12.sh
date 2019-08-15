#!/bin/bash
set -e
source /golang_build/buildconfig
source /golang_build/golang_prep.sh
source /golang_build/golang_install
set -x

golang_VERSION=1.12
golang_DOWNLOAD_SHA256=09c43d3336743866f2985f566db0520b36f4992aea2b4b2fd9f52f17049e88f2

golang_install
