# Visual Metaphor v2 Style Guide

Abstract concept visualization using SVG icons, geometric shapes, and symbolic representations. Updated for HyperFrames `class="clip"` model, marker highlights, and sub-compositions.

## Philosophy

**Show, don't tell.** Instead of displaying the same text as the narration:
- SVG iconography for abstract concepts
- Geometric animations for processes
- Symbolic visual metaphors (brain = AI, rings = precision)
- Key words only — 1-3 impactful terms per scene

## Color Palette

```css
:root {
  --bg-deep: #0a0a0f;
  --bg-elevated: #111118;
  --text-primary: #f9fafb;
  --text-muted: rgba(249, 250, 251, 0.6);
  --accent-indigo: #6366f1;
  --accent-purple: #8b5cf6;
  --accent-emerald: #10b981;
  --accent-amber: #f59e0b;
  --grid-line: rgba(255, 255, 255, 0.06);
}
```

## Typography

**Primary:** Geist
**Mono:** Geist Mono (subtitles, labels)

```css
.display-mega { font-size: 160px; font-weight: 700; letter-spacing: -0.03em; line-height: 0.95; }
.display-xl { font-size: 120px; font-weight: 700; letter-spacing: -0.03em; line-height: 1.0; }
.display-lg { font-size: 80px; font-weight: 600; letter-spacing: -0.02em; }
.keyword { font-size: 96px; font-weight: 700; }
.label { font-size: 14px; font-weight: 500; letter-spacing: 0.15em; text-transform: uppercase; color: var(--text-muted); }
.body-sm { font-size: 24px; font-weight: 400; color: var(--text-muted); max-width: 800px; }
```

## Core Components

### 1. Trust Badge

```html
<div class="trust-badge" style="width: 180px; height: 180px; border: 3px solid var(--accent-emerald);
     border-radius: 50%; display: flex; align-items: center; justify-content: center;">
  <svg viewBox="0 0 24 24" fill="none" stroke="var(--accent-emerald)" stroke-width="3" style="width: 72px;">
    <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
  </svg>
</div>
```

### 2. AI Brain Network

```javascript
const nodePositions = [
  {x: 50, y: 20}, {x: 30, y: 35}, {x: 70, y: 35},
  {x: 25, y: 55}, {x: 50, y: 50}, {x: 75, y: 55},
  {x: 35, y: 75}, {x: 65, y: 75}, {x: 50, y: 85}
];
nodePositions.forEach((pos, i) => {
  const node = document.createElement('div');
  node.className = 'brain-node';
  node.style.cssText = `position: absolute; width: 12px; height: 12px;
    background: var(--accent-indigo); border-radius: 50%;
    left: ${pos.x}%; top: ${pos.y}%; opacity: 0;`;
  container.appendChild(node);
});
```

### 3. Precision Rings

```css
.precision-rings { position: absolute; width: 400px; height: 400px; }
.mastery-ring {
  position: absolute; border: 2px solid var(--accent-indigo);
  border-radius: 50%;
}
.ring-1 { width: 100%; height: 100%; opacity: 0.2; }
.ring-2 { width: 80%; height: 80%; top: 10%; left: 10%; opacity: 0.4; }
.ring-3 { width: 60%; height: 60%; top: 20%; left: 20%; opacity: 0.6; }
.ring-4 { width: 40%; height: 40%; top: 30%; left: 30%; opacity: 0.8; }
.ring-5 { width: 20%; height: 20%; top: 40%; left: 40%; opacity: 1; background: rgba(99,102,241,0.1); }
```

### 4. Visual Cluster

```css
.visual-cluster { display: flex; gap: 24px; }
.cluster-item {
  width: 100px; height: 100px; border-radius: 20px;
  background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1);
  display: flex; align-items: center; justify-content: center;
}
.cluster-item svg { width: 40px; height: 40px; stroke: rgba(255,255,255,0.7); stroke-width: 2; fill: none; }
```

### 5. Marker Highlight (Catalog Block)

Instead of hand-coding, install the marker block:
```bash
npx hyperframes add marker-highlight
```

Then use:
```html
<div data-composition-id="marker-highlight"
     data-composition-src="compositions/marker-highlight.html"
     data-start="5.0" data-duration="2.0"
     data-track-index="3"></div>
```

Modes: `highlight`, `circle`, `burst`, `scribble`, `sketchout`

## Scene Templates (class="clip" Model)

### Scene Type A: Concept Word + Icon

```html
<div id="scene1" class="clip" data-start="0.1" data-duration="10.0" data-track-index="2"
     style="background: var(--bg-deep);">
  <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;
       background-image: radial-gradient(circle at 1px 1px, rgba(255,255,255,0.04) 1px, transparent 0);
       background-size: 40px 40px;"></div>
  <div style="position: relative; z-index: 10; text-align: center;">
    <div class="display-mega">
      <span style="color: var(--accent-indigo);">Trust</span>
    </div>
    <div class="trust-badge" style="position: absolute; top: 15%; right: 20%;"></div>
  </div>
</div>
```

### Scene Type B: AI Concept + Brain Network

