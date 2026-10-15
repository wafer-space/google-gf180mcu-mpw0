#!/bin/sh
set -Ce
cat GFMPW0-part-* > GFMPW0.oas
echo "7525ae37d7dd64486a25baca24a9b771  GFMPW0.oas" | md5sum -c
