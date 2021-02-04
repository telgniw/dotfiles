[ -f "$HOME/.bash_aliases" ] && . "$HOME/.bash_aliases"

eval `ssh-agent -s`
trap 'test -n "$SSH_AGENT_PID" && eval `ssh-agent -k`' 0

ffcut() {
  set -x
  local SS=${2:+-ss $2}
  local TO=${3:+-to $3}
  local OUT=${OUTDIR:+${OUTDIR%/}/}${1%.*}${2:+_${2//:/}}${3:+_${3//:/}}.${1#*.}
  ffmpeg $SS -i $1 -c copy -copyts $TO $OUT
  set +x
}

fftweet() {
  # Min resolution    32 x 32
  # Max resolution  1920 x 1200
  # Max frame rate    40 fps
  # Max bitrate       25 Mbps
  set -x
  local BR=${BR:--b:v 24M}
  local FR=${FR:--r 30}
  local VF=${VF:--vf scale=960:-1}
  local OUT=${1%.*}_tweet.mp4
  ffmpeg -i $1 $VF -c:v libx264 $BR $FR $OUT
  set +x
}

ns-dl() {
  set -x
  wget http://192.168.0.1/data.json
  jq .FileNames[] < data.json | xargs -I {} wget http://192.168.0.1/img/{}
  rm -f data.json
  set +x
}

yt-mp3() {
  set -x
  youtube-dl -x --audio-format=mp3 $1
  set +x
}

beatoraja() {
  set -x
  local BEATORAJA_PATH="$HOME/Applications/beatoraja0.8.1"
  local JAVA_PATH="$HOME/Library/Application Support/minecraft/runtime/jre-x64/jre.bundle/Contents/Home/bin"
  local CMD=
  if [[ $# -gt 0 ]] && [[ $1 == [a-z]* ]]; then
    CMD=$1 && shift
  fi
  case $CMD in
    '')
      bash -c "cd '$BEATORAJA_PATH' && PATH='$JAVA_PATH:$PATH' java -jar beatoraja.jar"
      ;;
    add)
      local I=
      for I in "${@}"; do
        if [[ $I == *.zip ]]; then
          local TARGET="$BEATORAJA_PATH/ipfs/$(basename "${I%%.zip}")"
          mkdir -p "$TARGET"
          unzip "$I" -d "$TARGET"
        else
          mv "$I" "$BEATORAJA_PATH/ipfs"
        fi
      done
      ;;
    *)
      echo Unknown command $0 $CMD
      ;;
  esac
  set +x
}
