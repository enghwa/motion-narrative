---
name: motion-narrative
description: Create cinematic narrated motion-graphics videos from research sources. HyperFrames-native compositions with catalog blocks, transitions, sub-compositions, preview-driven iteration, and frame review. Evolved from research-video v1.
---

# Motion Narrative

Create cinematic, research-driven explainer videos using HyperFrames' full ecosystem — catalog blocks, shader transitions, sub-compositions, preview iteration, and frame review. Zero API keys required.

## Philosophy (What's Different from research-video v1)

**v1** built everything by hand in a single `index.html` and used `tl.set(visibility)` to toggle scenes. **v2** leverages the HyperFrames ecosystem:
- **Scaffold from examples** instead of blank slate
- **Install reusable blocks** from the catalog instead of hand-crafting charts/overlays
- **Use transitions** between scenes instead of hard cuts
- **Sub-composition architecture** for modular, testable scenes
- **Preview before render** for visual QA
- **Frame review protocol** to catch readability/contrast/layout issues the linter misses

### ⚠️ Known Migration Gotcha
v2's `class="clip"` model sets `display: none` on inactive scenes. GSAP `from()`/`fromTo()` apply the "from" state at timeline creation time, which produces `opacity: 0` on hidden elements. **This causes blank frames if animations start long after the scene's `data-start`.** See the critical warning in Step 8 for the fix.

## Prerequisites

```bash
node --version          # >= 22
ffmpeg -version         # any recent version
ffprobe -version        # any recent version
npx hyperframes --help  # auto-installs on first run
```

Install missing tools:
```bash
pip install edge-tts    # TTS via Microsoft Azure
# OR use built-in: npx hyperframes tts   # Kokoro, local, no API key
```

## Skill Directory

```
skills/motion-narrative/
├── SKILL.md                        ← This file
├── scripts/
│   ├── generate-tts.sh             # edge-tts wrapper (fallback to Kokoro)
│   ├── parse-vtt.sh                # VTT → JSON timestamps
│   ├── resize-images.sh            # Resize oversized images to ≤2x canvas
│   └── capture-preview.sh          # Capture preview frames for review
├── styles/
│   ├── cyberpunk-v2.md             # Updated with transitions + clip model
│   ├── taalas-v2.md                # Updated with sub-composition patterns
│   └── visual-metaphor-v2.md       # Updated with marker highlight effects
└── assets/music/
    ├── corporate.mp3
    ├── cinematic.mp3
    ├── ambient.mp3
    ├── technology.mp3
    └── upbeat.mp3
```

## Quick Decision Tree

```
Topic type? ──► Corporate/technical ──► --example swiss-grid
              │
              ├── Data/stats heavy ──► --example nyt-graph
              │
              ├── Educational/how-to ──► --example decision-tree
              │
              ├── Narrative/documentary ──► --example warm-grain
              │
              ├── Product/demo ──► --example play-mode
              │
              ├── Abstract/concept ──► --example kinetic-type
              │
              └── Social/mobile (9:16) ──► --example vignelli
```

## Music Library

Pre-attenuated tracks by Kevin MacLeod (~20–30% volume). **Use `data-volume="1.0"`** as the single control point. Do not add additional attenuation.

| File | Mean Volume | Mood | Best For |
|------|-------------|------|----------|
| `corporate.mp3` | -31.0 dB | Professional, optimistic | Pitch decks, business explainers |
| `cinematic.mp3` | -33.5 dB | Dramatic, building | Technical deep-dives, reveals |
| `ambient.mp3` | -39.6 dB | Calm, atmospheric | Tutorials, walkthroughs |
| `technology.mp3` | -33.3 dB | Modern, electronic | Tech topics, code explainers |
| `upbeat.mp3` | -38.6 dB | Energetic, positive | Demos, product launches |

## Voice Options

