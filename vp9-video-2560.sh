#!/bin/bash

set -x

#Good
MAX_VIDEO_SIZE="8200000"

# Check argument

if [[ "$1" == "" ]]; then
	echo "Error: No video file selected"
	echo "Usage: $0 <video-file>"
	exit
fi

ffmpeg -y -i "$1" -vf scale=2560:-1 -fs ${MAX_VIDEO_SIZE} -b:v 6000k \
  -minrate 3000k -maxrate 8700k -tile-columns 3 -g 240 -threads 16 \
  -quality good -crf 24 -c:v libvpx-vp9 -an \
  -pass 1 -speed 4 "$1-compressed-2560.webm" && \
ffmpeg -y -i "$1" -vf scale=2560:-1 -fs ${MAX_VIDEO_SIZE} -b:v 6000k \
  -minrate 3000k -maxrate 8700k -tile-columns 3 -g 240 -threads 16 \
  -quality good -crf 24 -c:v libvpx-vp9 -an \
  -pass 2 -speed 4 -y "$1-compressed-2560.webm"
