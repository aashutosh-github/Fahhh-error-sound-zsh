#!/usr/bin/env bash

ZSHRC="$HOME/.zshrc"
SOUND_FILE="$HOME/.sounds/fahhhhh.wav"

echo "Removing Zsh Error Sound..."

# Remove block from .zshrc
sed -i '/# --- ZSH ERROR SOUND ---/,/# --- END ZSH ERROR SOUND ---/d' "$ZSHRC" 2>/dev/null || true

# Remove sound file
rm -f "$SOUND_FILE"

echo "Uninstalled successfully."
echo "Restart terminal or run: source ~/.zshrc"
