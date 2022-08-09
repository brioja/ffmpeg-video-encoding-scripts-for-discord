#!/bin/bash

set -x

#Good
#MAX_VIDEO_SIZE="8000000"
MAX_VIDEO_SIZE="8200000"


# Large
#MAX_VIDEO_SIZE="8300000"

# Check argument

if [[ "$1" == "" ]]; then
	echo "Error: No video file selected"
	echo "Usage: $0 <video-file>"
	exit
fi

ffmpeg -y -i "$1" -vf scale=1920:-1 -fs ${MAX_VIDEO_SIZE} -b:v 1800k \
  -minrate 900k -maxrate 2610k -tile-columns 2 -g 240 -threads 8 \
  -quality good -crf 31 -c:v libvpx-vp9 -an \
  -pass 1 -speed 4 "$1-compressed-1920.webm" && \
ffmpeg -y -i "$1" -vf scale=1920:-1 -fs ${MAX_VIDEO_SIZE} -b:v 1800k \
  -minrate 900k -maxrate 2610k -tile-columns 3 -g 240 -threads 8 \
  -quality good -crf 31 -c:v libvpx-vp9 -an \
  -pass 2 -speed 2 -y "$1-compressed-1920.webm"
