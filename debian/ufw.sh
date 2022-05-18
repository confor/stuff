#!/usr/bin/bash
set -eu

apt install ufw
ufw allow 22  # ssh
ufw allow from 10.0.0.2  # bastion host

printf "\e[91mHEYYYYYY PAY ATTENTION LOOK AT THIS MESSAGE its very important\e[0m\n"
printf "\e[91mHEYYYYYY PAY ATTENTION LOOK AT THIS MESSAGE its very important\e[0m\n"
printf "\e[91mHEYYYYYY PAY ATTENTION LOOK AT THIS MESSAGE its very important\e[0m\n"
printf "\e[91mHEYYYYYY PAY ATTENTION LOOK AT THIS MESSAGE its very important\e[0m\n"
printf "\e[91mHEYYYYYY PAY ATTENTION LOOK AT THIS MESSAGE its very important\e[0m\n"
printf "\e[91mHEYYYYYY PAY ATTENTION LOOK AT THIS MESSAGE its very important\e[0m\n"
printf "\e[91mHEYYYYYY PAY ATTENTION LOOK AT THIS MESSAGE its very important\e[0m\n"
echo "Enable the firewall with ufw enable"
echo "WARNING: ufw can interrupt ssh sessions"
echo "WARNING: your currently configured ports are:"
grep -rF 'Port' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/

echo "WARNING YOU ALREADY LOCKED YOURSELF OUT LIKE THRICE"
echo "WARNING DONT JUST ENABLE THE FIREWALL, FUCKING PAY ATTENTION TO THE SSH DAEMON"
echo " !!!!!!!!!!! !!!!!!! !!!!!!! !!!!!!!! !!!!!!!!!!!!!! !!!!!11 "
echo "please >>pay attention to ssh when enabling the firewall<"
echo ">>>>>pay attention to ssh when enabling the firewall<<<<<"
echo ">>>>>pay attention to ssh when enabling the firewall<<<<<"
