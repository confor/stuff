#!/usr/bin/bash
set -eu

apt install ufw
ufw allow 22  # ssh
ufw allow from 10.0.0.2  # bastion host

echo "Enable with: ufw enable"
printf "\e[91mHEYYYYYY PAY ATTENTION LOOK AT THIS MESSAGE its very important\e[0m\n"
echo "WARNING: ufw can interrupt ssh sessions"
echo "WARNING: your currently configured ports are:"
grep -rF Port /etc/ssh/sshd_config /etc/ssh/sshd_config.d/
