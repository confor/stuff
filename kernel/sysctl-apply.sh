#!/usr/bin/bash

set -euo pipefail

if [[ ! -f "$1" ]]; then
	echo "Error: $1 does not exist"
	exit 1
fi

grep -v '^#' "$1" | xargs -n1 sysctl -w
