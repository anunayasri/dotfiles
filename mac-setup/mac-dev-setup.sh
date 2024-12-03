#!/bin/bash

if ! hash brew
then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	printf "\e[93m%s\e[m\n" "brew is already installed."
fi

echo "Updating homebrew..."
brew update

function install_via_brew() {
    local program=$1
    local use_cask=${2:-""}  # Default to empty string if not provided

    if command -v "$program" &> /dev/null; then
        printf "\e[93m%s\e[m\n" "$program is already installed."

    else
        printf "\e[93m%s\e[m\n" "Installing $program ..."
        if [ "$use_cask" == "via_cask" ]; then
            brew install --cask "$program"
        else
            brew install "$program"
        fi
    fi

}

install_via_brew alacritty

exit 0

echo "Installing Git..."
brew install git

echo "Installing Neovim..."
brew install nvim

echo "Installing cli tools via brew..."
brew install tree
brew install wget
brew install curl
brew install fzf
brew install zoxide
brew install tmux
brew install vifm
brew install starship
brew install tree-sitter

echo "Cleaning up brew"
brew cleanup

echo "Installing homebrew cask..."
brew install caskroom/cask/brew-cask

echo "Creating workspace folder..."
mkdir $HOME/workspace

echo "Copying dotfiles from Github"
cd $HOME/workspace
git clone git@github.com:bradp/dotfiles.git
