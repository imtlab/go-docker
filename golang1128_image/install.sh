#!/bin/bash
set -e
source /golang_build/buildconfig
set -x

/golang_build/golang_prep.sh

if [[ "$golang1115" = 1 ]]; then /golang_build/golang1.11.5.sh; fi
if [[ "$golang112" = 1 ]]; then /golang_build/golang1.12.sh; fi
if [[ "$golang1128" = 1 ]]; then /golang_build/golang1.12.8.sh; fi

/golang_build/cleanup.sh
