killall -q polybar
 
# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
 
bar="mybar"

#if [[ $DESKTOP_SESSION = *i3 ]]; then
if [[ $I3SOCK = *i3/ipc-socket* ]]; then
    if type "xrandr"; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload $bar &
      done
    else
      polybar --reload $bar &
    fi
fi
if [[ $SWAYSOCK = *sway-ipc* ]]; then
    for m in $(polybar --list-monitors | cut -d":" -f1); do
        MONITOR=$m polybar --reload $bar -c "$HOME/.config/polybar/config.ini" &
    done
fi
