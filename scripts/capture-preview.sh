#!/bin/bash
# capture-preview.sh — Capture key frames from HyperFrames preview for visual QA
# Usage: ./capture-preview.sh [preview_url] [output_dir] [timestamps...]
# Requires: curl + a way to screenshot (hyperframes CLI or browser)

PREVIEW_URL="${1:-http://localhost:3000}"
OUTPUT_DIR="${2:-./frame-review}"
mkdir -p "$OUTPUT_DIR"

# Default key timestamps (seconds)
TIMESTAMPS=("${@:3}")
if [ ${#TIMESTAMPS[@]} -eq 0 ]; then
  TIMESTAMPS=(0 10 30 60 90 120)
fi

echo "Capturing preview frames from $PREVIEW_URL"
echo "Output: $OUTPUT_DIR"

for ts in "${TIMESTAMPS[@]}"; do
  # Try hyperframes CLI screenshot if available
  if npx hyperframes screenshot --help &> /dev/null; then
    npx hyperframes screenshot "$PREVIEW_URL" \
      --time "$ts" \
      --output "$OUTPUT_DIR/frame_${ts}s.png" 2>/dev/null && continue
  fi

  # Fallback: wget/curl to save HTML and note limitation
  echo "  [$ts s] Screenshot requires browser automation."
  echo "  Open $PREVIEW_URL in browser, seek to ${ts}s, and save screenshot."
done

echo ""
echo "Review each frame for:"
echo "  [ ] Text readability (contrast ≥ 4.5:1)"
echo "  [ ] Subtitle position (no overlap with key content)"
echo "  [ ] Animation feel (timing natural?)"
echo "  [ ] Layout balance (not empty/cramped)"
echo "  [ ] Safe zones (critical content >60px from edges)"
