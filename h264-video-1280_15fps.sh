#!/bin/bash

set -x

#Good
#MAX_VIDEO_SIZE="8000000"
MAX_VIDEO_SIZE="7800000"


# Large
#MAX_VIDEO_SIZE="8300000"

# Check argument

if [[ "$1" == "" ]]; then
	echo "Error: No video file selected"
	echo "Usage: $0 <video-file>"
	exit
fi

#ffmpeg -ss 00:00:00 -y -i "$1" -vf scale=1920:-1,fps=15 -fs ${MAX_VIDEO_SIZE} -b:v 900k \
#  -minrate 450k -maxrate 1305k -tile-columns 2 -g 240 -threads 8 \
#  -quality good -crf 31 -c:v libvpx-vp9 -an \
#  -pass 1 -speed 4 "$1-compressed-1920_15fps.webm" && \
#ffmpeg -ss 00:00:00 -y -i "$1" -vf scale=1920:-1,fps=15 -fs ${MAX_VIDEO_SIZE} -b:v 900k \
#  -minrate 450k -maxrate 1305k -tile-columns 3 -g 240 -threads 8 \
#  -quality good -crf 31 -c:v libvpx-vp9 -an \
#  -pass 2 -speed 2 -y "$1-compressed-1920_15fps.webm"


ffmpeg -y -ss 00:00:00 -i "$1" -c:v libx264 -vf scale=1280:-1,fps=15 -fs ${MAX_VIDEO_SIZE} -b:v 512k -pass 1 -an -f null /dev/null
ffmpeg -y -ss 00:00:00 -i "$1" -c:v libx264 -vf scale=1280:-1,fps=15 -fs ${MAX_VIDEO_SIZE} -b:v 512k -pass 2 -an "$1-compressed-1280_15fps.mp4" 
