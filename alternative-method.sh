#!/bin/bash

# This file is a WIP and is an alternative to the dl.py application. This method utilizes built-in functions
# in yt-dlp to only download videos after a certain date. However, this comes at a cost of a lot more API hits
# at the tradeoff of being a simpler script. The only thing left to do are 'quality of life' upgrades such as
# date saving and \n deliminated lists. 

NOW=$(date '+%Y-%m-%d')
LAST_FILE_PATH=$(pwd)/alternative-method-last.txt
SUBS_FILE_PATH=$(pwd)/alternative-method-subs.txt

if [ ! -f "$SUBS_FILE_PATH" ]; then
  echo 'https://www.youtube.com/c/MattKC' > $SUBS_FILE_PATH
  echo 'Created sample subscription file'
fi

if [ ! -f "$LAST_FILE_PATH" ]; then
  echo $NOW > $LAST_FILE_PATH
  echo 'Created Last file. Now exiting'
  exit 0
fi

LAST=$(cat $LAST_FILE_PATH)

yt-dlp \
  --dateafter $LAST \
  --playlist-end 5 \
  --break-on-existing \
  -a $SUBS_FILE_PATH

echo $NOW > $LAST_FILE_PATH
