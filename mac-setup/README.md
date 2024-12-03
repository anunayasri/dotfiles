# Setup a New Mac

Install NerdFont

```sh
# brew install --cask font-<name>-nerd-font
brew install --cask font-meslo-lg-nerd-font
```

--

TODO: How to copy settings of GUI apps(like spectacle) ❓

Install npm using nvm

https://nodejs.org/en/download/package-manager

```sh
# installs nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash

# download and install Node.js (you may need to restart the terminal)
nvm install 22

# verifies the right Node.js version is in the environment
node -v # should print `v22.11.0`

# verifies the right npm version is in the environment
npm -v # should print `10.9.0`
```

---

```sh
brew install --cask dbeaver-community
brew install --cask visual-studio-code 
brew install --cask docker

brew install --cask alacritty
# alacritty cli
sudo ln -s /Applications/Alacritty.app/Contents/MacOS/alacritty /usr/local/bin/alacritty

# Window organizer
brew install --cask spectacle
```

---
Soft links to config files

Clone repo if doesn't exist, else take the latest pull

`git clone https://github.com/anunayasri/dotfiles.git`

```sh
ln -s $HOME/workspace/dotfiles/tmux $HOME/.config/tmux
ln -s $HOME/workspace/dotfiles/vifm/vifmrc $H0ME/.config/vifm/vifmrc
ln -s $HOME/workspace/dotfiles/alacritty $HOME/.config/alacritty
ln -s $HOME/workspace/dotfiles/.shellrc $HOME/.shellrc
ln -s $HOME/workspace/dotfiles/.zshrc $H0ME/.zshrc
ln -s $HOME/workspace/dotfiles/vifm $PWD/vifm
ln -S $HOME/workspace/dotfiles/nvim $PWD/nvim
ln -s $HOME/workspace/dotfiles/git $PWD/git
```


