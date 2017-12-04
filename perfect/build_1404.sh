#!/bin/bash

# Determine location of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

swift build -c release -Xswiftc -I${SCRIPT_DIR}/openssl-1.0.2m/include -Xlinker -L${SCRIPT_DIR}/openssl-1.0.2m
