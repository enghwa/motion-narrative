# Taalas v2 Style Guide

Premium minimalist aesthetic with copper accents, glassmorphism, and architectural feel. Updated for HyperFrames `class="clip"` model, sub-compositions, and catalog blocks.

## Color Palette

```css
:root {
  --taalas-navy: #0A0A1A;
  --taalas-navy-light: #121224;
  --taalas-cream: #F5F0E8;
  --taalas-cream-muted: rgba(245, 240, 232, 0.7);
  --taalas-copper: #C9A87C;
  --taalas-copper-light: #D4B896;
  --glass-bg: rgba(245, 240, 232, 0.08);
  --glass-border: rgba(201, 168, 124, 0.3);
}
```

## Typography

**Primary:** Space Grotesk (Google Fonts)
```css
font-family: 'Space Grotesk', sans-serif;
```

```css
.display-hero { font-size: 96px; font-weight: 700; text-transform: uppercase; line-height: 1.0; }
.display-xl { font-size: 72px; font-weight: 600; line-height: 1.1; }
.display-lg { font-size: 56px; font-weight: 600; line-height: 1.15; }
.display-md { font-size: 42px; font-weight: 600; line-height: 1.2; }
.body-xl { font-size: 32px; font-weight: 400; line-height: 1.6; }
.body-lg { font-size: 26px; font-weight: 400; line-height: 1.6; }
.mono-text { font-size: 18px; font-weight: 500; letter-spacing: 0.15em; text-transform: uppercase; color: var(--taalas-copper); }
```

## Core Components

### 1. Glass Cards (Glassmorphism)

```css
.glass-card {
  background: rgba(245, 240, 232, 0.08);
  backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(201, 168, 124, 0.3);
  border-radius: 24px; padding: 48px;
  box-shadow: 0 8px 32px rgba(0,0,0,0.3), inset 0 1px 0 rgba(255,255,255,0.05);
}
.glass-card-strong {
  background: rgba(245, 240, 232, 0.12);
  backdrop-filter: blur(30px);
  border: 1px solid rgba(201, 168, 124, 0.4);
}
```

### 2. Chat Interface (Glassmorphism)

```css
.chat-container {
  width: 700px;
  background: rgba(10, 10, 26, 0.6);
  backdrop-filter: blur(40px);
  border: 1px solid rgba(201, 168, 124, 0.25);
  border-radius: 32px;
  box-shadow: 0 20px 60px rgba(0,0,0,0.5), 0 0 0 1px rgba(201, 168, 124, 0.1) inset;
}
.chat-header {
  background: rgba(201, 168, 124, 0.15);
  padding: 24px 32px;
  border-bottom: 1px solid rgba(201, 168, 124, 0.2);
}
.chat-bubble.user {
  background: rgba(201, 168, 124, 0.2); color: #F5F0E8;
  border-bottom-right-radius: 4px;
}
.chat-bubble.bot {
  background: rgba(245, 240, 232, 0.1); color: #F5F0E8;
  border: 1px solid rgba(201, 168, 124, 0.15);
  border-bottom-left-radius: 4px;
}
```

### 3. Number Badges

```css
.number-badge {
  width: 64px; height: 64px;
  background: rgba(201, 168, 124, 0.15);
  border: 1px solid rgba(201, 168, 124, 0.3);
  border-radius: 16px;
  font-family: 'Space Grotesk', monospace;
  font-size: 28px; font-weight: 700; color: #C9A87C;
  display: flex; align-items: center; justify-content: center;
}
```

### 4. Decorative Elements

```css
.copper-line {
  height: 1px;
  background: linear-gradient(90deg, transparent, #C9A87C, transparent);
  opacity: 0.5;
}
.vertical-line {
  width: 1px; background: #C9A87C; opacity: 0.3;
}
.chip-grid {
  background-image:
    linear-gradient(rgba(201, 168, 124, 0.05) 1px, transparent 1px),
    linear-gradient(90deg, rgba(201, 168, 124, 0.05) 1px, transparent 1px);
  background-size: 80px 80px;
}
```

## Scene Templates (class="clip" Model)

### Scene Type A: Hero Title

```html
<div id="scene1" class="clip" data-start="0.1" data-duration="12.0" data-track-index="2"
     style="background: radial-gradient(ellipse at center, #121224 0%, #0A0A1A 100%);">
  <div class="chip-grid" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></div>
  <div style="position: relative; z-index: 10; text-align: center; max-width: 1400px;">
    <p class="mono-text" style="opacity: 0.8;">TAGLINE</p>
    <h1 class="display-hero">
      <span style="color: var(--taalas-copper);">Highlighted</span> Text
    </h1>
    <div class="copper-line" style="width: 200px; margin: 30px auto;"></div>
    <p class="body-xl">Subtitle</p>
  </div>
</div>
```

