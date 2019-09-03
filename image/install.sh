#!/bin/bash
set -e
source /golang_build/buildconfig
set -x

/golang_build/golang_prep.sh

if [[ "$golang113" = 1 ]]; then /golang_build/golang1.13.sh; fi

/golang_build/cleanup.sh
