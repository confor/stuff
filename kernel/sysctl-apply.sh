#!/usr/bin/bash

set -euo pipefail

if [[ ! -f "$1" ]]; then
	echo "Error: $1 does not exist"
	exit 1
fi

sysctl --load="$1"