| Voice ID | Description | Source |
|----------|-------------|--------|
| `en-US-GuyNeural` | Deep male, professional | edge-tts (DEFAULT) |
| `en-US-AriaNeural` | Warm female, conversational | edge-tts |
| `en-GB-RyanNeural` | British male, authoritative | edge-tts |
| `af_heart` | Warm, emotional | Kokoro (local) |
| `af_nova` | Bright, clear | Kokoro (local) |
| `am_adam` | Casual male | Kokoro (local) |

Override via prompt: "use a British female voice" → `en-GB-SoniaNeural`

## Design Configuration

Three dials, same as v1 but with expanded ranges:

### Active Baseline
- **DESIGN_VARIANCE**: 6 (1=Symmetry, 10=Artsy Chaos)
- **MOTION_INTENSITY**: 7 (1=Minimal, 10=Cinematic Physics)
- **VISUAL_DENSITY**: 4 (1=Gallery Airy, 10=Data-Dense)
- **TRANSITION_ENERGY**: 5 (1=None/hard-cut, 10=Shader explosions)

### TRANSITION_ENERGY Scale
- **1-2**: Hard cuts only (documentary, raw)
- **3-4**: CSS crossfade, blur fade
- **5-6**: Push slide, zoom-through
- **7-8**: Whip pan, flash-through-white
- **9-10**: Glitch, ridged-burn, cross-warp-morph shaders

## Visual Themes

Three updated themes in `styles/` — each now includes:
- Catalog block recommendations for that aesthetic
- Transition style matching the theme
- Sub-composition templates
- Frame review checklist (contrast ratios, safe zones)

| Theme | File | Aesthetic | Catalog Blocks That Fit |
|-------|------|-----------|------------------------|
| **Cyberpunk** | `styles/cyberpunk-v2.md` | Neon, HUD, terminal | `glitch`, `data-chart`, `lower-third` |
| **Taalas** | `styles/taalas-v2.md` | Copper, glassmorphism | `flash-through-white`, `captions` |
| **Visual Metaphor** | `styles/visual-metaphor-v2.md` | Abstract icons, minimal | `marker-highlight`, `kinetic-type` |

## Catalog Blocks for Research Videos

Install any of these with `npx hyperframes add <name>`:

### Data & Charts
| Block | Best For |
|-------|----------|
| `data-chart` | Bar/line charts with staggered reveal |
| `nyt-graph` | NYT-style editorial data visualization |

### Transitions
| Block | Energy | Best For |
|-------|--------|----------|
| `flash-through-white` | Medium | Dramatic reveal |
| `whip-pan` | High | Fast energetic cuts |
| `cross-warp-morph` | Calm | Smooth organic flow |
| `glitch` | Extreme | Cyberpunk/tech |

### Overlays
| Block | Best For |
|-------|----------|
| `lower-third` | Speaker attribution |
| `instagram-follow` | End card social CTA |
| `youtube-subscribe` | End card channel CTA |

### Subtitles
| Block | Best For |
|-------|----------|
| `captions` | Better-than-hand-rolled subtitle styling |

## Audio Architecture

HyperFrames manages audio via `data-*` attributes. The framework owns playback — never call `.play()` or set `.currentTime` in scripts.

### ⚠️ CRITICAL: Single Point of Volume Control

**Never apply volume reduction in multiple places.** If you attenuate in ffmpeg AND in HTML `data-volume`, the BGM becomes inaudible.

| Approach | When to Use | Volume Level |
|----------|------------|--------------|
| **Simple (default)** | Most videos using skill assets | `data-volume="1.0"` in HTML (files are pre-attenuated) |
| **Ducking** | Narration-heavy videos | `ffmpeg` ducking script, then `data-volume="1.0"` |
| **Custom source** | Full-volume external music | Set `data-volume="0.12"` in HTML only |

**Rule: Pick ONE control point. Never combine `ffmpeg volume` + `data-volume`.**

### Track Layout

```html
<!-- Narration track -->
<audio id="narration" class="clip"
       data-start="0" data-duration="180" data-track-index="0"
       data-volume="1.0"
       src="assets/narration.mp3"></audio>

<!-- Background music — skill assets are pre-attenuated, use data-volume="1.0" -->
<audio id="bgm" class="clip"
       data-start="0" data-duration="188" data-track-index="1"
       data-volume="1.0"
       src="assets/bgm.mp3"></audio>
```