```html
<div id="scene2" class="clip" data-start="10.1" data-duration="15.0" data-track-index="2">
  <div id="brain-viz" style="position: relative; width: 400px; height: 400px; margin: 0 auto;"></div>
  <div style="text-align: center; margin-top: 40px;">
    <span class="display-lg" style="color: var(--text-primary);">First </span>
    <span class="display-lg" style="color: var(--accent-purple);">AI </span>
    <span class="display-lg" style="color: var(--text-primary);">Experience</span>
  </div>
</div>
```

### Scene Type C: Quality Grid + Keywords

```html
<div id="scene3" class="clip" data-start="25.1" data-duration="12.0" data-track-index="2">
  <div style="display: grid; grid-template-columns: repeat(5, 1fr); gap: 15px;
       position: absolute; top: 15%; right: 10%;">
    <!-- 15 grid cells -->
    <div class="grid-cell" style="width: 60px; height: 60px; border: 1px solid rgba(99,102,241,0.3);
         border-radius: 8px; background: rgba(99,102,241,0.05);"></div>
  </div>
  <div style="text-align: left; max-width: 700px; padding-left: 80px;">
    <div class="display-lg">
      <span style="color: var(--text-primary);">Fast</span>
      <span style="color: var(--accent-indigo);"> · </span>
      <span style="color: var(--text-primary);">Structured</span>
      <span style="color: var(--accent-indigo);"> · </span>
      <span style="color: var(--text-primary);">Dependable</span>
    </div>
  </div>
</div>
```

### Scene Type D: Precision Focus

```html
<div id="scene4" class="clip" data-start="37.1" data-duration="12.0" data-track-index="2">
  <div class="precision-rings" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">
    <div class="mastery-ring ring-1"></div>
    <div class="mastery-ring ring-2"></div>
    <div class="mastery-ring ring-3"></div>
    <div class="mastery-ring ring-4"></div>
    <div class="mastery-ring ring-5"></div>
  </div>
  <div class="display-xl" style="position: relative; z-index: 10; text-align: center;">
    <span style="color: var(--accent-indigo);">Precision</span>
  </div>
</div>
```

## Recommended Catalog Blocks

| Block | Install | Use For |
|-------|---------|---------|
| `marker-highlight` | `npx hyperframes add marker-highlight` | Emphasizing keywords in screenshots |
| `kinetic-type` | `npx hyperframes add kinetic-type` | Dramatic title animations |
| `cross-warp-morph` | `npx hyperframes add cross-warp-morph` | Smooth organic transitions |
| `captions` | `npx hyperframes add captions` | Styled subtitles |

## Transitions for This Theme

| Energy | CSS/Shader | When to Use |
|--------|-----------|-------------|
| 3-4 | Blur crossfade | Calm, thoughtful |
| 5-6 | `cross-warp-morph` | Organic concept flow |
| 6-7 | Push slide | Dynamic but not jarring |

## Animation Patterns

```javascript
// Concept reveal
tl.to('.trust-badge', { scale: 1, opacity: 1, duration: 0.6, ease: 'back.out(1.7)', stagger: 0.2 });
tl.to('.keyword', { opacity: 1, y: 0, scale: 1, duration: 0.7, ease: 'back.out(1.4)', stagger: 0.15 });

// Network formation
tl.to('.brain-node', { opacity: 1, scale: 1, duration: 0.4, stagger: 0.05, ease: 'back.out(2)' });
tl.from('.brain-line', { scaleX: 0, duration: 0.5, stagger: 0.1, ease: 'power2.out' }, '-=0.3');

// Ring expansion
tl.to('.mastery-ring', { scale: 1, opacity: 1, duration: 0.6, stagger: 0.1, ease: 'power2.out' });

// Grid stagger
tl.to('.grid-cell', { opacity: 1, scale: 1, duration: 0.3, stagger: 0.03, ease: 'back.out(1.7)' });
```

## SVG Icon Library

```svg
<!-- Trust/Checkmark -->
<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3">
  <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
</svg>

<!-- Brain/Network -->
<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
  <circle cx="12" cy="12" r="3"/>
  <circle cx="5" cy="8" r="2"/><circle cx="19" cy="8" r="2"/>
  <circle cx="5" cy="16" r="2"/><circle cx="19" cy="16" r="2"/>
  <path d="M7 9l3 2M14 10l3-2M7 15l3-2M14 14l3 2"/>
</svg>

<!-- Precision/Target -->
<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
  <circle cx="12" cy="12" r="10"/><circle cx="12" cy="12" r="6"/><circle cx="12" cy="12" r="2"/>
  <path d="M12 2v4M12 18v4M2 12h4M18 12h4"/>
</svg>
```

## Frame Review Checklist (Visual Metaphor)

- [ ] Maximum 3 words on screen at once
- [ ] Visuals don't duplicate subtitle text
- [ ] SVG icons are crisp (not pixelated)
- [ ] Grid background is subtle (opacity 0.04-0.06)
- [ ] Animation stagger is visible but not chaotic
- [ ] Single keywords dominate the frame (keyword sizing)

## Usage

```bash
# 1. Reduce on-screen text to 1-3 key words
# 2. Create/import SVG icons for concepts
# 3. Position visuals asymmetrically around text
# 4. Use spring physics animations
# 5. Keep background minimal (dot grid only)
# 6. Install marker-highlight + kinetic-type blocks
# 7. Use class="clip" + data-start/data-duration
```
