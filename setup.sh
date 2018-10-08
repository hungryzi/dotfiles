#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# # Install some other useful utilities like `sponge`.
brew install moreutils

# # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# # Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

brew install tree stow

# Symlink dotfiles
cd ~/dotfiles && stow home

# Tmux
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

# Zsh
brew install zsh zsh-completions
chsh -s $(which zsh)
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Base16 colorscheme
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
ln -s ~/.config/base16-shell/scripts/base16-tomorrow-night.sh ~/.base16_theme

# Neovim
brew install neovim
pip3 install neovim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +'PlugInstall --sync' +qa

# Ruby: rvm...
\curl -sSL https://get.rvm.io | bash --auto-dotfiles
rvm install 2.4
rvm use 2.4 --default && gem install tmuxinator

# JavaScript: nvm, yarn...
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm alias default node
nvm install node
nvm use node

brew install yarn
