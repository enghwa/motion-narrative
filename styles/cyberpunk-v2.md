# Cyberpunk v2 Style Guide

Futuristic dystopian aesthetic with neon accents, HUD elements, and terminal vibes. Updated for HyperFrames `class="clip"` model, catalog blocks, and transitions.

## Color Palette

```css
:root {
  --neon-cyan: #00f0ff;
  --neon-pink: #ff006e;
  --neon-purple: #8338ec;
  --neon-yellow: #ffbe0b;
  --dark-bg: #050508;
  --dark-bg-alt: #0a0e1a;
  --grid-line: rgba(0, 240, 255, 0.08);
}
```

## Typography

**Primary:** Geist (body, display)
**Mono:** JetBrains Mono (data, labels, subtitles)

```css
.display-xl { font-size: 110px; font-weight: 800; letter-spacing: -0.03em; line-height: 1.0; }
.display-lg { font-size: 72px; font-weight: 700; letter-spacing: -0.02em; line-height: 1.1; }
.display-md { font-size: 56px; font-weight: 600; line-height: 1.15; }
.body-xl { font-size: 36px; font-weight: 400; line-height: 1.5; }
.body-lg { font-size: 28px; font-weight: 400; line-height: 1.5; }
.mono-xl { font-family: 'JetBrains Mono', monospace; font-size: 36px; font-weight: 600;
           letter-spacing: 0.1em; text-transform: uppercase; color: var(--neon-cyan); }
```

## Core Components

### 1. Grid Background

```css
.cyber-grid {
  position: absolute; top: 0; left: 0; width: 100%; height: 100%;
  background-image:
    linear-gradient(var(--grid-line) 1px, transparent 1px),
    linear-gradient(90deg, var(--grid-line) 1px, transparent 1px);
  background-size: 60px 60px;
  pointer-events: none; z-index: 1;
}
```

### 2. Scan Lines

```css
.scanlines {
  position: absolute; top: 0; left: 0; width: 100%; height: 100%;
  background: linear-gradient(to bottom, transparent 50%, rgba(0,0,0,0.1) 50%);
  background-size: 100% 4px;
  pointer-events: none; z-index: 998; opacity: 0.2;
}
```

### 3. HUD Corner Brackets

```css
.hud-corner {
  position: absolute; width: 80px; height: 80px;
  border: 2px solid var(--neon-cyan); opacity: 0.5; z-index: 20;
}
.hud-corner.tl { top: 40px; left: 40px; border-right: none; border-bottom: none; }
.hud-corner.tr { top: 40px; right: 40px; border-left: none; border-bottom: none; }
.hud-corner.bl { bottom: 140px; left: 40px; border-right: none; border-top: none; }
.hud-corner.br { bottom: 140px; right: 40px; border-left: none; border-top: none; }
```

### 4. Cyber Cards

```css
.cyber-card {
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 20px; padding: 32px 40px;
  backdrop-filter: blur(10px);
}
.warning-card {
  background: linear-gradient(135deg, rgba(255,0,110,0.08), rgba(255,0,110,0.02));
  border: 1px solid rgba(255,0,110,0.2); border-radius: 16px; padding: 28px 36px;
}
.info-card {
  background: linear-gradient(135deg, rgba(0,240,255,0.06), rgba(0,240,255,0.02));
  border: 1px solid rgba(0,240,255,0.15); border-radius: 16px; padding: 28px 36px;
}
```

### 5. Data Blocks

```css
.data-block {
  font-family: 'JetBrains Mono', monospace;
  background: rgba(0, 0, 0, 0.5);
  border-left: 3px solid var(--neon-cyan);
  padding: 20px 30px; margin: 20px 0;
}
```

### 6. Pulse Dots

```css
.pulse-dot {
  width: 14px; height: 14px;
  background: var(--neon-cyan);
  border-radius: 50%; box-shadow: 0 0 12px var(--neon-cyan);
}
```

### 7. Company/Tech Pills

```css
.company-pill {
  display: inline-flex; font-family: 'JetBrains Mono', monospace;
  background: rgba(0, 240, 255, 0.1); border: 1px solid rgba(0, 240, 255, 0.25);
  color: var(--neon-cyan); font-size: 18px; font-weight: 600;
  padding: 10px 20px; border-radius: 100px; margin: 6px;
}
.company-pill.pink {
  background: rgba(255, 0, 110, 0.1); border: 1px solid rgba(255, 0, 110, 0.25);
  color: var(--neon-pink);
}
```

## Scene Templates (class="clip" Model)

### Scene Type A: Terminal Boot