### Audio Rules
- Video elements must be `muted` — audio goes in separate `<audio>` tags
- Use `data-volume` as the primary mixing control (narration 1.0, bgm 1.0 for skill assets, sfx 0.2–0.4)
- Music: loop if needed via `ffmpeg -stream_loop` before import (NO volume filter)
- Fade out bgm at end: `ffmpeg -i bgm.mp3 -af "afade=t=out:st=175:d=5" -y bgm_faded.mp3` (afade only, no volume)
- After rendering, verify BGM audibility: `ffmpeg -i output.mp4 -af "volumedetect" -f null -` — mean_volume for entire video should be louder than narration-only

## Protocol

### Step 1: Parse the Request + Select Scaffold

Extract from user's prompt:
- **Topic**, **Source** (web/git/knowledge), **Duration**, **Audience**, **Mood**, **Voice**
- **Format**: 16:9 (default), 9:16 (social), 1:1 (square)

Map to example scaffold:
```
Corporate/technical deep-dive  →  npx hyperframes init . --example swiss-grid
Data/stats heavy story         →  npx hyperframes init . --example nyt-graph
Educational/how-to            →  npx hyperframes init . --example decision-tree
Narrative/documentary         →  npx hyperframes init . --example warm-grain
Product/demo                  →  npx hyperframes init . --example play-mode
Abstract/concept              →  npx hyperframes init . --example kinetic-type
Social/mobile 9:16            →  npx hyperframes init . --example vignelli
Generic / unsure              →  npx hyperframes init . --example blank
```

Set design dials based on mood and topic.

### Step 2: Research

Same as v1. Save structured findings as bullet points for 5-8 scenes.

### Step 3: Write Narration Script

Same rules as v1:
- ~150 words/minute
- One key idea per scene, 8-15 seconds each
- No AI slop, no filler words
- Hook + CTA structure

Save to `<project_dir>/narration.txt`.

### Step 4: Generate TTS + Timestamps

**Option A — edge-tts (requires internet):**
```bash
SKILL_DIR="<path to motion-narrative>"
bash "$SKILL_DIR/scripts/generate-tts.sh" narration.txt assets [voice]
```

**Option B — Kokoro (local, no API key):**
```bash
npx hyperframes tts --text narration.txt --output assets/narration.mp3
```

**Parse timestamps:**
```bash
bash "$SKILL_DIR/scripts/parse-vtt.sh" assets/narration.vtt > assets/timestamps.json
```

Read `timestamps.json` for exact timing data.

### Step 5: Prepare Music + Audio Plan

```bash
# Choose track
SKILL_DIR="<path to motion-narrative>"
cp "$SKILL_DIR/assets/music/<mood>.mp3" assets/bgm_raw.mp3

# Loop + fade (NO volume filter — use data-volume in HTML as single control)
DURATION=$(ffprobe -v error -show_entries format=duration -of csv=p=0 assets/narration.mp3)
PADDED=$(echo "$DURATION + 8" | bc)  # 2s hold + 3s fade + 3s buffer
ffmpeg -stream_loop -1 -i assets/bgm_raw.mp3 -t $PADDED \
  -af "afade=t=out:st=$(echo "$PADDED - 5" | bc):d=5" \
  -y assets/bgm.mp3
```

Document the audio plan:
- Narration track: volume 1.0, starts at 0s
- BGM track: volume 1.0 (skill assets are pre-attenuated), starts at 0s, fades out at end
- Any SFX: note timestamp + volume

### Ducking (Optional, Advanced)

Use ducking only if BGM competes with narration. Apply it once, before rendering, then use `data-volume="1.0"` in HTML.

