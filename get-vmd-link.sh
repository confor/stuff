#!/usr/bin/bash

# script to get a download link for vmd alpha
# or you can just go to https://www.ks.uiuc.edu/Research/vmd/vmd-1.9.4/files/

set -euo pipefail

USERNAME=nanana
PASSWORD=nonono
VERS=1515
TAG="1.9.4 alpha 57 linux x64"  # unused

# fix for grep
export LC_ALL=en_US.utf8

# log in to vmd
html="$(curl --silent 'https://www.ks.uiuc.edu/Development/Download/download.cgi?UserID=&AccessCode=&ArchiveID='"$VERS" \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Origin: https://www.ks.uiuc.edu' \
  -H 'Referer: https://www.ks.uiuc.edu/Development/Download/download.cgi?UserID=&AccessCode=&ArchiveID='"$VERS" \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.47' \
  --data-raw 'PackageName=&ArchiveID='"$VERS"'&IgnoreCookie=1&LoginForm=1&UserName='"$USERNAME"'&Password='"$PASSWORD"'&.submit=Continue+with+registration+or+download')"

# scrape "cookie-like" values
html_userid="$(<<< "$html" grep -oP '<input[^>]+name="UserID" value="(\d+)"[^>]+>' || true)"
html_access="$(<<< "$html" grep -oP '<input[^>]+name="AccessCode" value="(\d+)"[^>]+>' || true)"

if [[ "$html_userid" == "" ]]; then
	echo "Error: failed to scrape UserID"
	exit 1
fi

if [[ "$html_access" == "" ]]; then
	echo "Error: failed to scrape AccessCode"
	exit 1
fi

# extract numerical id from <input>
real_userid="$(<<< "$html_userid" head -n1 | grep -oE '[0-9]+')"
real_access="$(<<< "$html_access" head -n1 | grep -oE '[0-9]+')"

echo "user id: $real_userid"
echo "access code: $real_access"

html="$(curl --silent 'https://www.ks.uiuc.edu/Development/Download/download.cgi' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Origin: https://www.ks.uiuc.edu' \
  -H 'Referer: https://www.ks.uiuc.edu/Development/Download/download.cgi?UserID=&AccessCode=&ArchiveID='"$VERS" \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.64 Safari/537.36 Edg/101.0.1210.47' \
  --data-raw 'UserID='"$real_userid"'&AccessCode='"$real_access"'&ArchiveID='"$VERS"'&AgreeToLicense=I+am+'"$USERNAME"'+'"$PASSWORD"'+and+I+agree+to+the+terms+of+this+License')"

# scrape download link
html_link="$(<<< "$html" grep -oP 'If it does not, select <a href="([^"]+)">this link<\/a>')"

# this would be so fucking easy with python or a real programming language
real_link="$(<<< "$html_link" grep -oE '\/Research\/vmd\/[a-zA-Z0-9\/\.\-]+\.tar\.gz')"

echo "VMD $VERS ($TAG) download link:"
echo "https://www.ks.uiuc.edu$real_link"
