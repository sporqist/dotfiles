#!/bin/bash

tmp1=$(mktemp --suffix=.png)
tmp2=$(mktemp --suffix=.png)

scrot -o $tmp1

ffmpeg -i $tmp1 -vf "boxblur=10:1" -vframes 1 -y $tmp2 -loglevel quiet

i3lock -i $tmp2
rm $tmp1
rm $tmp2
