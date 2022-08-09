#!/bin/bash

set -x


MAX_VIDEO_SIZE="8000000"

# Check argument

if [[ "$1" == "" ]]; then
	echo "Error: No video file selected"
	echo "Usage: $0 <video-file>"
	exit
fi

# Check if file is video, get duration if it is

# DURATION=$(ffprobe -hide_banner "$1" -show_entries format=duration -v quiet -of csv="p=0")

# if [[ "$DURATION" == "" ]]; then
# 	echo Error, ffprobe returned no duration. "$1" is possibly not a video file
# 	exit
# fi

# echo "$1" is a video file and is $DURATION seconds long


#nice -n 19 ffmpeg -y -i "$1" -vf scale=320:-1 -b:v 150k -minrate 75k -maxrate 218k -tile-columns 0 -g 240 -threads 2 -quality good -crf 37 -c:v libvpx-vp9 -an -pass 1 -speed 4 "$1-compressed-320.webm"
#nice -n 19 ffmpeg -y -i "$1" -vf scale=320:-1 -b:v 150k -minrate 75k -maxrate 218k -tile-columns 0 -g 240 -threads 2 -quality good -crf 37 -c:v libvpx-vp9 -an -pass 2 -speed 1 "$1-compressed-320.webm"

nice -n 19 ffmpeg -y -i "$1" -vf scale=320:-1,fps=15 -fs ${MAX_VIDEO_SIZE} -b:v 150k -minrate 75k -maxrate 218k -tile-columns 0 -g 240 -threads 2 -quality good -crf 37 -c:v libvpx-vp9 -an -pass 1 -speed 4 "$1-compressed-320.webm" && \
nice -n 19 ffmpeg -y -i "$1" -vf scale=320:-1,fps=15 -fs ${MAX_VIDEO_SIZE} -b:v 150k -minrate 75k -maxrate 218k -tile-columns 0 -g 240 -threads 2 -quality good -crf 37 -c:v libvpx-vp9 -an -pass 2 -speed 1 "$1-compressed-320.webm"