### Scene Type B: Split Layout

```html
<div id="scene2" class="clip" data-start="12.1" data-duration="16.0" data-track-index="2"
     style="background: #0A0A1A;">
  <div class="chip-grid" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></div>
  <div style="display: flex; gap: 60px; align-items: center; max-width: 1600px; padding: 0 80px;">
    <div style="flex: 1;">
      <p class="mono-text">SECTION LABEL</p>
      <h2 class="display-lg">Headline <span style="color: var(--taalas-copper);">accent</span></h2>
      <div class="glass-card">Content</div>
    </div>
    <div style="flex: 0 0 1px;">
      <div class="vertical-line" style="height: 400px;"></div>
    </div>
    <div style="flex: 1;">
      <div class="glass-card-strong">Visual element</div>
    </div>
  </div>
</div>
```

### Scene Type C: Glassmorphism Chatbot

```html
<div id="scene3" class="clip" data-start="28.1" data-duration="15.0" data-track-index="2">
  <div style="display: flex; gap: 60px; align-items: center; max-width: 1600px; padding: 0 80px;">
    <div style="flex: 1;">
      <p class="mono-text">FEATURE LABEL</p>
      <h2 class="display-lg">Feature <span style="color: var(--taalas-copper);">Name</span></h2>
      <div class="glass-card">Feature list</div>
    </div>
    <div style="flex: 0 0 720px;">
      <div class="chat-container">
        <div class="chat-header"><!-- Avatar + title --></div>
        <div><!-- Messages --></div>
      </div>
    </div>
  </div>
</div>
```

### Scene Type D: Principle Grid

```html
<div id="scene4" class="clip" data-start="43.1" data-duration="14.0" data-track-index="2"
     style="background: #0A0A1A;">
  <div class="chip-grid" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></div>
  <div style="position: relative; z-index: 10; text-align: center; max-width: 1400px;">
    <p class="mono-text" style="margin-bottom: 40px;">SECTION TITLE</p>
    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px;">
      <div class="glass-card" style="text-align: left;">
        <div class="number-badge" style="margin-bottom: 20px;">01</div>
        <p class="body-lg" style="color: var(--taalas-cream);">Principle text</p>
      </div>
      <!-- Repeat -->
    </div>
  </div>
</div>
```

## Recommended Catalog Blocks

| Block | Install | Use Case |
|-------|---------|----------|
| `flash-through-white` | `npx hyperframes add flash-through-white` | Elegant scene transitions |
| `captions` | `npx hyperframes add captions` | Premium subtitle styling |
| `lower-third` | `npx hyperframes add lower-third` | Speaker attribution |
| `instagram-follow` | `npx hyperframes add instagram-follow` | End card CTA |

## Transitions for This Theme

| Energy | CSS/Shader | When to Use |
|--------|-----------|-------------|
| 3-4 | Blur crossfade | Calm, premium transitions |
| 5-6 | `flash-through-white` | Architectural reveals |
| 6-7 | Push slide | Modern, structured cuts |

## Animation Patterns

```javascript
// Hero entrance
tl.from(".mono-text", { opacity: 0, y: 20, duration: 0.6 }, 0.3);
tl.from("h1", { opacity: 0, y: 40, duration: 1, stagger: 0.2 }, 0.6);
tl.from(".copper-line", { scaleX: 0, duration: 0.8 }, 1.2);

// Glass card reveal
tl.from(".glass-card", { opacity: 0, y: 30, duration: 0.7 }, 0.5);

// Chat messages
tl.from(".chat-bubble", { opacity: 0, y: 20, duration: 0.4, stagger: 0.4 }, 1.0);
```

## Frame Review Checklist (Taalas)

- [ ] Glass cards have visible depth (not flat)
- [ ] Copper accent doesn't blend into cream text
- [ ] Chip grid is subtle (opacity 0.03-0.05)
- [ ] Navy background isn't pure black (#0A0A1A vs #000)
- [ ] Glassmorphism doesn't cause performance drops (limit backdrop-filter layers)

## Usage

```bash
# 1. Copy color CSS variables
# 2. Import Space Grotesk font
# 3. Use glass-card components
# 4. Apply copper accent to key phrases
# 5. Add chip-grid background pattern
# 6. Install flash-through-white + captions blocks
# 7. Use class="clip" + data-start/data-duration
```
