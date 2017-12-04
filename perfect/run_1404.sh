#!/bin/bash

# Determine location of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export LD_LIBRARY_PATH=$SCRIPT_DIR/openssl-1.0.2m
exec $SCRIPT_DIR/.build/x86_64-unknown-linux/release/perfect


