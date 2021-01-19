[ -f "$HOME/.bash_aliases" ] && . "$HOME/.bash_aliases"

eval `ssh-agent -s`
trap 'test -n "$SSH_AGENT_PID" && eval `ssh-agent -k`' 0

ffcut() {
  set -x
  SS=${2:+-ss $2}
  TO=${3:+-to $3}
  OUT=${OUTDIR:+${OUTDIR%/}/}${1%.*}${2:+_${2//:/}}${3:+_${3//:/}}.${1#*.}
  ffmpeg $SS -i $1 -c copy -copyts $TO $OUT
  set +x
}

fftweet() {
  # Min resolution    32 x 32
  # Max resolution  1920 x 1200
  # Max frame rate    40 fps
  # Max bitrate       25 Mbps
  set -x
  BR=${BR:--b:v 24M}
  FR=${FR:--r 30}
  VF=${VF:--vf scale=960:-1}
  OUT=${1%.*}_tweet.mp4
  ffmpeg -i $1 $VF -c:v libx264 $BR $FR $OUT
  set +x
}
