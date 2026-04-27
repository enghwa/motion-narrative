#!/bin/bash
# parse-vtt.sh — Parse VTT subtitles into JSON array of {index, text, start, end}
# Usage: ./parse-vtt.sh <vtt_file>
# Outputs JSON to stdout

set -euo pipefail

VTT_FILE="${1:?Usage: parse-vtt.sh <vtt_file>}"

python3 -c "
import re, json, sys

segments = []
with open('$VTT_FILE', 'r') as f:
    content = f.read()

pattern = r'(\d+)\n(\d{2}:\d{2}:\d{2}[.,]\d{3})\s*-->\s*(\d{2}:\d{2}:\d{2}[.,]\d{3})\n(.+?)(?=\n\n|\n\d+\n|\Z)'
matches = re.findall(pattern, content, re.DOTALL)

def ts_to_seconds(ts):
    ts = ts.replace(',', '.')
    parts = ts.split(':')
    return float(parts[0]) * 3600 + float(parts[1]) * 60 + float(parts[2])

for idx, start, end, text in matches:
    segments.append({
        'index': int(idx),
        'start': round(ts_to_seconds(start), 3),
        'end': round(ts_to_seconds(end), 3),
        'text': text.strip().replace('\n', ' ')
    })

json.dump(segments, sys.stdout, indent=2)
"
