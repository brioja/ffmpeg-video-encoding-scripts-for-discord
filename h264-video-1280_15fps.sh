#!/bin/bash

set -x

MAX_VIDEO_SIZE="7800000"

if [[ "$1" == "" ]]; then
	echo "Error: No video file selected"
	echo "Usage: $0 <video-file>"
	exit
fi

ffmpeg -y -ss 00:00:00 -i "$1" -c:v libx264 -vf scale=1280:-1,fps=15 -fs ${MAX_VIDEO_SIZE} -b:v 512k -pass 1 -an -f null /dev/null
ffmpeg -y -ss 00:00:00 -i "$1" -c:v libx264 -vf scale=1280:-1,fps=15 -fs ${MAX_VIDEO_SIZE} -b:v 512k -pass 2 -an "$1-compressed-1280_15fps.mp4" 
