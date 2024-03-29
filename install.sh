#!/usr/bin/env bash
set -e

TEMP_DIR=$(mktemp -d)
trap "rm -rf ${TEMP_DIR}" EXIT

VERBOSE="${VERBOSE:-0}"

if [[ "$VERBOSE" == "true" ]]; then
	set -x
fi

function distro() {
	case $OSTYPE in
	darwin*)
		echo "macos"
		;;
	linux-gnu)
		echo "$(lsb_release -is)"
		;;
	esac
}

function install_homebrew() {
	echo "Installing packages using brew"
	export PATH="$PATH:/opt/homebrew/bin"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	brew install $@
}

function install_apt() {
	echo "Installing packages using apt"

	sudo apt update

	sudo apt install -y $@
}

function install_pacman() {
	echo "Installing packages using pacman"

	sudo pacman -S $@

	# This is required for neovim to be able to interact with system clipboard
	sudo pacman -Sy xclip neovim-nvim-treesitter
}

function install_packages() {
	case "$(distro)" in
	macos)
		install_homebrew $@
		;;
	Ubuntu)
		install_apt $@
		;;
	ManjaroLinux)
		install_pacman $@
		;;
	esac
}

#############################################################
##  Install packages with specific distro package manager  ##
#############################################################

install_packages zsh jq fzf yq ripgrep go kubectl git-delta

echo "Installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

#################################
##  Install packages using go  ##
#################################

echo "Installing packages using go"
go install github.com/gsamokovarov/jump@latest
go install github.com/jesseduffield/lazygit@latest

####################################
##  Install packages using cargo  ##
####################################

cargo install exa
cargo install bat

# Install Oh My Zsh
if [ ! -d $HOME/.oh-my-zsh ]; then
	echo "Installing Oh My Zsh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install zgenom
if [ ! -d $HOME/.zgenom ]; then git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"; fi

if [ $SHELL != "/bin/zsh" ]; then
	echo "Setting zsh as a default terminal"
	chsh -s /bin/zsh
fi

# Install starship.rs
curl -sS https://starship.rs/install.sh | sh

# Checkout configuration
if [ ! -d $HOME/.cfg ]; then
	echo "Setting up .cfg repo"
	REPO="https://github.com/kamilczerw/.cfg"

	if [ ! -d $HOME/.cfg ]; then git clone --bare $REPO $HOME/.cfg; fi
	config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

	$config checkout
	$config config --local status.showUntrackedFiles no
	$config config user.name "Kamil Czerwiński"
	$config config user.email "kamil@czerwinski.dev"

	git config --global include.path "${HOME}/.git-conf/config"
else
	echo ".cfg has already been initialized. Skipping"
fi

# Install krew for kubectl
if [ ! -d $HOME/.krew ]; then
	(
		set -x
		cd "$(mktemp -d)" &&
			OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
			ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
			KREW=./krew-"${OS}_${ARCH}" &&
			curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
			tar zxvf "${KREW}.tar.gz" &&
			"$KREW" install krew
		export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

		kubectl krew install ctx
		kubectl krew install ns
	)
fi

# Install tfenv
if [ ! -d $HOME/.tfenv ]; then
	git clone https://github.com/tfutils/tfenv.git $HOME/.tfenv
else
	echo "tfenv has already been installed. Skipping"
fi

SSH_CONF_DIR=$HOME/.ssh/config.d/

if [ ! -f $SSH_CONF_DIR/local ]; then
	[ -d $SSH_CONF_DIR ] || mkdir -p $SSH_CONF_DIR/

	echo "Host github.com
  User git
  IdentityFile ~/.ssh/keys/github.key" >$SSH_CONF_DIR/local

	echo "!!! Remember to create ~/.ssh/keys/github.key"
fi
