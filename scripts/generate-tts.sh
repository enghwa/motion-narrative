#!/bin/bash
# generate-tts.sh — Generate TTS audio + VTT subtitles
# Usage: ./generate-tts.sh <text_file> <output_dir> [voice]
# Supports edge-tts (default) and falls back to Kokoro via hyperframes CLI

set -euo pipefail

TEXT_FILE="${1:?Usage: generate-tts.sh <text_file> <output_dir> [voice]}"
OUTPUT_DIR="${2:?Usage: generate-tts.sh <text_file> <output_dir> [voice]}"
VOICE="${3:-en-US-GuyNeural}"

mkdir -p "$OUTPUT_DIR"

# Try edge-tts first
if command -v edge-tts &> /dev/null; then
  echo "Using edge-tts..."
  edge-tts \
    --voice "$VOICE" \
    --rate=-5% \
    --file "$TEXT_FILE" \
    --write-media "$OUTPUT_DIR/narration.mp3" \
    --write-subtitles "$OUTPUT_DIR/narration.vtt"
  echo "Generated (edge-tts): $OUTPUT_DIR/narration.mp3"
  echo "Generated (edge-tts): $OUTPUT_DIR/narration.vtt"
  exit 0
fi

# Fallback to Kokoro via hyperframes CLI
echo "edge-tts not found. Falling back to Kokoro (local, no API key)..."
if command -v npx &> /dev/null && npx hyperframes tts --help &> /dev/null; then
  npx hyperframes tts \
    --text "$(cat "$TEXT_FILE")" \
    --output "$OUTPUT_DIR/narration.mp3"
  echo "Generated (Kokoro): $OUTPUT_DIR/narration.mp3"
  echo "Note: Kokoro does not generate VTT. Subtitles must be created manually or use --write-subtitles if supported."
  exit 0
fi

echo "ERROR: No TTS engine available. Install edge-tts: pip install edge-tts"
exit 1
