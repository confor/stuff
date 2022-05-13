alias ll='ls -alF'
alias l='ls -CF'
alias gl='git log --oneline --all --graph --decorate'
alias gs='git status --untracked-files=all --short'
alias gr='git remote -v'

if which nvim > /dev/null; then
	alias vi='nvim'
	alias vim='nvim'
fi

# i don't remember why these are not aliases
lxcattach() { lxc-unpriv-attach --name "$1"; }
lxcstart() { lxc-unpriv-start --name "$1"; }
lxcstop() { lxc-stop --name "$1" --timeout 10; }
lxcls() {
	lxc-ls --fancy --fancy-format NAME,STATE,PID,RAM,SWAP,AUTOSTART,GROUPS,INTERFACE,IPV4,IPV6,UNPRIVILEGED
}
