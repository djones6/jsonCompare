#!/bin/bash

# Determine location of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

exec $SCRIPT_DIR/.build/release/vapor --env=production
