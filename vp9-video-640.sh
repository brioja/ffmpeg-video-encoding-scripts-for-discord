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

# Check if file is video, get duration if it is

DURATION=$(ffprobe -hide_banner "$1" -show_entries format=duration -v quiet -of csv="p=0")

if [[ "$DURATION" == "" ]]; then
	echo Error, ffprobe returned no duration. "$1" is possibly not a video file
	exit
fi

echo "$1" is a video file and is $DURATION seconds long



# ffmpeg -y -i "$1" -vf scale=640:-1,fps=30 -fs ${MAX_VIDEO_SIZE} -b:v 276k \
#   -minrate 138k -maxrate 400k -tile-columns 1 -g 240 -threads 4 \
#   -quality good -crf 36 -c:v libvpx-vp9 -c:a libopus \
#   -pass 1 -speed 4 "$1-compressed-640.webm"  && \
# ffmpeg -y -i "$1" -vf scale=640:-1,fps=30 -fs ${MAX_VIDEO_SIZE} -b:v 276k \
#   -minrate 138k -maxrate 400k -tile-columns 1 -g 240 -threads 4 \
#   -quality good -crf 36 -c:v libvpx-vp9 -c:a libopus \
#   -pass 2 -speed 4 -y "$1-compressed-640.webm" 


ffmpeg -y -i "$1" -vf scale=640:-1,fps=24 -fs ${MAX_VIDEO_SIZE} -b:v 276k \
  -minrate 138k -maxrate 400k -tile-columns 1 -g 240 -threads 4 -ss 00:00:02 \
  -quality good -crf 36 -c:v libvpx-vp9 -an \
  -pass 1 -speed 4 "$1-compressed-640.webm"  && \
ffmpeg -y -i "$1" -vf scale=640:-1,fps=24 -fs ${MAX_VIDEO_SIZE} -b:v 276k \
  -minrate 138k -maxrate 400k -tile-columns 1 -g 240 -threads 4 -ss 00:00:02 \
  -quality good -crf 36 -c:v libvpx-vp9 -an \
  -pass 2 -speed 4 -y "$1-compressed-640.webm" 



