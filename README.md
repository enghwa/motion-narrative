# motion-narrative

[![Skill](https://img.shields.io/badge/Agent-Skill-blue)](https://github.com/enghwa/motion-narrative)
[![HyperFrames](https://img.shields.io/badge/Powered%20by-HyperFrames-purple)](https://hyperframes.io)

> Create cinematic, narrated motion-graphics videos from research sources. Built for HyperFrames with catalog blocks, transitions, sub-compositions, and frame review.

---

## 🚀 Quick Install (for AI Agents)

### **Claude Code / Claude Desktop**
```bash
# Clone into your skills directory
claude skills add github.com/enghwa/motion-narrative

# Or manually clone to:
# ~/.claude/skills/  (macOS/Linux)
# %APPDATA%\Claude\skills\  (Windows)
```

### **Pi (pi-coding-agent)**
```bash
# Pi supports npx skill installation
npx pi add skill github.com/enghwa/motion-narrative

# Or clone to Pi's skill directory
git clone https://github.com/enghwa/motion-narrative.git \
  ~/.pi/skills/motion-narrative
```

### **Kiro CLI**
```bash
# Kiro uses the skills/ subdirectory
kiro skill add github.com/enghwa/motion-narrative

# Or manual install
cd ~/.kiro/skills && git clone https://github.com/enghwa/motion-narrative.git
```

### **Cline / Roo Code (VS Code)**
```bash
# Add to Cline's custom instructions directory
git clone https://github.com/enghwa/motion-narrative.git \
  ~/.vscode-server/cline/skills/motion-narrative

# Or reference directly in settings:
# "cline.customInstructions": "$(cat ~/.skills/motion-narrative/SKILL.md)"
```

### **Aider**
```bash
# Add as a architect-mode skill
mkdir -p ~/.aider/skills && \
git clone https://github.com/enghwa/motion-narrative.git \
  ~/.aider/skills/motion-narrative

# Or use in prompts:
# /read ~/.aider/skills/motion-narrative/SKILL.md
```

### ** Generic / Manual Install**
```bash
# Works with any agent - clone to a known location
git clone https://github.com/enghwa/motion-narrative.git

# Then tell your agent:
# "Read the skill at ./motion-narrative/SKILL.md"
```

---

## 📋 What This Skill Does

**Motion Narrative** creates professional video content from research sources:

| Feature | Description |
|---------|-------------|
| 🎬 **Cinematic Videos** | Research-driven explainer videos with motion graphics |
| 🗣️ **Voice Synthesis** | TTS via Microsoft Edge (cloud) or Kokoro (local) |
| 🎨 **Visual Styles** | Cyberpunk, Swiss Grid, Visual Metaphor presets |
| 📦 **Catalog Blocks** | Reusable charts, overlays, transitions |
| 🖼️ **Frame Review** | Visual QA before final render |
| 🎵 **Music Library** | 5 pre-attenuated royalty-free tracks included |

---

## 🛠️ Prerequisites

| Tool | Required | Version | Purpose |
|------|----------|---------|---------|
| **Node.js** | ✅ Yes | >= 22 | HyperFrames runtime |
| **ffmpeg** | ✅ Yes | any recent | Video encoding |
| **ffprobe** | ✅ Yes | any recent | Media analysis (bundled with ffmpeg) |
| **bash** | ✅ Yes | any | Skill scripts execution |
| **Python 3** | ⚠️ Recommended | 3.8+ | Advanced audio ducking |
| **jq** | ⚠️ Recommended | any | JSON processing |
| **edge-tts** | ❌ Optional | latest | Cloud TTS (Azure) |

---

## 🔍 Prerequisites Check (Windows & macOS)

Run these commands in your terminal to verify your environment:

### Option 1: Quick Copy-Paste

```bash
# Check all core dependencies at once
echo "=== Node.js ===" && node --version
echo "=== FFmpeg ===" && ffmpeg -version | head -1
echo "=== FFprobe ===" && ffprobe -version | head -1
echo "=== Bash ===" && bash --version | head -1
echo "=== Python3 ===" && python3 --version
echo "=== jq ===" && jq --version
echo "=== edge-tts ===" && pip3 show edge-tts | grep Version
```

### Option 2: Detailed Platform-Specific Checks

#### macOS (Terminal or iTerm2)

```bash
# 1. Node.js (should show v22.x.x or higher)
node --version

# If missing: brew install node
# Or download from: https://nodejs.org

# 2. FFmpeg & FFprobe (bundled together)
ffmpeg -version
ffprobe -version

# If missing: brew install ffmpeg
# Or download from: https://ffmpeg.org/download.html

# 3. Bash (usually pre-installed on macOS)
bash --version

# 4. Python 3 (usually pre-installed)
python3 --version

# 5. jq (optional, for advanced scripts)
jq --version

# If missing: brew install jq

# 6. edge-tts (optional, for cloud voice)
pip3 install edge-tts

# Verify: pip3 show edge-tts
```

#### Windows (PowerShell or CMD)

```powershell
# 1. Node.js (should show v22.x.x or higher)
node --version

# If missing:
# - Download from: https://nodejs.org (LTS version)
# - Or use winget: winget install OpenJS.NodeJS

# 2. FFmpeg & FFprobe (bundled together)
ffmpeg -version
ffprobe -version

# If missing:
# - Download from: https://ffmpeg.org/download.html (Windows builds)
# - Extract to C:\ffmpeg and add C:\ffmpeg\bin to your PATH
# - Or use winget: winget install Gyan.FFmpeg

# 3. Bash (Windows 10/11 with WSL or Git Bash)
# Option A - WSL (recommended):
#    wsl --install
#    Then run: wsl bash --version
#
# Option B - Git Bash (included with Git for Windows):
#    Download: https://git-scm.com/download/win
#    Bash location: "C:\Program Files\Git\bin\bash.exe"

# 4. Python 3 (optional, for ducking)
python --version

# If missing: Download from https://python.org

# 5. jq (optional)
# Download from: https://stedolan.github.io/jq/download/
# Or use winget: winget install stedolan.jq

# 6. edge-tts (optional)
pip install edge-tts

# Verify: pip show edge-tts
```

### Option 3: Automated Check Script

Save this as `check-deps.sh` and run it:

```bash
#!/bin/bash
# Dependencies check for motion-narrative skill

echo "========================================="
echo "Motion Narrative Dependencies Check"
echo "========================================="
echo ""

check_tool() {
    local cmd=$1
    local name=$2
    local required=$3
    local install_hint=$4
    
    if command -v $cmd &> /dev/null; then
        local version=$($cmd --version 2>/dev/null | head -1 || echo "installed")
        echo "✅ $name: $version"
    else
        if [ "$required" = "required" ]; then
            echo "❌ $name: MISSING (REQUIRED)"
            echo "   Install: $install_hint"
        else
            echo "⚠️  $name: missing (optional - $install_hint)"
        fi
    fi
}

check_tool "node" "Node.js" "required" "https://nodejs.org (v22+)"
check_tool "ffmpeg" "FFmpeg" "required" "https://ffmpeg.org/download.html"
check_tool "ffprobe" "FFprobe" "required" "(bundled with FFmpeg)"
check_tool "bash" "Bash" "required" "Pre-installed on macOS/Linux or use WSL/Git Bash on Windows"
check_tool "python3" "Python 3" "optional" "https://python.org (needed for audio ducking)"
check_tool "jq" "jq" "optional" "brew install jq (macOS) or winget install stedolan.jq (Windows)"

echo ""
echo "========================================="
echo "Optional pip packages:"
echo "========================================="
echo ""

if pip3 show edge-tts &> /dev/null; then
    echo "✅ edge-tts: $(pip3 show edge-tts | grep Version | cut -d' ' -f2)"
else
    echo "⚠️  edge-tts: not installed (pip3 install edge-tts)"
fi

echo ""
echo "========================================="
```

**Run with:**
- macOS/Linux: `bash check-deps.sh`
- Windows (WSL/Git Bash): `bash check-deps.sh`

---

## 📦 Installation Quick Fixes

### macOS (using Homebrew)

```bash
# If you don't have Homebrew:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install everything needed:
brew install node ffmpeg jq python3

# Optional: pip3 install edge-tts
```

### Windows

```powershell
# Using winget (built-in on Windows 10/11):
winget install OpenJS.NodeJS
winget install Gyan.FFmpeg
winget install stedolan.jq

# Install Python from Microsoft Store:
winget install Python.Python.3.12

# For bash, install WSL or Git for Windows:
winget install Microsoft.WindowsSubsystemforLinux
# OR
winget install Git.Git
```

### Linux (Ubuntu/Debian)

```bash
# Install everything:
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs ffmpeg python3 python3-pip jq

# Optional: pip3 install edge-tts
```

---

## 🎯 Usage Examples

### Quick Decision Tree

```
Topic type? ──► Corporate/technical ──► --example swiss-grid
              ├── Data/stats heavy ──► --example nyt-graph
              ├── Educational/how-to ──► --example decision-tree
              ├── Narrative/documentary ──► --example warm-grain
              ├── Product/demo ──► --example play-mode
              ├── Abstract/concept ──► --example kinetic-type
              └── Social/mobile (9:16) ──► --example vignelli
```

### Basic Command
```bash
npx hyperframes create my-video \
  --example swiss-grid \
  --tts af_heart \
  --music corporate.mp3
```

---

## 📁 Repository Structure

```
motion-narrative/
├── SKILL.md                    ← Main skill instructions (READ THIS)
├── README.md                   ← This file
├── scripts/
│   ├── generate-tts.sh         # TTS generation wrapper
│   ├── parse-vtt.sh            # VTT → JSON timestamps
│   ├── resize-images.sh        # Image optimization
│   └── capture-preview.sh      # Frame capture for review
├── styles/
│   ├── cyberpunk-v2.md         # Cyberpunk visual style
│   ├── taalas-v2.md            # Technical/scientific style
│   └── visual-metaphor-v2.md   # Metaphor-driven visuals
└── assets/music/
    ├── corporate.mp3
    ├── cinematic.mp3
    ├── ambient.mp3
    ├── technology.mp3
    └── upbeat.mp3
```

---

## 🤖 For AI Agents: How to Use This Skill

### 1. Read the Full Skill Documentation
```
Read SKILL.md completely before starting any video project.
```

### 2. Key Sections to Note
- **⚠️ Known Migration Gotcha** (Step 8 has critical `clip` model fix)
- **Quick Decision Tree** (choose the right example template)
- **Frame Review Protocol** (always preview before render)
- **Music Library** (use `data-volume="1.0"` as control point)

### 3. Workflow
```
1. Scaffold → Use `npx hf create --example <template>`
2. Install Blocks → `npx hf install <block>` for charts/overlays
3. TTS → `npx hf tts` (Kokoro) or `edge-tts`
4. Preview → `npx hf preview` (visual QA)
5. Render → `npx hf render`
6. Review → Run frame review protocol
```

---

## 🎵 Music Library

| File | Mean Volume | Mood | Best For |
|------|-------------|------|----------|
| `corporate.mp3` | -31.0 dB | Professional, optimistic | Pitch decks, business |
| `cinematic.mp3` | -33.5 dB | Dramatic, building | Deep-dives, reveals |
| `ambient.mp3` | -39.6 dB | Calm, atmospheric | Tutorials, walkthroughs |
| `technology.mp3` | -33.3 dB | Modern, electronic | Tech topics, code |
| `upbeat.mp3` | -38.6 dB | Energetic, positive | Demos, launches |

**Important**: Pre-attenuated to ~20-30%. Use `data-volume="1.0"` as single control point.

---

## 🗣️ Voice Options

| Voice ID | Description | Source |
|----------|-------------|--------|
| `en-US-GuyNeural` | Deep male, professional | edge-tts (DEFAULT) |
| `en-US-AriaNeural` | Warm female, conversational | edge-tts |
| `en-GB-RyanNeural` | British male, authoritative | edge-tts |
| `af_heart` | Warm, emotional | Kokoro (local) |
| `af_nova` | Bright, clear | Kokoro (local) |
| `am_adam` | Casual male | Kokoro (local) |

---

## ⚠️ Known Issues for Agents

### GSAP `from()` Blank Frames
**v2's `class="clip"` model** sets `display: none` on inactive scenes. If using GSAP `from()`/`fromTo()`, the "from" state is applied at timeline creation → elements get `opacity: 0` while hidden → **blank frames**.

**Fix**: Add `onRefresh` to force visibility:
```javascript
tl.from([".scene-00 .txt", ".scene-00 img"], {
  opacity: 0,
  scale: 0.92,
  stagger: 0.08,
  duration: 0.6,
  ease: "power2.out",
  onRefresh: (self) => {
    // Force visibility during setup
    self.targets().forEach(el => el.style.display = "block");
  }
});
```

See **Step 8** in SKILL.md for complete details.

---

## 📦 Agent Platform Reference

| Platform | Install Command | Skill Location |
|----------|-----------------|----------------|
| **Claude Code** | `claude skills add <repo>` | `~/.claude/skills/` |
| **Pi** | `npx pi add skill <repo>` | `~/.pi/skills/` |
| **Kiro** | `kiro skill add <repo>` | `~/.kiro/skills/` |
| **Cline** | Manual clone | `~/.vscode-server/cline/skills/` |
| **Aider** | Manual clone | `~/.aider/skills/` |
| **Generic** | `git clone` | User-defined |

---

## 🔗 Links

- **Repository**: https://github.com/enghwa/motion-narrative
- **Skill Documentation**: See `SKILL.md` in this repo
- **HyperFrames**: https://hyperframes.io
- **Evolved from**: research-video v1

---

## 📄 License

MIT - See repository for full license text.

---

*This skill is designed for agent-to-agent consumption. AI coding assistants should read SKILL.md completely before generating video projects.*
