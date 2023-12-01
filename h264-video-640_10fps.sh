#!/bin/bash

set -x

MAX_VIDEO_SIZE="7800000" # 7.8 MB for free Discord users
BITRATE="300k" # Adjust this bitrate as needed

if [[ "$1" == "" ]]; then
    echo "Error: No video file selected"
    echo "Usage: $0 <video-file>"
    exit
fi

PRESET="slow" # A slower preset for better compression efficiency

ffmpeg -y -ss 00:00:00 -i "$1" -c:v libx264 -preset ${PRESET} -b:v ${BITRATE} -vf scale=640:-1,fps=10 -fs ${MAX_VIDEO_SIZE} -pass 1 -an -f null /dev/null
ffmpeg -y -ss 00:00:00 -i "$1" -c:v libx264 -preset ${PRESET} -b:v ${BITRATE} -vf scale=640:-1,fps=10 -fs ${MAX_VIDEO_SIZE} -pass 2 -an "$1-compressed-640_10fps.mp4"
