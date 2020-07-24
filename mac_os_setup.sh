#!/usr/bin/env bash
colors(){
	# Only use colors if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		RESET=""
	fi
}

menu() {
    echo "Avaliable options:"
    for i in ${!options[@]}; do
        printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${options[i]}"
    done
    [[ "$msg" ]] && echo "$msg"; :
}

instal_xcode(){
  echo "install xcode"
  xcode-select —-install
}

preparation(){
  echo "${YELLOW}stage: preparation${RESET}"
  
  XCODE=no
  BREW=no
  BREW_PACKAGES=no
  INSTALL_BREW_CASK_PAKAGES=no

  RUBY=no
  PYTHON=no
  NVM=no
  GO=no

  DOCKER=no

  VIM=no
  NVIM=no
  VSCODE=no

  ZSH=no
  OS_CONFIG=no
}

instal_xcode(){
  echo "install xcode"
  xcode-select —-install
}

install_update_brew(){
  echo "Install or update brew"
  ################################################################################
  # Check for Homebrew to be present, install if it's missing
  ################################################################################
  if test ! $(which brew); then
      echo "Installing homebrew..."
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  # Update homebrew recipes
  brew update
}

install_brew_packages(){
  echo "Brew will install follow packages:
ctags djview4 djvulibre docker docker-compose docker-machine fzf heroku htop imagemagick neovim yarn youtube-dl zsh git tmux macvim nvim vlc fzf ctags ripgrep readline ffmpeg"
  #################################################################################
  ## Install base brew packages
  #################################################################################
  PACKAGES=(
      ctags
      djview4
      djvulibre
      docker
      docker-compose
      fzf
      heroku
      htop
      yarn
      youtube-dl
      zsh
      git
      tmux
      macvim
      vlc
      fzf
      ctags
      ripgrep
      readline
      ffmpeg
  )

  echo "Installing packages..."
  brew install ${PACKAGES[@]}

  ################################################################################
  # Any additional steps you want to add here
  ################################################################################
  # link readline
  brew link --force readline

  echo "Cleaning up..."
  brew cleanup
}

install_brew_cask_pakages(){
  echo "Install brew cask packages"
}

install_python(){
  echo "Install python"
}

install_ruby() {
  echo "Instyll ruby"
}

install_go(){
  echo "Instyll go"
}

install_nvm(){
  echo "Install NVM"
}

install_docker(){
  echo "Install Docker and docker compose"
}

setup_git(){
  echo "Setup Git"
}

setup_zsh(){
  echo "Setup ZSH"
}

setup_vim(){
  echo "Setup Vim"
}
setup_nvim(){
  echo "Setup nvim"
}

setup_vscode(){
  echo "Setup Vscode"
}

additional_config_os(){
  echo "Additional config OS"
}

clean(){
  echo "Clean installation"
}

MAIN(){
  colors

  echo "${YELLOW}
Start script
--------------------------------------------------------------------------------
${RESET}"


  preparation
  
  instal_xcode
  install_update_brew
  install_brew_packages
  # install_brew_cask_pakages
  # install_python
  # install_ruby
  # install_go
  # install_nvm
  # install_docker
  # setup_git
  # setup_zsh
  # setup_vim
  # setup_nvim
  # setup_vscode
  # additional_config_os
}

MAIN "$@"
