#!/bin/sh
set -Ce
cat GFMPW0-part-* > GFMPW0.oas
echo "820dd74663ba7f04f568dc8d16960428  GFMPW0.oas" | md5sum -c
