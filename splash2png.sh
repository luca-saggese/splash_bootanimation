#!/bin/bash
[[ -z "$1" ]] && echo "No image file supplied as argument. Exiting." && exit 1

RESOLUTION="160x128"
SPLASH_IMG_PATH="$1"
SPLASH_IMG_FILENAME=${SPLASH_IMG_PATH##*/}
SPLASH_OUT=${2:-${SPLASH_IMG_FILENAME%.*}.png}

ffmpeg \
  -loglevel error \
  -hide_banner \
  -f rawvideo \
  -vcodec rawvideo \
  -pix_fmt rgb565 \
  -skip_initial_bytes 512 \
  -s $RESOLUTION \
  -i $SPLASH_IMG_PATH \
  -vframes 1 \
  -y $SPLASH_OUT \
  && echo "Converted image: $SPLASH_OUT"
