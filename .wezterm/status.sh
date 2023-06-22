#!/usr/bin/env bash

WORKDIR=${1}
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    export PATH="${PATH}:/var/run/host/usr/local/bin"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="${PATH}:/opt/homebrew/bin"
fi

cd ${WORKDIR}

starship prompt