```bash
# Duck BGM with ffmpeg: narration=6%, gaps=30%, crossfade=0.3s
# This creates a pre-mixed BGM file — use data-volume="1.0" in HTML
python3 << 'PYEOF'
import json, numpy as np
import soundfile as sf

with open('assets/timestamps.json') as f:
    segments = json.load(f)

bgm, sr = sf.read('assets/bgm_raw.mp3')
if bgm.ndim == 2:
    bgm = bgm.mean(axis=1)

needed = int(132 * sr)  # narration + padding
if len(bgm) < needed:
    bgm = np.tile(bgm, int(np.ceil(needed / len(bgm))))[:needed]

envelope = np.ones(len(bgm)) * 0.30
for seg in segments:
    s = int(seg['start'] * sr)
    e = int(seg['end'] * sr)
    envelope[s:e] = 0.06

# Smooth with moving average (0.3s window)
ws = int(0.3 * sr)
if ws > 1:
    padded = np.pad(envelope, (ws//2, ws//2), mode='edge')
    envelope = np.convolve(padded, np.ones(ws)/ws, mode='valid')[:len(bgm)]

ducked = bgm * envelope
# End fade
fs = int((len(ducked)/sr - 5) * sr)
if fs > 0:
    ducked[fs:] *= np.linspace(1, 0, len(ducked) - fs)

sf.write('assets/bgm_ducked.mp3', ducked, sr, format='MP3')
print(f"Ducked BGM: narration=6%, gaps=30%, end_fade=5s")
PYEOF
```

In HTML when using ducked BGM: `<audio data-volume="1.0" src="assets/bgm_ducked.mp3">`

**Rule:** If you duck in预处理, do NOT also use HTML `data-volume` to attenuate further. Pick ONE control point.

### Audio Verification (After Render)

Verify BGM is audible in the final output:

```bash
# Check combined audio level — should be louder than narration-only
ffmpeg -i renders/final.mp4 -af "volumedetect" -f null - 2>&1 | grep mean_volume

# Compare to narration level
ffmpeg -i assets/narration.mp3 -af "volumedetect" -f null - 2>&1 | grep mean_volume

# Rule: combined mean_volume should be within 3dB of narration-only
# If combined is >5dB quieter, BGM is too quiet or missing
```

### Step 6: Plan Composition + Select Blocks

Before writing HTML, write a scene plan and decide which blocks to install:

```
Scene 1 (0.1s - 12.0s): Hook
  VTT segments: 1-3
  Visual: Hero title, kinetic reveal
  Block needed: none (built-in example handles this)
  Transition to Scene 2: flash-through-white

Scene 2 (12.0s - 28.0s): Context / Problem
  VTT segments: 4-9
  Visual: Split layout, problem statement
  Block needed: data-chart (if showing stats)
  Transition to Scene 3: whip-pan

Scene 3 (28.0s - 50.0s): Deep dive
  VTT segments: 10-15
  Visual: Data visualization, comparison cards
  Block needed: data-chart OR nyt-graph
  Transition to Scene 4: cross-warp-morph

Scene 4 (50.0s - 70.0s): Evidence / Example
  VTT segments: 16-22
  Visual: Screenshot/image with animated markers
  Block needed: lower-third (if showing speaker attribution)

Scene 5 (70.0s - 90.0s): Resolution
  VTT segments: 23-28
  Visual: Summary, confident CTA
  Block needed: none

End card (90.0s - 96.0s): Social CTA
  Block needed: instagram-follow OR youtube-subscribe
```

Install blocks:
```bash
npx hyperframes add data-chart
npx hyperframes add flash-through-white
npx hyperframes add lower-third
```

### Step 7: Scaffold Project

```bash
cd <project_dir>
npx hyperframes init . --example <selected-example>
```

This creates:
```
project/
├── meta.json
├── index.html              ← Root composition
├── compositions/           ← Sub-compositions (scenes, blocks)
│   ├── intro.html
│   ├── captions.html
│   └── <installed-blocks>.html
└── assets/
    ├── narration.mp3
    ├── narration.vtt
    ├── bgm.mp3
    └── <images>
```

