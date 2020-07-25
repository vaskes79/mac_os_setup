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
  
  ZSHRC_PATH=~/.zshrc
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
-----------------------------------${RESET}"

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
  cat >> ~/.zshrc << EOF

# for readline
export LDFLAGS="-L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include"

EOF

  source $ZSHRC_PATH

  echo "${YELLOW}Cleaning brew up...${RESET}"
  brew cleanup
}

install_setup_nvm(){
  echo "${YELLOW}stage: NVM
-----------------------------------${RESET}"
  wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

  cat >> $ZSHRC_PATH << EOF

# for NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

EOF
 
  source $ZSHRC_PATH
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
  echo "${YELLOW}stage: ADDITIONA OS SETTINGS
-----------------------------------${RESET}"
}

clean(){
  echo "${YELLOW}stage: CLEAN
-----------------------------------${RESET}"
}

MAIN(){
  colors

  echo "${YELLOW}
Start script
--------------------------------------------------------------------------------
${RESET}"

  preparation
  
  # instal_xcode
  # install_update_brew
  install_brew_packages
  install_setup_nvm 
  
  #echo "${YELLOW}stage: SETUP ENV
#-----------------------------------${RESET}"
  # setup_git
  # setup_zsh
  # setup_vim
  # setup_nvim
  # setup_vscode
  # additional_config_os
  # clean
}

MAIN "$@"
