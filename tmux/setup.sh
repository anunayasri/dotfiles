#! /bin/bash

set -euo pipefail

TMUX_DIR="$HOME/.config/tmux"

log() { echo -e "👉 $1"; }
success() { echo -e "✅ $1"; }
fail() { echo -e "❌ $1"; }

install_tpm() {
  local TPM_DIR="$TMUX_DIR/plugins/tpm"

  if [ -d "$TPM_DIR" ]; then
    success "TPM (tmux plugin manager) already installed at $TPM_DIR"
  else
    log "Installing TPM (tmux plugin manager)..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR" && success "TPM installed at $TPM_DIR"
  fi
}
 
install_theme() {
    THEME_DIR="$TMUX_DIR/plugins/catppuccin"
    if [ -d "$THEME_DIR" ]; then
        success "Catppuccin is already installed."
    else
        log "Installing Catppuccin theme..."
        mkdir -p $THEME_DIR
        git clone -b v2.1.3 https://github.com/catppuccin/tmux.git $THEME_DIR/tmux && success "Catppuccin installed at $THEME_DIR"
    fi
}



main() {
  install_tpm
  install_theme
}

main "$@"

