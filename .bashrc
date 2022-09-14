[ -f "$HOME/.bash_aliases" ] && . "$HOME/.bash_aliases"

eval `ssh-agent -s`
trap 'test -n "$SSH_AGENT_PID" && eval `ssh-agent -k`' 0

ns-dl() {
  set -x
  wget http://192.168.0.1/data.json
  jq .FileNames[] < data.json | xargs -I {} wget http://192.168.0.1/img/{}
  rm -f data.json
  set +x
}