### Step 8: Write the Composition

**CRITICAL: Use HyperFrames canonical patterns:**

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <script src="https://cdn.jsdelivr.net/npm/gsap@3/dist/gsap.min.js"></script>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Geist:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
  <style>
    /* Theme styles — ALL animated elements need explicit opacity */
    .headline, .body-text, .card { opacity: 1; }
  </style>
</head>
<body>
  <div id="root" data-composition-id="main"
       data-start="0" data-width="1920" data-height="1080"
       data-duration="TOTAL_SECONDS">

    <!-- Audio tracks -->
    <audio id="narration" class="clip"
           data-start="0" data-duration="180" data-track-index="0"
           data-volume="1.0"
           src="assets/narration.mp3"></audio>
    <audio id="bgm" class="clip"
           data-start="0" data-duration="188" data-track-index="1"
           data-volume="1.0"
           src="assets/bgm.mp3"></audio>

    <!-- SCENE 1: Hero (0.1s - 12.0s) -->
    <div id="scene1" class="clip"
         data-start="0.1" data-duration="11.9" data-track-index="2">
      <h1 class="headline">Visible from scene start</h1>
    </div>

    <!-- SCENE 2: Context (12.0s - 28.0s) -->
    <div id="scene2" class="clip"
         data-start="12.0" data-duration="16.0" data-track-index="2">
      <div class="card">Also visible immediately</div>
    </div>

    <!-- Subtitle overlay (highest z-index) -->
    <div id="subtitles" class="clip"
         data-start="0" data-duration="TOTAL_SECONDS" data-track-index="99">
      <!-- One .sub div per VTT segment -->
    </div>

    <script>
      const tl = gsap.timeline({ paused: true });

      // Animate WITHIN scenes — start at scene time + 0.1s offset
      // Use fromTo() WITHOUT opacity — elements must stay visible
      tl.fromTo("#scene1 .headline",
        { y: 60 },                         // from: offset down
        { y: 0, duration: 1, ease: "back.out(1.7)" },  // to: in place
        0.2);  // starts 0.2s after page load (scene is visible by then)

      tl.fromTo("#scene2 .card",
        { x: -50 },                        // from: offset left
        { x: 0, duration: 0.6, ease: "back.out(1.7)" },
        12.1); // starts immediately when scene2 becomes active

      // Extend timeline to match total duration
      tl.set({}, {}, TOTAL_SECONDS);

      window.__timelines = window.__timelines || {};
      window.__timelines["main"] = tl;
    </script>
  </div>
