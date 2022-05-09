#!/usr/bin/bash

set -euo pipefail

if ! echo "$PATH" | tr ':' '\n' | grep -F '/sbin' > /dev/null; then
	echo "Error: missing sbin from PATH"
	echo "Error: can't use apparmor, sysctl"
	echo "Error: please append /usr/sbin/ to \$PATH"
	exit 1
fi

echo "Current config for unprivileged user namespaces (should be 1):"
sysctl kernel.unprivileged_userns_clone | bat

printf '\n\n'

echo "Current user s*id limits (default 100000:65536, should match lxc.idmap):"
grep -F "$USER" /etc/s*id | bat

printf '\n\n'

echo "Changing default keyserver:"
echo 'export DOWNLOAD_KEYSERVER="hkp://keyserver.ubuntu.com:80"' | tee ~/.bashrc.d/99-default-keyserver | bat
chmod +x ~/.bashrc.d/99-default-keyserver
. ~/.bashrc.d/99-default-keyserver

printf '\n\n'

echo "Granting a+rw access to ~/.local/share/lxc/"
chmod a+rx ~/.local/
chmod a+rx ~/.local/share/
chmod a+rx ~/.local/share/lxc/

printf '\n\n'

# debian issue: apparmor needs to be unconfined
# https://github.com/lxc/lxc/issues/1895#issuecomment-351014947
echo "Writing default user settings..."
echo "Warn: will disable apparmor"
mkdir -p ~/.config/lxc/
touch ~/.config/lxc/default.conf
tee ~/.config/lxc/default.conf << END | bat
lxc.include = /etc/lxc/default.conf
lxc.idmap = u 0 100000 65536
lxc.idmap = g 0 100000 65536

lxc.apparmor.profile = unconfined

END

#apt-get install --no-install-recommends --no-install-suggests lxc libvirt0 bridge-utils uidmap
