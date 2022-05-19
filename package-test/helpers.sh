#!/usr/bin/bash

declare -A COLORS
COLORS[DEFAULT]="\e[39m"
COLORS[RED]="\e[91m"
COLORS[YELLOW]="\e[93m"

declare -a SUPPORTED_PMS=(apt pip3)

declare -A CMD_INSTALL
declare -A CMD_UNINSTALL
declare -A CMD_SEARCH
declare -A CMD_UPDATE
declare -A CMD_UPGRADE
declare -A CMD_PURGE

CMD_INSTALL[apt]='apt-get install'
CMD_UNINSTALL[apt]='apt-get remove'
CMD_SEARCH[apt]='apt-cache search --names-only'
CMD_UPDATE[apt]='apt update'
CMD_UPGRADE[apt]='apt upgrade'  # should this be apt-get upgrade && apt-get dist-upgrade?
CMD_PURGE[apt]='apt-get remove --purge'

CMD_INSTALL[pip3]='python3 -m pip install'
CMD_UNINSTALL[pip3]='python3 -m pip uninstall'
CMD_SEARCH[pip3]='python3 -m pip search'  # wasn't this removed??
CMD_UPDATE[pip3]='echo pip doesnt need list updates'
CMD_UPGRADE[pip3]='python3 -m pip install --upgrade'
CMD_PURGE[pip3]='printf "pip doesnt support purging packages\n" #'

function _usage() {
	echo "Usage: asd <subcommand> [args]..."
	echo ''
	echo "Supported subcommands:"
	echo "  add | install    install packages"
	echo "  del | uninstall  uninstall packages"
	echo "  search           search for a package"
	echo "  update           download fresh package lists"
	echo "  upgrade          install new versions of installed packages"
	echo "  purge            wipe clean some packages"
	echo "  system           read or change currently managed package manager"
	echo "  help             this message!"
	echo ""
	echo "Supported package managers:"
	for i in "${SUPPORTED_PMS[@]}"; do
		echo "  $i"
	done
	echo ""
}

function _echo_error() {
	# TODO learn the difference between $@ and $*
	echo -e "${COLORS[RED]}Error:${COLORS[DEFAULT]}" "$@"
}

function _echo_warn() {
	echo -e "${COLORS[YELLOW]}Warn:${COLORS[DEFAULT]}" "$@"
}

function _assert_config_exists() {  # TODO find a better name
	if [[ $CURRENT_SYSTEM == 'unset' ]]; then
		_echo_error "This command needs a package manager"
		_echo_error "Pick one with the 'system' subcommand"
		exit 1
	fi
}
