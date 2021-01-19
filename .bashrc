[ -f "$HOME/.bash_aliases" ] && . "$HOME/.bash_aliases"

eval `ssh-agent -s`
trap 'test -n "$SSH_AGENT_PID" && eval `ssh-agent -k`' 0
