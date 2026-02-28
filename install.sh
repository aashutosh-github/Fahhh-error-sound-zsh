#!/usr/bin/env bash

set -e

SOUND_DIR="$HOME/.sounds"
ZSHRC="$HOME/.zshrc"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_SOUND="$SCRIPT_DIR/assets/fahhhhh.wav"
TARGET_SOUND="$SOUND_DIR/fahhhhh.wav"

echo "Installing Zsh Error Sound..."

# Ensure Zsh exists
if ! command -v zsh >/dev/null; then
    echo "Zsh is not installed. Aborting."
    exit 1
fi

# Ensure aplay exists
if ! command -v aplay >/dev/null; then
    echo "aplay not found. Install ALSA utilities:"
    echo "  sudo apt install alsa-utils"
    exit 1
fi

# Create sound directory
mkdir -p "$SOUND_DIR"

# Copy sound file
cp "$SOURCE_SOUND" "$TARGET_SOUND"

# Add hook only if not already present
if ! grep -q "# --- ZSH ERROR SOUND ---" "$ZSHRC" 2>/dev/null; then
cat << 'EOF' >> "$ZSHRC"

# --- ZSH ERROR SOUND ---
play_error_sound() {
    if [[ $? -ne 0 ]]; then
        aplay ~/.sounds/fahhhhh.wav >/dev/null 2>&1
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd play_error_sound
# --- END ZSH ERROR SOUND ---
EOF
fi

echo "Installed successfully!"
echo "Restart terminal or run: source ~/.zshrc"
