#!/usr/bin/bash

# get own ipv4 address from external dns nameservers

set -euo pipefail

PROVIDER="$(shuf -n1 -e google akamai opendns)"

if [[ "$PROVIDER" == "google" ]]; then
	echo "querying google.com" >&2
	dig -4 @ns1.google.com -t TXT o-o.myaddr.l.google.com +short | tr -d '"'
elif [[ "$PROVIDER" == "akamai" ]]; then
	echo "querying opendns.com" >&2
	dig -4 @resolver1.opendns.com -t A myip.opendns.com +short
elif [[ "$PROVIDER" == "opendns" ]]; then
	echo "querying akamaitech.net" >&2
	dig -4 @ns1-1.akamaitech.net -t A whoami.akamai.net +short
fi
