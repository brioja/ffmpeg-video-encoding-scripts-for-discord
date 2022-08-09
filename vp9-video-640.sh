#!/bin/bash

set -x

#Good
#MAX_VIDEO_SIZE="8000000"
MAX_VIDEO_SIZE="8000000"


# Large
#MAX_VIDEO_SIZE="8300000"

# Check argument

if [[ "$1" == "" ]]; then
	echo "Error: No video file selected"
	echo "Usage: $0 <video-file>"
	exit
fi


ffmpeg -y -i "$1" -vf scale=640:-1,fps=24 -fs ${MAX_VIDEO_SIZE} -b:v 276k \
  -minrate 138k -maxrate 400k -tile-columns 1 -g 240 -threads 4 -ss 00:00:02 \
  -quality good -crf 36 -c:v libvpx-vp9 -an \
  -pass 1 -speed 4 "$1-compressed-640.webm"  && \
ffmpeg -y -i "$1" -vf scale=640:-1,fps=24 -fs ${MAX_VIDEO_SIZE} -b:v 276k \
  -minrate 138k -maxrate 400k -tile-columns 1 -g 240 -threads 4 -ss 00:00:02 \
  -quality good -crf 36 -c:v libvpx-vp9 -an \
  -pass 2 -speed 1 -y "$1-compressed-640.webm" 



