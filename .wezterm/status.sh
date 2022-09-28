#!/usr/bin/env bash

WORKDIR=${1}
export PATH="${PATH}:/opt/homebrew/bin"

cd ${WORKDIR}

starship prompt
