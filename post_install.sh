#!/bin/bash

require() {
  for cmd in $@; do
    command -v "$cmd" > /dev/null 2>&1 || {
      echo "$cmd not installed"
      exit 4
    }
  done
}

require git rcup gpg

[ -d $HOME/.dotfiles ] || {
  git clone --depth=1 https://github.com/kajisha/dotfiles $HOME/.dotfiles
  $(cd $HOME/.dotfiles; RCRC=$HOME/.dotfiles/rcrc rcup)
}

[ -d $HOME/.bash_it ] || {
  git clone --depth=1 https://github.com/Bash-it/bash-it.git $HOME/.bash_it
  $HOME/.bash_it/install.sh -s
}

[ -d $HOME/.fzf ] || {
  git clone --depth=1 https://github.com/junegunn/fzf.git $HOME/.fzf
  yes | $HOME/.fzf/install
}

[ -d $HOME/.tmux/plugins/tpm ] || {
  git clone --depth=1 https://github.com/tmux-plugins/tpm.git $HOME/.tmux/plugins/tpm
}

RUBY_VERSION=${RUBY_VERSION:-2.5.0}
PYTHON3_VERSION=${PYTHON3_VERSION:-3.6.4}
PYTHON2_VERSION=${PYTHON2_VERSION:-2.7.14}
NODEJS_VERSION=${NODEJS_VERSION:-8.9.4}

[ -d $HOME/.asdf ] || {
  git clone --depth=1 https://github.com/asdf-vm/asdf.git $HOME/.asdf

  echo -e '\n. $HOME/.asdf/asdf.sh' >> $HOME/.bashrc
  echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> $HOME/.bashrc
}

for plugin in ruby python nodejs; do
  $HOME/.asdf/bin/asdf plugin-add $plugin
done

$HOME/.asdf/bin/asdf install ruby $RUBY_VERSION
$HOME/.asdf/bin/asdf global ruby $RUBY_VERSION

$HOME/.asdf/bin/asdf install python $PYTHON3_VERSION
$HOME/.asdf/bin/asdf install python $PYTHON2_VERSION
$HOME/.asdf/bin/asdf global python $PYTHON3_VERSION $PYTHON2_VERSION

$HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring
# FIXME: On Alpinelinux, prebuilt binary cannot run. it seems musl related problem.
#$HOME/.asdf/bin/asdf install nodejs $NODEJS_VERSION
#RHOME/.asdf/bin/asdf global nodejs $NODEJS_VERSION