</body>
</html>
```

### ⚠️ CRITICAL: `class="clip"` + GSAP Interaction Warning

**When using `class="clip"` with GSAP animations, you MUST handle the visibility lifecycle correctly.**

**The Problem:**
- `class="clip"` removes inactive scenes from layout via `display: none`
- GSAP `from()` and `fromTo()` set the "from" state at timeline creation time
- On hidden elements, GSAP records `opacity: 0` as the target
- If animations start later than the scene's `data-start`, elements stay invisible for seconds

**Visible Result:** Blank frames with only background patterns showing.

**The Fix — Three Rules:**

1. **Never animate `opacity` with `fromTo()` on clipped elements.** Use transforms only (`y`, `x`, `scale`, `rotation`). Elements stay visible throughout.

2. **Start GSAP animations at the scene's `data-start` time** (or within 0.2s). Never leave a gap of 10+ seconds.

   ```javascript
   // BAD — 12s gap between scene start and animation
   // Scene 5 starts at 66s, animation at 78s → 12s of blank
   tl.fromTo("#scene5 .card", { opacity: 0, y: 50 }, { opacity: 1, y: 0 }, 78.0);

   // GOOD — animation starts when scene becomes active
   tl.fromTo("#scene5 .card", { y: 50 }, { y: 0 }, 66.2);
   ```

3. **If you MUST use `opacity` animations**, add `tl.set({ opacity: 1 })` at the exact `data-start` time:
   ```javascript
   tl.set("#scene5 .card", { opacity: 1 }, 66.183);  // force visible
   tl.fromTo("#scene5 .card", { opacity: 0, y: 50 }, { opacity: 1, y: 0 }, 66.3);
   ```

**Three Rules That Differ from v1:**
1. **Timed elements use `class="clip"`** — framework manages show/hide lifecycle
2. **GSAP only animates transform properties** (y, x, scale, rotation) — never opacity on clipped elements
3. **Start animations at scene start time + 0.1–0.2s** — never leave a 10+ second gap

**Additional Rules:**
- Never animate `width`/`height`/`top`/`left` directly on `<video>` — wrap in `<div>`, animate the wrapper
- No `Math.random()` — use seeded PRNG if pseudo-random needed
- Subtitles: `position:absolute` on `.sub`, all overlapping at same position
- Subtitles: `white-space:normal` with `max-width:1000px` for wrapping

### Step 9: Pre-Process Images

```bash
# Resize images to ≤2x canvas (3840x2160 for 1920x1080 output)
SKILL_DIR="<path to motion-narrative>"
bash "$SKILL_DIR/scripts/resize-images.sh" assets/ 3840
```

This prevents 140MB decoded frames from oversized JPEGs.

### Step 10: Timing Verification

Same 5 checks as v1, with updated expectations:

#### Check 1: Duration Matches Audio
```bash
ACTUAL_DURATION=$(ffprobe -v error -show_entries format=duration -of csv=p=0 assets/narration.mp3)
echo "Audio: ${ACTUAL_DURATION}s"
grep 'data-duration' index.html
```

`data-duration` = audio length + 6-8s padding (hold + fade + black)

#### Check 2: Scene Boundaries Align with VTT
```bash
# Count VTT segments
VTT_COUNT=$(cat assets/timestamps.json | jq 'length')
echo "VTT segments: $VTT_COUNT"

