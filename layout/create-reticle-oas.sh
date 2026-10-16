#!/bin/sh
set -Ce
cat GFMPW0-part-* > GFMPW0.oas
echo "366739415ab37e49a4330761db15c940  GFMPW0.oas" | md5sum -c
