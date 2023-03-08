#!/bin/bash

alpha="95"
saturation="0.5"
colorscheme="sexy-zenburn"
# Backends: colorthief, colorz, haishoku, wal
backend="colorz"

# "$@" ist das erste Argument
#img="$(find ./ -type f | shuf -n 1)"
if [[ -d "$@" ]]; then
    cd "$@"
    img="$(find $@/ -type f | shuf -n 1)"
elif [[ -f "$@" ]]; then
    img="$@"
else echo "usage: ./wallpapercolor.sh [file/dir ...]";
    exit 1
fi

cp $img "$HOME/.cache/background"

if [[ $I3SOCK = *i3/ipc-socket* ]]; then
    killall polybar
    #feh --bg-fill $img
    #wal -a $alpha -n --theme $colorscheme
    #wal -a $alpha --saturate $saturation --backend $backend -i "$img"
    wal -a 99 --saturate $saturation --backend $backend -i "$img" -n
    feh --bg-fill $img
    ~/.config/polybar/start-polybar.sh

    killall dunst; notify-send -u low "extracted colors from $img"
fi
if [[ $DESKTOP_SESSION = *sway ]]; then
    killall waybar
    ~/.config/mako/mako-walcolors.sh
    wal -a $alpha -n --saturate $saturation --backend $backend -i "$img"
    waybar
fi
#wal -a $alpha -n --theme $colorscheme

# Sway i3 config to make this work:
# ~/.config/sway/config
# output * bg $HOME/.cache/background fill

