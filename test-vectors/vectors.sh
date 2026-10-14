#!/bin/sh
# Reference images made and checked by real Linux tools (cryptsetup, exfatprogs) in a privileged container.
#   test-vectors/vectors.sh make            -> test-vectors/out/*.img + *.manifest
#   test-vectors/vectors.sh dirty           -> only the dirty-journal ext4 images
#   test-vectors/vectors.sh check IMG [PASS] -> fsck.exfat + file manifest of IMG (LUKS2 when PASS is given)
# Exit: 0 ok, non-zero on any tool failure (fsck errors included).
set -eu
here=$(cd "$(dirname "$0")" && pwd)
mkdir -p "$here/out"
image=cryptic-vectors:4
docker image inspect $image >/dev/null 2>&1 || docker build -q -t $image - <<'EOF' >/dev/null
FROM debian:trixie-slim
RUN apt-get update && apt-get install -y --no-install-recommends cryptsetup-bin exfatprogs exfat-fuse fuse3 util-linux fdisk e2fsprogs && rm -rf /var/lib/apt/lists/*
EOF
exec docker run --rm --privileged -v "$here:/v" -w /v $image sh /v/inside.sh "$@"
