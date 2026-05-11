#!/usr/bin/env bash
# Build a module firmware using the Mutable Instruments toolchain container.
# Usage: ./build.sh [module] [make targets...]
#   module       - subdirectory containing the makefile (default: rings)
#   make targets - any additional make targets, e.g. wav (default: none)
#
# Examples:
#   ./build.sh
#   ./build.sh rings
#   ./build.sh rings wav

set -euo pipefail

MODULE="${1:-rings}"
shift || true  # remaining args are extra make targets

CONTAINER_IMAGE="docker.io/archont94/mutable-env:latest"

exec podman run --rm \
    -v "$(pwd)":/target \
    -w /target \
    -e PYTHONPATH=/target \
    "${CONTAINER_IMAGE}" \
    bash -c "make -f ${MODULE}/makefile $*"