```html
<div id="scene1" class="clip" data-start="0.1" data-duration="10.0" data-track-index="2">
  <div class="cyber-grid"></div>
  <div class="hud-corner tl"></div><div class="hud-corner tr"></div>
  <div class="hud-corner bl"></div><div class="hud-corner br"></div>
  <div style="position: relative; z-index: 10; text-align: center;">
    <p class="mono-xl" style="opacity: 0.7;">&gt; SYSTEM_BREACH_DETECTED</p>
    <h1 class="display-xl"><span style="color: var(--neon-cyan);">MAIN_HEADLINE</span></h1>
    <div class="pulse-container">
      <div class="pulse-dot"></div>
      <div class="pulse-dot" style="background: var(--neon-pink); box-shadow: 0 0 12px var(--neon-pink);"></div>
      <div class="pulse-dot"></div>
    </div>
  </div>
</div>
```

### Scene Type B: Diagnostic Split

```html
<div id="scene2" class="clip" data-start="10.1" data-duration="15.0" data-track-index="2"
     style="background: var(--dark-bg-alt);">
  <div style="display: flex; gap: 60px; align-items: center; max-width: 1600px; padding: 0 80px;">
    <div style="flex: 1;">
      <p class="mono-lg" style="color: var(--neon-cyan); margin-bottom: 20px;">[ANALYSIS_001]</p>
      <h2 class="display-lg">Headline <span style="color: var(--neon-cyan);">Accent</span></h2>
      <div class="data-block"><p class="body-lg">Status data...</p></div>
    </div>
    <div style="flex: 0 0 520px;">
      <div class="warning-card"><p class="body-lg">Warning content...</p></div>
    </div>
  </div>
</div>
```

### Scene Type C: Statistics Comparison

```html
<div id="scene3" class="clip" data-start="25.1" data-duration="12.0" data-track-index="2"
     style="background: linear-gradient(180deg, #0a0e1a 0%, #151025 100%);">
  <div class="cyber-grid"></div>
  <div style="position: relative; z-index: 10; text-align: center; max-width: 1200px;">
    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 60px;">
      <div class="cyber-card" style="text-align: center;">
        <p class="mono-xl" style="opacity: 0.6; margin-bottom: 16px;">BEFORE</p>
        <p style="font-family: 'JetBrains Mono'; font-size: 120px; font-weight: 700;
                  color: var(--neon-cyan); line-height: 1.0;">$100</p>
      </div>
      <div class="cyber-card" style="text-align: center; border: 1px solid rgba(255,0,110,0.3);">
        <p class="mono-xl" style="opacity: 0.6; margin-bottom: 16px;">AFTER</p>
        <p style="font-family: 'JetBrains Mono'; font-size: 120px; font-weight: 700;
                  color: var(--neon-pink); line-height: 1.0;">$5,600</p>
      </div>
    </div>
  </div>
</div>
```

## Recommended Catalog Blocks

| Block | Install | Use Case |
|-------|---------|----------|
| `glitch` | `npx hyperframes add glitch` | Transition for data breach/hack reveals |
| `data-chart` | `npx hyperframes add data-chart` | Cost comparison charts |
| `lower-third` | `npx hyperframes add lower-third` | Speaker attribution (e.g., "Luo Fuli / Xiaomi") |
| `flash-through-white` | `npx hyperframes add flash-through-white` | Dramatic scene transitions |

## Transitions for This Theme

| Energy | CSS/Shader | When to Use |
|--------|-----------|-------------|
| 5-6 | `flash-through-white` | Scene reveals, dramatic cuts |
| 7-8 | `glitch` | Hacker/tech reveals |
| 8-9 | `whip-pan` | Fast cuts between data points |

## Animation Patterns

```javascript
// HUD entrance
tl.from(".hud-corner", { opacity: 0, scale: 0.8, duration: 0.6, stagger: 0.1 });

// Terminal boot
tl.from(".mono-xl", { opacity: 0, duration: 0.5 }, 0.2);
tl.from("h1", { opacity: 0, y: 60, duration: 1, ease: "back.out(1.7)" }, 0.5);
tl.from(".pulse-dot", { opacity: 0, scale: 0, duration: 0.4, stagger: 0.12, ease: "back.out(2)" }, 1.0);

// Card reveal
tl.from(".cyber-card", { opacity: 0, y: 40, duration: 0.7, ease: "back.out(1.7)", stagger: 0.15 });

// Elastic stat reveal
tl.from(".stat-number", { opacity: 0, scale: 0.5, duration: 1, ease: "elastic.out(1, 0.5)" });
```

## Frame Review Checklist (Cyberpunk)

- [ ] Neon text has sufficient glow/bloom for readability
- [ ] Dark backgrounds don't crush HUD corner details
- [ ] Grid lines are visible but not distracting (opacity 0.05-0.1)
- [ ] Scan lines don't obscure thin text
- [ ] Pulse dots don't cause epilepsy (subtle, not strobing)

## Usage

```bash
# 1. Include cyber-grid and scanlines in root
# 2. Add HUD corners for dramatic scenes
# 3. Use neon accents: cyan (primary), pink (warnings), purple (secondary)
# 4. Include JetBrains Mono for code/data elements
# 5. Install glitch + flash-through-white transitions
# 6. Apply elastic animations for impact moments
# 7. Use class="clip" + data-start/data-duration (not manual visibility)
```
