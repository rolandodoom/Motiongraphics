#!/bin/sh
# Richtet lemo-opuscar in einer frischen Cloud-Sitzung ein:
# Stil-Bibliothek (~/lemo-opuscar), Kern-Abhängigkeiten und Render-Browser.
# Der Browser-Download der Bibliothek (cdn.playwright.dev) ist im Netzwerk dieser
# Umgebung gesperrt; deshalb wird der Headless Chrome von HyperFrames verlinkt.
set -e
SETUP=$(ls -d "$HOME"/.claude/plugins/cache/lemolab/lemo-opuscar/*/skills/lemo-opuscar/scripts/setup.sh 2>/dev/null | head -1)
[ -n "$SETUP" ] || { echo "✗ Plugin lemo-opuscar fehlt. Neue Sitzung starten oder: claude plugin install lemo-opuscar@lemolab"; exit 1; }

# 1. Bibliothek holen und Node-Pakete installieren (Browser-Schritt darf hier scheitern)
LIB=$(sh "$SETUP" | sed -n 's/^LIB=//p')
(cd "$LIB" && [ -d node_modules ] || npm install --no-audit --no-fund --loglevel=error)

# 2. Headless Chrome über HyperFrames beschaffen und unter der erwarteten Revision verlinken
npx -y hyperframes browser ensure >/dev/null
SRC=$(ls -d "$HOME"/.cache/hyperframes/chrome/chrome-headless-shell/linux-*/chrome-headless-shell-linux64 | tail -1)
REV=$(node -e "console.log(require('$LIB/node_modules/playwright-core/browsers.json').browsers.find(b=>b.name==='chromium-headless-shell').revision)")
DIR=${PLAYWRIGHT_BROWSERS_PATH:-$HOME/.cache/ms-playwright}/chromium_headless_shell-$REV
mkdir -p "$DIR"
ln -sfn "$SRC" "$DIR/chrome-headless-shell-linux64"
touch "$DIR/INSTALLATION_COMPLETE" "$DIR/DEPENDENCIES_VALIDATED"

# 3. Restliche Kern-Abhängigkeiten (Python-Umgebung)
sh "$SETUP" deps "$@"
echo "✓ lemo-opuscar bereit: $LIB"
