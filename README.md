# Motiongraphics

Workspace for motion graphics with AI agent skills.

## Installed skills (`.claude/skills/`)

**HyperFrames – Core Skills** (`heygen-com/hyperframes`):
`hyperframes` (router), `hyperframes-core`, `hyperframes-animation`, `hyperframes-audio`,
`hyperframes-cli`, `hyperframes-creative`, `hyperframes-keyframes`, `hyperframes-registry`,
`hyperframes-studio`, `media-use`. Creation workflows (e.g. `motion-graphics`, `general-video`)
are installed on demand by the `/hyperframes` router.

**Claude Animation** (`buildwithhanif/claude-animation-skill`): `claude-animation` —
hand-drawn 2D animation in JS, rendered with node canvas + ffmpeg.

**Vox Director** (`Alisa0808/vox-director`): `vox-director` — Vox-style paper-collage
explainer/ad videos (script, collage keyframes, motion, voice-over, music, captions).
Needs an Atlas Cloud API key in `ATLASCLOUD_API_KEY` (https://www.atlascloud.ai/console/api-keys),
plus ffmpeg and Python Pillow. Its showcase demo videos (`assets/*.mp4`) are not committed.

Versions are pinned in `skills-lock.json`.

## Setup on a fresh machine

Requirements: Node.js 22+, FFmpeg, Python 3 with Pillow (`pip install pillow`).

```bash
npx hyperframes browser ensure                       # headless Chrome for rendering
(cd .claude/skills/claude-animation && npm install)  # @napi-rs/canvas
npx hyperframes doctor                               # verify
```

Update skills: `npx hyperframes skills update` / `npx skills update`.