# Count subtitle divs
SUB_COUNT=$(grep -c 'class="sub"' index.html)
echo "Subtitle divs: $SUB_COUNT"
```

Must match. If mismatch, fix before rendering.

#### Check 3: Composition Duration
```bash
npx hyperframes compositions
```

Verify each composition's resolved duration. If shorter than expected, add `tl.set({}, {}, DURATION)` at end.

#### Check 4: Content-to-Scene Mapping
Read scene text + check it aligns with VTT segments covering same time range.

#### Check 5: Proper Video Ending
- Fade starts 2-3s AFTER last subtitle ends
- BGM fades, doesn't cut
- Final 2s are pure black

### Step 11: Preview + Frame Review

**Launch preview:**
```bash
npx hyperframes preview &
PREVIEW_PID=$!
```

**Capture key frames for review:**
```bash
SKILL_DIR="<path to motion-narrative>"
bash "$SKILL_DIR/scripts/capture-preview.sh"
```

This captures screenshots at:
- 0s (hero scene)
- First transition boundary
- Mid-narration (data/stat scene)
- Final CTA scene
- End fade

**Review each frame for:**
- [ ] **Text readability**: Contrast ratio ≥ 4.5:1 against background
- [ ] **Subtitle position**: Not overlapping key content (cards, stats, CTAs)
- [ ] **Animation feel**: Entrance timing feels right (not too slow/fast)
- [ ] **Layout balance**: No scene feels empty or cramped
- [ ] **Image quality**: No pixelation, proper aspect ratio
- [ ] **Safe zones**: No critical content within 60px of edges

**Fix issues in browser** (hot reload updates preview instantly), then proceed to render.

### Step 12: Lint

```bash
npx hyperframes lint
npx hyperframes validate    # catches runtime issues lint misses
```

Fix all errors. Warnings about `visibility: hidden` are expected for subtitle system.

### Step 13: Render

```bash
npx hyperframes render --output final.mp4
```

**On failure:** Read error output, fix HTML, retry. Max 3 attempts.

### Step 14: Deliver

```bash
ls -la renders/*.mp4
# OR
ls -la final.mp4
```

Report to user:
- Duration and file size
- Scene count + block count installed
- Design dials used (DESIGN_VARIANCE, MOTION_INTENSITY, VISUAL_DENSITY, TRANSITION_ENERGY)
- Voice used
- Music track used
- Example scaffold used
- Any facts that should be verified

## Frame Review Protocol (Detailed)

### Why This Matters

The `linter` catches structural issues (missing `class="clip"`, timeline registry, etc.). It does NOT catch:
- Background images so bright text becomes unreadable
- Subtitles overlapping data cards or CTAs
- Animation timing that feels wrong
- Layouts that look fine in code but cramped visually
- `backdrop-filter` stacks causing 5-10fps drops
- Oversized images causing render slowdown

### Review Checklist Per Frame

| Check | Pass Criteria | Fix If Failed |
|-------|--------------|---------------|
| Contrast | Text readable against background | Add overlay gradient or darken background |
| Subtitle overlap | Subtitles don't cover important UI | Move subtitles up, or move scene content down |
| Animation timing | Entrance feels natural, not jarring | Adjust GSAP `duration` or `ease` |
| Layout balance | Neither empty nor cramped | Add/remove whitespace, resize elements |
| Image quality | Sharp, not pixelated | Use higher-res source or resize properly |
| Safe zones | Critical content >60px from edges | Reposition elements inward |
| transition feel | Scene change is intentional | Add transition block if hard cut feels wrong |

### When to Skip

- Draft/quick renders (< 30s, simple layouts)
- When preview server is unavailable
- Iteration N+1 where only minor timing changed

### When to ALWAYS Review

- First render of a new theme
- Videos with complex multi-element scenes
- When using external/unvalidated images
- Data/stat-heavy scenes (readability is critical)
- Portrait/mobile format (different safe zones)

## Quick Reference: Full Command Sequence

```bash
SKILL_DIR="<path to motion-narrative>"
PROJECT="my-video"
mkdir -p "$PROJECT" && cd "$PROJECT"

# 1. Scaffold from example
npx hyperframes init . --example swiss-grid

# 2. Write narration.txt (you write this)

# 3. TTS
bash "$SKILL_DIR/scripts/generate-tts.sh" narration.txt assets
bash "$SKILL_DIR/scripts/parse-vtt.sh" assets/narration.vtt > assets/timestamps.json

# 4. Music
cp "$SKILL_DIR/assets/music/cinematic.mp3" assets/bgm_raw.mp3
DURATION=$(ffprobe -v error -show_entries format=duration -of csv=p=0 assets/narration.mp3)
PADDED=$(python3 -c "print($DURATION + 8)")
ffmpeg -stream_loop -1 -i assets/bgm_raw.mp3 -t $PADDED \
  -af "afade=t=out:st=$(python3 -c "print($PADDED - 5)"):d=5" \
  -y assets/bgm.mp3

# 5. Install blocks
npx hyperframes add data-chart
npx hyperframes add flash-through-white

# 6. Resize images
bash "$SKILL_DIR/scripts/resize-images.sh" assets/ 3840

# 7. Write index.html + compositions/ (you write this)

# 8. Timing verification
ACTUAL=$(ffprobe -v error -show_entries format=duration -of csv=p=0 assets/narration.mp3)
echo "Audio: ${ACTUAL}s"
grep 'data-duration' index.html
npx hyperframes compositions

# 9. Preview + frame review
npx hyperframes preview &
bash "$SKILL_DIR/scripts/capture-preview.sh"
# Review screenshots, fix issues

# 10. Lint + validate
npx hyperframes lint
npx hyperframes validate

# 11. Render
npx hyperframes render --output final.mp4
```

## Attribution

Background music by Kevin MacLeod (incompetech.com), licensed under Creative Commons: By Attribution 3.0. When publishing videos publicly, include: "Music: [track name] by Kevin MacLeod (incompetech.com) — CC BY 3.0"

Some patterns inspired by HyperFrames (github.com/heygen-com/hyperframes, Apache 2.0).
