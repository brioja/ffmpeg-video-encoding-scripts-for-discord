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

ffmpeg -y -i "$1" -vf scale=1280:-1,fps=30 -fs ${MAX_VIDEO_SIZE} -b:v 1024k \
  -minrate 512k -maxrate 1485k -tile-columns 2 -g 240 -threads 8 \
  -quality good -crf 32 -c:v libvpx-vp9 -c:a libopus \
  -pass 1 -speed 4 "$1-compressed-1280.webm" && \
ffmpeg -y -i "$1" -vf scale=1280:-1,fps=30 -fs ${MAX_VIDEO_SIZE} -b:v 1024k \
  -minrate 512k -maxrate 1485k -tile-columns 2 -g 240 -threads 8 \
  -quality good -crf 32 -c:v libvpx-vp9 -c:a libopus \
  -pass 2 -speed 2 -y "$1-compressed-1280.webm"
