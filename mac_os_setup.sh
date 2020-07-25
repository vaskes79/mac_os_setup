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
  echo "Install xcode"
  xcode-select --install
}

preparation(){
  echo "${YELLOW}stage: PREPARATION
-----------------------------------${RESET}"
  
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

install_update_brew(){
  echo "${YELLOW}stage: HOMEBREW
--------------------------------${RESET}"

  echo "${YELLOW}Install or update brew${RESET}"

  if test ! $(which brew); then
      echo "${YELLOW}Installing homebrew...${RESET}"
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  brew update
  brew tap Homebrew/bundle

}

install_brew_packages(){
  echo "${YELLOW}Brew bundle install packages${RESET}"

  brew bundle install

  # Any additional steps you want to add here
  brew link --force readline

  echo "${YELLOW}Cleaning brew up...${RESET}"
  brew cleanup
}

install_docker(){
  echo "${YELLOW}Install Docker and docker compose${RESET}"
}

install_python(){
  echo "${YELLOW}Install python${RESET}"
}

install_ruby() {
  echo "${YELLOW}Instyll ruby${RESET}"
}

install_go(){
  echo "${YELLOW}Instyll go${RESET}"
}

install_nvm(){
  echo "${YELLOW}Install NVM${RESET}"
}

setup_git(){
  echo "${YELLOW}Setup Git${RESET}"
}

setup_zsh(){
  echo "${YELLOW}Setup ZSH${RESET}"
}

setup_vim(){
  echo "${YELLOW}Setup Vim${RESET}"
}
setup_nvim(){
  echo "${YELLOW}Setup nvim${RESET}"
}

setup_vscode(){
  echo "${YELLOW}Setup Vscode${RESET}"
}

additional_config_os(){
  echo "${YELLOW}Additional config OS${RESET}"
}

clean(){
  echo "${YELLOW}Clean installation${RESET}"
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
