#!/bin/bash
P=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo dfu-util -D $P/config/linux.bin
elif [[ "$OSTYPE" == "darwin"* ]]; then
    sudo dfu-util -D $P/config/mac.bin
fi
