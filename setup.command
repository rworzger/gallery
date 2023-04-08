#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "$0")

# Create a duplicate of each photo, and then minify them


for d in $SCRIPT_PATH/photos/** ;
  do (cd $d && sips -s format jpeg -s formatOptions high $d/* --out "$d" && find $d -name "*.ARW" -type f -delete);
done

if [[ "$OSTYPE" == "darwin"* && -x "$(command -v sips)" ]]; then
  # sips is available
  # low res version of image
  python3 $SCRIPT_PATH/tools/duplicate.py min
  sips -Z 640 $SCRIPT_PATH/photos/**/*.min.jpeg &>/dev/null
  sips -Z 640 $SCRIPT_PATH/photos/**/*.min.png &>/dev/null
  sips -Z 640 $SCRIPT_PATH/photos/**/*.min.jpg &>/dev/null
  sips -Z 640 $SCRIPT_PATH/photos/**/*.min.JPG &>/dev/null
  # sips -Z 640 $SCRIPT_PATH/photos/**/*.min.ARW &>/dev/null
  

  # placeholder image for lazy loading
  python3 $SCRIPT_PATH/tools/duplicate.py placeholder
  sips -Z 32 $SCRIPT_PATH/photos/**/*.placeholder.jpeg &>/dev/null
  sips -Z 32 $SCRIPT_PATH/photos/**/*.placeholder.png &>/dev/null
  sips -Z 32 $SCRIPT_PATH/photos/**/*.placeholder.jpg &>/dev/null
  sips -Z 32 $SCRIPT_PATH/photos/**/*.placeholder.JPG &>/dev/null
  # sips -Z 32 $SCRIPT_PATH/photos/**/*.placeholder.ARW &>/dev/null
  
fi

if [ -n "$(uname -a | grep Ubuntu)" -a -x "$(command -v mogrify)" ]; then
  # mogrify is available
  # low res version of image
  python3 $SCRIPT_PATH/tools/duplicate.py min
  mogrify -resize 640x $SCRIPT_PATH/photos/**/*.min.jpeg &>/dev/null
  mogrify -resize 640x $SCRIPT_PATH/photos/**/*.min.png &>/dev/null
  mogrify -resize 640x $SCRIPT_PATH/photos/**/*.min.jpg &>/dev/null
  mogrify -resize 640x $SCRIPT_PATH/photos/**/*.min.JPG &>/dev/null
  # mogrify -resize 640x $SCRIPT_PATH/photos/**/*.min.ARW &>/dev/null

  # placeholder image for lazy loading
  python3 $SCRIPT_PATH/tools/duplicate.py placeholder
  mogrify -resize 32x $SCRIPT_PATH/photos/**/*.placeholder.jpeg &>/dev/null
  mogrify -resize 32x $SCRIPT_PATH/photos/**/*.placeholder.png &>/dev/null
  mogrify -resize 32x $SCRIPT_PATH/photos/**/*.placeholder.jpg &>/dev/null
  mogrify -resize 32x $SCRIPT_PATH/photos/**/*.placeholder.JPG &>/dev/null
  # mogrify -resize 32x $SCRIPT_PATH/photos/**/*.placeholder.ARW &>/dev/null
fi  

python3 $SCRIPT_PATH/tools/setup.py
