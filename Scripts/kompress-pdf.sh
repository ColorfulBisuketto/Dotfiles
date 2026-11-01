#!/usr/bin/env bash

INPUT="$1"
OUTPUT="$2"

if [[ -n $2 ]]; then
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default \
    -dQUIET -dDetectDuplicateImages \
    -dCompressFonts=true -r150 -o "$2" "$1"
else
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default \
    -dQUIET -dDetectDuplicateImages \
    -dCompressFonts=true -r150 -o "komp_$1" "$1"
fi
