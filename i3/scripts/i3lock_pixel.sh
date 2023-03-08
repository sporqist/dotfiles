#!/bin/bash

tmp1=$(mktemp --suffix=.png)
tmp2=$(mktemp --suffix=.png)

scrot -o $tmp1

rescale_factor=20
dimensions=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of "csv=p=0:s=\:" -loglevel quiet $tmp1)
ffmpeg -i $tmp1 -filter_complex "[0:v] scale='iw/$rescale_factor:-1', scale='$dimensions:flags=neighbor'" -loglevel quiet -y $tmp2

i3lock -i $tmp2
rm $tmp1
rm $tmp2
