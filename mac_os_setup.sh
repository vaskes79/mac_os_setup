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

setup_nvm(){
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

patch_oh_my_zsh(){
  echo "${YELLOW}Add patch for powerline${RESET}"

  # clone
  git clone https://github.com/powerline/fonts.git --depth=1
  # install
  cd fonts
  ./install.sh
  # clean-up a bit
  cd ..
  rm -rf fonts
}

setup_zsh(){
  echo "${YELLOW}Install oh may  ZSH${RESET}"

  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &

  patch_oh_my_zsh

  sed -i 's/robbyrussell/agnoster/' $ZSHRC_PATH

  echo "${YELLOW}Setup terminal${RESET}"
}

setup_git(){
  echo "${YELLOW}Setup Git${RESET}"

  local GIT_IGNORE_PATH=~/.gitignore_global
  local GIT_CONFIG=~/.gitconfig

  if [ ! -f "$GIT_IGNORE_PATH" ]; then

  cat >> $GIT_IGNORE_PATH << EOF

################################################################################
# OS
################################################################################

################################################################################
# NODE
################################################################################

# dependencies 
###############
/node_modules

npm-debug.log*
yarn-debug.log*
yarn-error.log*
# npmy https://www.npmjs.com/package/npmy
.npmyrc

# production
###############
.env.local
.env.development.local
.env.test.local
.env.production.local

################################################################################
# EDITORS
################################################################################

# vim
###############
# Swap
[._]*.s[a-v][a-z]
[._]*.sw[a-p]
[._]s[a-v][a-z]
[._]sw[a-p]

# Session
Session.vim

# Temporary
.netrwhist
*~
# Auto-generated tag files
tags
# Persistent undo
[._]*.un~

# vscode https://github.com/github/gitignore/blob/master/Global/VisualStudioCode.gitignore
###############

.vscode/*
!.vscode/settings.json
!.vscode/tasks.json
!.vscode/launch.json
!.vscode/extensions.json
EOF
  echo "${YELLOW}creted $GIT_IGNORE_PATH file with:${RESET}
  ${BLUE}$(cat < $GIT_IGNORE_PATH)${RESET}"
  else 
    echo "${GREEN}$GIT_IGNORE_PATH exists${RESET}"
  fi


  if [ ! -f "$GIT_CONFIG" ]; then
    touch $GIT_CONFIG
    cat >> $GIT_CONFIG << EOF
[user]
	email = vasily.guzov@gmail.com
	name = Vasily Guzov
[core]
	excludesfile = "$GIT_IGNORE_PATH"
	editor = vim
[alias]
    st = status
    cm = commit -m
	co = checkout
	logg = log --graph --full-history --all --color --pretty=tformat:\"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s\"
	unstage = reset HEAD --
	reseth = reset --hard HEAD
	branch-history = for-each-ref --sort=-committerdate --count=10 --format='%(refname:short)' refs/heads/
[format]
	commitMessageColumns = 72
[color]
	ui = true
EOF
  
  echo "${YELLOW}creted $GIT_CONFIG file with:${RESET}
  ${BLUE}$(cat < $GIT_CONFIG)${RESET}"
  else 
    echo "${GREEN}$GIT_CONFIG exists${RESET}"
  fi
  
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
  # install_brew_packages
  
  echo "${YELLOW}stage: SETUP ENV
-----------------------------------${RESET}"

  setup_zsh
  # setup_nvm 
  setup_git
  # setup_vim
  # setup_nvim
  # setup_vscode
  # additional_config_os
  # clean
}

MAIN "$@"
