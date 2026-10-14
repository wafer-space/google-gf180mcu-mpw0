#!/bin/sh
set -Ce
cat GFMPW0-part-* > GFMPW0.oas
echo "da0dca9af1a3e2a4eff536bdb9ff4409  GFMPW0.oas" | md5sum -c
