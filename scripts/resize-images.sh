#!/bin/bash
# resize-images.sh — Resize images to max 2x canvas dimensions
# Usage: ./resize-images.sh <input_dir> <max_dimension>
# Example: ./resize-images.sh assets/ 3840

set -euo pipefail

INPUT_DIR="${1:?Usage: resize-images.sh <input_dir> <max_dimension>}"
MAX_DIM="${2:-3840}"

if ! command -v mogrify &> /dev/null; then
  echo "WARNING: ImageMagick 'mogrify' not found. Skipping image resize."
  echo "Install ImageMagick for automatic resizing:"
  echo "  macOS: brew install imagemagick"
  echo "  Ubuntu: sudo apt install imagemagick"
  exit 0
fi

mkdir -p "$INPUT_DIR/resized"

# Resize all jpg/png/webp in input dir
for f in "$INPUT_DIR"/*.{jpg,jpeg,png,webp}; do
  [ -e "$f" ] || continue
  fname=$(basename "$f")
  mogrify -path "$INPUT_DIR/resized" -resize "${MAX_DIM}x${MAX_DIM}>" "$f"
  echo "Resized: $f → $INPUT_DIR/resized/$fname"
done

echo "Done. Use resized/ versions for composition."
