#!/usr/bin/env bash
#######################################################
# ┏━╸╻ ╻╺┳╸┏━┓┏━╸┏┳┓┏━╸   ╻ ╻╻  ╺┳╸╻┏┳┓┏━┓╺┳╸┏━╸    ┏┓ ┏━┓┏━┓╻ ╻┏━┓┏━╸
# ┣╸ ┏╋┛ ┃ ┣┳┛┣╸ ┃┃┃┣╸    ┃ ┃┃   ┃ ┃┃┃┃┣━┫ ┃ ┣╸     ┣┻┓┣━┫┗━┓┣━┫┣┳┛┃
# ┗━╸╹ ╹ ╹ ╹┗╸┗━╸╹ ╹┗━╸   ┗━┛┗━╸ ╹ ╹╹ ╹╹ ╹ ╹ ┗━╸   ╹┗━┛╹ ╹┗━┛╹ ╹╹┗╸┗━╸
# Extreme Ultimate .bashrc File sources are free and
# open software released under the MIT License (MIT)
# https://sourceforge.net/projects/ultimate-bashrc/files/
#
# The MIT License (MIT)
# Copyright © 2022
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the “Software”), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#######################################################
# To Install or Update:
# wget -O ~/.bashrc https://sourceforge.net/projects/ultimate-bashrc/files/_bashrc/download
# wget -O ~/.bashrc_help https://sourceforge.net/projects/ultimate-bashrc/files/_bashrc_help/download
# -or-
# curl -L --output ~/.bashrc https://sourceforge.net/projects/ultimate-bashrc/files/_bashrc/download
# curl -L --output ~/.bashrc_help https://sourceforge.net/projects/ultimate-bashrc/files/_bashrc_help/download
#######################################################
# Supported Optional Applications/Dependencies:
# 7z aria2 baca bash-completion bashmarks bashtop bat bc blesh bottom bpytop
# broot btop btrfs bzip2 ccat cmatrix cod colordiff commacd curl delta doas dua
# dust dym enhancd exa exiftool fasd fd ffmpeg figlet fx fzf fzy gawk gcal gdu
# git gitalias git-commander git-completion git-delta gitui glances glow grc grv
# gtop gzip hBlock hstr htop icdiff ifconfig iotop jless jq jp2a lazygit lolcat
# lscolors lsd lsof lsx mc mcfly micro mlocate moar multitail mysql-colorize
# nano ncdu neovim nmon nnn paru qfc rar resh ripgrep rsync shellcheck shred
# skim silver_searcher source-highlight tar terminology thefuck tig tmux toilet
# trash-cli tree tuifi ugit vivid vlock wget xsel youtube-dl yt-dlp ytfzf ytop
# zellij zf zip zoxide
#
# Supported Optional Huds:
# neofetch, fastfetch, screenFetch, linux_logo, archey, pfetch
#
# Supported Optional Prompts:
# Trueline, Powerline, Powerline-Go, Powerline-Shell,
# Pureline, Starship, Bash Git Prompt, Liquid Prompt
#
# To Install Packages:
# pkginstall [package names separated by spaces]
#######################################################
# set -o errexit  # Exit when a command fails
# set -o pipefail # Catch mysqldump fails
# set -o nounset  # Exit when using undeclared variables
# set -o xtrace   # Trace what gets executed (useful for debugging)

### ERROR TRAPPING
# alias debug="set -o nounset; set -o xtrace"
# error() { echo 'Error in ${1} on line ${2}: ${3}' }
# trap 'error "${BASH_SOURCE}" "${LINENO}"' ERR

### TEST FOR AN INTERACTIVE SHELL
# This file is sourced by all "interactive" bash shells on startup
# including shells such as scp and rcp that can't tolerate any output.
# There is no need to set anything past this point for scp and rcp,
# and it's important to refrain from outputting anything in those cases.
[[ $- != *i* ]] && return
[[ -z "$PS1" ]] && return

# Security for X apps
if [[ -x "$(command -v xhost)" ]]; then
	xhost +local:root > /dev/null 2>&1
fi

# Bash version check
if ((BASH_VERSINFO[0] < 4)); then
	echo "This .bashrc file requires at least Bash 4.0"
	exit 1
fi

# If missing, recreate a new empty history file so apps don't show errors
if [[ -z ${HISTFILE+x} ]]; then
	[[ ! -f "$HOME/.bash_history" ]] && touch "$HOME/.bash_history"
else
	[[ ! -f "$HISTFILE" ]] && touch "$HISTFILE"
fi

# Source global definitions
if [[ -f /etc/bashrc ]]; then
	 source /etc/bashrc
elif [[ -f /etc/bash.bashrc ]]; then
	 source /etc/bash.bashrc
fi

#######################################################
# Set the default editor
# Examples: vim, nvim, emacs, nano, micro, helix, pico,
# or gui apps like kate, gedit, notepadqq, or vscodium
# NOTE: In Git Bash, you can use something like "/c/Program\ Files/Notepad++/notepad++.exe"
# To change these without modifying this file, simply
# add these with your changes to one of these files:
# ~/.env
# ~/.envrc
# ~/.config/bashrc/config
# See section "Configuration and Extras" in the README:
# Link: https://sourceforge.net/projects/ultimate-bashrc/files/
#######################################################

export EDITOR=nano visudo
export VISUAL=nano visudo
export SUDO_EDITOR=nano
export FCEDIT=nano

# We will default to use either Neovim https://neovim.io or vim instead of vi
# NOTE: vi is POSIX compliant but vim has more features and Neovim is more extensible
# http://www.viemu.com/a-why-vi-vim.html
# https://www.linuxfordevices.com/tutorials/linux/vim-vs-neovim
if [[ -x "$(command -v nvim)" ]]; then
	alias {v,vi,vim}='nvim'
	alias svi='sudo nvim'
	alias vis='nvim "+set si"'
elif [[ -x "$(command -v vim)" ]]; then
	alias {v,vi}='vim'
	alias svi='sudo vim'
	alias vis='vim "+set si"'
elif [[ -x "$(command -v vi)" ]]; then
	alias v='vi'
	alias svi='sudo vi'
fi

# Set some defaults for nano
# NOTE: Depending on the version of nano you have, --linenumbers and --suspend is helpful
if [[ -x "$(command -v nano)" ]]; then
	alias {n,nano}='nano --smarthome --multibuffer --const --autoindent'
fi

# Set Micro editor true color support
# Link: https://micro-editor.github.io/
# Install: curl https://getmic.ro | bash
export MICRO_TRUECOLOR=1

# Create an alias for the Helix editor
# See hx --tutor or :tutor for a vimtutor-like introduction
# Link: https://github.com/helix-editor/helix
# Link: https://docs.helix-editor.com/title-page.html
if [[ -x "$(command -v helix)" ]]; then
	alias hx='helix'
fi

# Alias to run the default editor
# Edit any file using the default editor for the user
# and auto-detect if root permissions are needed
function edit() {
	# If we have no parameters
	if [[ $# -eq 0 ]]; then
		# Load the default editor without any file
		"${EDITOR}"
	# If the file exists, and we have read/write access...
	elif [[ -r "${1}" ]] && [[ -w "${1}" ]]; then
		# Load in the default editor
		"${EDITOR}" "${1}"
	elif [[ -f "${1}" ]]; then # The file does exist...
		# Edit the file using sudo but use this users default editor
		echo -ne "\033[1;31mInsufficient permissions:"
		echo -e "\033[1;33m Using super user to edit \033[1;36m${1}\033[0m"
		#sudoedit "${1}" 2> /dev/null || sudo --preserve-env "${EDITOR}" "${1}"
		sudo --preserve-env "${EDITOR}" "${1}"
	else # File does not exist...
		# Create a new file...
		if touch "${1}" ; then
			# If success, edit it
			"${EDITOR}" "${1}"
			# If there was no edit (file is empty), delete it
			[[ -s "${1}" ]] || \rm -f "${1}" 2>/dev/null
		else # Cannot create new file...
			# Create the file using sudo using this user's default editor
			echo -ne "\033[1;31mInsufficient permissions:"
			echo -e "\033[1;33m Using super user to create \033[1;36m${1}\033[0m"
			#sudoedit "${1}" 2> /dev/null || sudo --preserve-env "${EDITOR}" "${1}"
			sudo --preserve-env "${EDITOR}" "${1}"
		fi
	fi
}

# Shortcut for edit using only the letter e
alias e="edit"
alias se="sudoedit"

#######################################################
# Set default variable values
# These variables can be overridden in one of these environment variable files:
# ~/.env
# ~/.envrc
# ~/.config/bashrc/config
#######################################################

# Determines if CTRL-h will show help
# Ctrl+h (for help) and Ctrl+Backspace share the same key binding
# in some terminal emulators so we default to skip this keybind
_SKIP_HELP_KEYBIND=true

# Show an installed information HUD on initial Bash load (if not skipped)
# Link: https://github.com/LinusDierheimer/fastfetch
# Link: https://ostechnix.com/neofetch-display-linux-systems-information/
# Link: https://github.com/KittyKatt/screenFetch
# Link: https://github.com/deater/linux_logo
# Link: https://github.com/dylanaraps/pfetch
_SKIP_SYSTEM_INFO=false

# If not skipped, shows pending updates (only in Arch, Manjaro, and Ubuntu)
# WARNING: This check for updates takes several seconds so the default is true
_SKIP_UPGRADE_NOTIFY=true

# Automatically launch TMUX terminal multiplexer in local, TTY, or SSH sessions
# https://github.com/tmux/tmux/wiki
# Since TMUX is pre-installed on so many systems, the default is to skip TMUX
_TMUX_LOAD_TTY=false
_TMUX_LOAD_SSH=false
_TMUX_LOAD_LOCAL=false

# OPTIONAL: Set and force the default TMUX session name for this script and tm
# If not specified, an active TMUX session is used and attached to
# If no active TMUX session exists, the current logged in user name is used
#_TMUX_LOAD_SESSION_NAME=""

# Terminology is a graphical EFL terminal emulator that can run in TTY sessions
# If installed, it can automatically be launched when starting a TTY session
# To split the window horizontally press Ctrl+Shift+PgUp
# To split the window vertically press Ctrl+Shift+PgDn
# To create Tabs press Ctrl+Shift+T and cycle through using Ctrl+1-9
# Link: https://github.com/borisfaure/terminology
# Link: https://linoxide.com/terminology-terminal/
_SKIP_TERMINOLOGY_TTY=false

# Blesh: Bash Line Editor replaces default GNU Readline
# Link: https://github.com/akinomyoga/ble.sh
# Link for configuration: https://github.com/akinomyoga/ble.sh/blob/master/blerc
# WARNING: Can be buggy with certain prompts (like Trueline)
_SKIP_BLESH=false

# Make sure the default file and directory permissions for newly created files
# in the home directory is umask 026 to improve security.
# (user=read/write/execute, group=read/execute, others=execute for directories)
# The default is to skip this security setting and not modify home permissions
_SKIP_UMASK_HOME=true

# Replaces Sudo with one of the two alternatives (if installed):
# RootDO (rdo) - A very slim alternative to both sudo and doas
# Link: https://codeberg.org/sw1tchbl4d3/rdo
# - OR -
# A port of OpenBSD's doas offers two benefits over sudo:
# 1) Its configuration file has a simple syntax and
# 2) It is smaller, requiring less effort to audit the code
# Link: https://github.com/Duncaen/OpenDoas or https://github.com/slicer69/doas
# Default value is skip and must be set to false manually for security reasons
_SKIP_SUDO_ALTERNATIVE=true

# If set to true, cd will not output the current absolute path under certain
# circumstances like when using the command cd - or using cdable_vars bookmarks
# Link: https://www.gnu.org/software/bash/manual/bash.html#index-cd
_SILENCE_CD_OUTPUT=false

# If set to true, will not load anything that modifies the ls command or colors
_SKIP_LS_COLORIZED=false

# exa is a modern color replacement for ls that also has some Git support
# Link: https://github.com/ogham/exa
_SKIP_EXA=false

# grc Generic Colouriser
# Link: https://github.com/garabik/grc
_SKIP_GRC=false

# If set to true, will not source bash completion scripts
_SCRIPT_BASH_COMPLETION=false

# If set to true, will show a calendar when Bash is started
_SHOW_BASH_CALENDAR=false

# If GNU gcal is installed, use this local for holidays
# To show the possible options type: gcal -hh | grep 'Holidays in'
# Link: https://www.gnu.org/software/gcal/manual/gcal.html
# Link: https://unix.stackexchange.com/questions/164555/how-to-emphasize-holidays-by-color-in-cal-command
_GCAL_COUNTRY_CODE=US_AK

# Skip the birthday/anniversary reminder that shows a message in your teminal?
# Reads the birthday CSV file: ~/.config/birthdays.csv
# The first line is ignored (header) and the format is (year is optional):
# Month,Day,Year,"Message"
# Jan,1,1985,"This is a message!"
#
# Toilet application is an optional dependency
# Install Arch/Manjaro:  sudo pacman -S toilet
# Install Ubuntu/Debian: sudo apt-get install toilet
_SKIP_BDAY_REMINDER=false

# Set the location for the birthday/anniversary reminder CSV file
# The default location is "~/.config/birthdays.csv"
_BDAY_FILE="${HOME}/.config/birthdays.csv"

# Set the preferred birthday reminder font here (default is "future"):
_BDAY_FONT=future

# Set to have the built in prompt use a faster but less precise Git method
# This might be necessary on slow connections or networked directories
# Also if set to true, will remove exa's --git flag (use lsg for Git info)
_GIT_IS_SLOW=false

# Recognize the depreciated _PROMPT_BUILTIN_FASTER_GIT option
if [[ ${_PROMPT_BUILTIN_FASTER_GIT} = true ]]; then
	_GIT_IS_SLOW=true
fi

# Optional original prompt from 2014 version now with newly added Git support
# download the optional .bashrc_prompt script file and place it in either your
# home directory or as the file ~/.config/bashrc/prompt
# You will also need to make sure this setting is set to false
_SKIP_PROMPT_ORIGINAL=false

# If false, the built-in prompt will be one single line with an abbreviated path
# If true, the built-in prompt will split into two lines with a full path
_PROMPT_BUILTIN_FULL_PATH=false

# Trueline Bash (true 24-bit color and glyph support)
# This is the prefered prompt since it looks amazing,
# has so many features, is easily extended using functions,
# and is a single Bash script file that is easy to install.
# Link: https://github.com/petobens/trueline
# Install: wget https://raw.githubusercontent.com/petobens/trueline/master/trueline.sh -P ~/
# Fonts: https://github.com/powerline/fonts
_SKIP_PROMPT_TRUELINE=false

# Powerline-Go (this prompt uses no special glyphs)
# Link: https://github.com/justjanne/powerline-go
_SKIP_PROMPT_POWERLINE_GO=false

# Powerline-Shell (details about git/svn/hg/fossil branch and Python virtualenv environment)
# Link: https://github.com/b-ryan/powerline-shell
_SKIP_PROMPT_POWERLINE_SHELL=false

# Pureline (256 color written in bash script)
# Link: https://github.com/chris-marsh/pureline
# Install:
# git clone https://github.com/chris-marsh/pureline.git
# cp pureline/configs/powerline_full_256col.conf ~/.pureline.conf
_SKIP_PROMPT_PURELINE=false

# Starship Cross Shell Prompt (focus on compatibility and written in Rust)
# Link: https://starship.rs
# Install: sh -c "$(curl -fsSL https://starship.rs/install.sh)"
_SKIP_PROMPT_STARSHIP=false

# Oh-My-Git (only used for Git but has huge support for it, requires font)
# Link: https://github.com/arialdomartini/oh-my-git
# Install: git clone https://github.com/arialdomartini/oh-my-git.git ~/.oh-my-git
_SKIP_PROMPT_OH_MY_GIT=false

# Bash Git Prompt (shows git repository, branch name, difference with remote branch, number of files staged, changed, etc)
# Link: https://github.com/magicmonty/bash-git-prompt
# Install: git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
_SKIP_PROMPT_BASH_GIT_PROMPT=false

# Bash Powerline (no need for patched fonts, supports git, previous command execution status, platform-dependent prompt symbols)
# Link: https://github.com/riobard/bash-powerline
# Install: curl https://raw.githubusercontent.com/riobard/bash-powerline/master/bash-powerline.sh > ~/.bash-powerline.sh
_SKIP_PROMPT_BASH_POWERLINE=false

# Sexy Bash Prompt (supports git, 256 color)
# Link: https://github.com/twolfson/sexy-bash-prompt
# Install: (cd /tmp && ([[ -d sexy-bash-prompt ]] || git clone --depth 1 --config core.autocrlf=false https://github.com/twolfson/sexy-bash-prompt) && cd sexy-bash-prompt && make install)
_SKIP_PROMPT_SEXY_BASH_PROMPT=false

# Liquid Prompt (adaptive prompt with low color and no glyphs)
# Link: https://github.com/nojhan/liquidprompt
# Install: git clone --branch stable https://github.com/nojhan/liquidprompt.git ~/liquidprompt
_SKIP_PROMPT_LIQUIDPROMPT=false

# Original Powerline Status Line for Vim Bash Zsh fish tmux IPython Awesome i3 Qtile
# Link: https://github.com/powerline/powerline
# Install: https://medium.com/earlybyte/powerline-for-bash-6d3dd004f6fc
# NOTE: Requires Python and can be used with Trueline in Bash
# WARNING: This path may change or break in the future with new Python versions
_SKIP_PROMPT_POWERLINE=false

# Determine our kernel name
_KERNEL_NAME="$(expr substr $(uname -s) 1 5)"

#######################################################
# Add Common Binary Directories to Path
#######################################################

# Add directories to the end of the path if they exists and are not already in the path
# Link: https://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
function pathappend() {
	for ARG in "$@"
	do
		if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
			PATH="${PATH:+"$PATH:"}$ARG"
		fi
	done
}

# Add directories to the beginning of the path if they exist and are not already in the path
function pathprepend() {
	for ((i=$#; i>0; i--));
	do
		ARG=${!i}
		if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
			PATH="$ARG${PATH:+":$PATH"}"
		fi
	done
}

# Add the most common personal binary paths located inside the home folder
# (these directories are only added if they exist)
pathprepend "$HOME/bin" "$HOME/sbin" "$HOME/.local/bin" "$HOME/local/bin" "$HOME/.bin"

# Check for the Rust package manager binary install location
# Link: https://doc.rust-lang.org/cargo/index.html
pathappend "$HOME/.cargo/bin" "/root/.cargo/bin"

# If the GOPATH environment variable is not set, set it to the default
if [[ -x "$(command -v go)" ]] && [[ -z ${GOPATH+x} ]] && [[ -d $HOME/go ]]; then
	export GOPATH="$HOME/go"
fi

#######################################################
# User Specific Environment Variables
#######################################################

if [[ -f "$HOME/.envrc" ]]; then
	source "$HOME/.envrc"
fi

if [[ -f "$HOME/.env" ]]; then
	source "$HOME/.env"
fi

if [[ -f "$HOME/.config/bashrc/config" ]]; then
	source "$HOME/.config/bashrc/config"
fi

#######################################################
# Bashrc Support
#######################################################

# Alias to edit this .bashrc file
alias ebrc='edit ~/.bashrc'

# Find the help file for this .bashrc file (type hlp or press CONTROL-H)
if [[ -f "$HOME/.config/bashrc/help" ]]; then
	_BASHRC_HELP="$HOME/.config/bashrc/help"
	if [[ $_SKIP_HELP_KEYBIND = false ]]; then
		bind -x '"\C-h":"less -f -r -n -S ~/.config/bashrc/help"'
	fi
elif [[ -f "$HOME/.bashrc_help" ]]; then
	_BASHRC_HELP="$HOME/.bashrc_help"
	if [[ $_SKIP_HELP_KEYBIND = false ]]; then
		bind -x '"\C-h":"less -f -r -n -S ~/.bashrc_help"'
	fi
fi

# Alias to show the help file
alias hlp='\less -f -r -n -S "$_BASHRC_HELP"'

#######################################################
# Use these commands to keep the .bashrc immutable and write protected
# even from root so that other scripts and applications can't change it
#######################################################

alias bashrcprotect="sudo chattr +i $HOME/.bashrc"
alias bashrcunprotect="sudo chattr -i $HOME/.bashrc"
alias bashrccheckprotect='if [[ $(lsattr -R -l ~/.bashrc | grep " Immutable") ]]; then echo "Protected"; else echo "Not Protected"; fi;'

#######################################################
# Alias for Bashrc Updates
#######################################################

# Update this .bashrc and .bashrc_help files
if [[ -x "$(command -v aria2c)" ]]; then
	if [[ -f "$HOME/.config/bashrc/help" ]]; then
		alias bashrcupdate='if [[ $(lsattr -R -l ~/.bashrc | grep " Immutable") ]]; then sudo chattr -i ~/.bashrc; fi && aria2c --continue=true --async-dns=false --dir="${HOME}" --out=".bashrc" https://sourceforge.net/projects/ultimate-bashrc/files/_bashrc/download && aria2c --continue=true --async-dns=false --dir="${HOME}/.config/bashrc" --out="help" https://sourceforge.net/projects/ultimate-bashrc/files/_bashrc_help/download && echo "Restart your terminal to see the changes."'
	else
		alias bashrcupdate='if [[ $(lsattr -R -l ~/.bashrc | grep " Immutable") ]]; then sudo chattr -i ~/.bashrc; fi && aria2c --continue=true --async-dns=false --dir="${HOME}" --out=".bashrc" https://sourceforge.net/projects/ultimate-bashrc/files/_bashrc/download && aria2c --continue=true --async-dns=false --dir="${HOME}" --out=".bashrc_help" https://sourceforge.net/projects/ultimate-bashrc/files/_bashrc_help/download && echo "Restart your terminal to see the changes."'
	fi
elif [[ -x "$(command -v curl)" ]]; then
	if [[ -f "$HOME/.config/bashrc/help" ]]; then
		alias bashrcupdate='if [[ $(lsattr -R -l ~/.bashrc | grep " Immutable") ]]; then sudo chattr -i ~/.bashrc; fi && curl -L https://sourceforge.net/projects/ultimate-bashrc/files/_bashrc/download --output ~/.bashrc && curl -L https://sourceforge.net/projects/ultimate-bashrc/files/_bashrc_help/download --output ~/.config/bashrc/help && echo "Restart your terminal to see the changes."'
	else
		alias bashrcupdate='if [[ $(lsattr -R -l ~/.bashrc | grep " Immutable") ]]; then sudo chattr -i ~/.bashrc; fi && curl -L https://sourceforge.net/projects/ultimate-bashrc/files/_bashrc/download --output ~/.bashrc && curl -L https://sourceforge.net/projects/ultimate-bashrc/files/_bashrc_help/download --output ~/.bashrc_help && echo "Restart your terminal to see the changes."'
	fi
elif [[ -x "$(command -v wget)" ]]; then
	if [[ -f "$HOME/.config/bashrc/help" ]]; then
		alias bashrcupdate='if [[ $(lsattr -R -l ~/.bashrc | grep " Immutable") ]]; then sudo chattr -i ~/.bashrc; fi && wget -c -O ~/.bashrc https://sourceforge.net/projects/ultimate-bashrc/files/_bashrc/download && wget -c -O ~/.config/bashrc/help https://sourceforge.net/projects/ultimate-bashrc/files/_bashrc_help/download && echo "Restart your terminal to see the changes."'
	else
		alias bashrcupdate='if [[ $(lsattr -R -l ~/.bashrc | grep " Immutable") ]]; then sudo chattr -i ~/.bashrc; fi && wget -c -O ~/.bashrc https://sourceforge.net/projects/ultimate-bashrc/files/_bashrc/download && wget -c -O ~/.bashrc_help https://sourceforge.net/projects/ultimate-bashrc/files/_bashrc_help/download && echo "Restart your terminal to see the changes."'
	fi
else
	if [[ -x "$(command -v xdg-open)" ]]; then
		alias bashrcupdate='open https://sourceforge.net/projects/ultimate-bashrc/files/'
	else
		alias bashrcupdate='echo "Please install either wget, curl, aria2, or visit https://sourceforge.net/projects/ultimate-bashrc/ to update.'
	fi
fi

#######################################################
# Change the default file and directory permissions for newly created files
# in the home directory
# The default is usually 022 blocking writes for non-users
# umask 022 # u=rwx,g=rx,o=rx
#######################################################

# Only if we are not the root user...
if [[ $_SKIP_UMASK_HOME = false ]] && [[ $EUID -ne 0 ]]; then
	# Grant full access to the user, block write for group, and
	# block read write for others. Leave execute for directories.
	# (Also see fixuserhome function)
	umask u=rwx,g=rx,o=x # umask 026
fi

#######################################################
# General Aliases
# NOTE: To temporarily bypass an alias, we proceed the command with a \
# EG: if the ls command is aliased, to use the normal command you would type \ls
#######################################################

# Show a list of available aliases and functions
alias a='_listcommands | \less -n -S'
function _listcommands() {
	local COLOR="\033[1;31m" # Light Red
	local NOCOLOR="\033[0m"
	echo -e "${COLOR}Aliases:${NOCOLOR}"
	# compgen -A alias
	alias | awk -F'[ =]' '{print "\033[33m"$2"\033[0m\t\033[34m"$0"\033[0m";}'
	echo
	echo -e "${COLOR}Functions:${NOCOLOR}"
	compgen -A function | grep -v '^_.*'
}

#######################################################
### GIT ALIASES
#######################################################

# If git is installed...
if [[ -x "$(command -v git)" ]]; then

	# Git Alias: Provides many useful Git alias commands
	# This alias will install/update the Git alias commands file
	# Link: https://github.com/GitAlias/gitalias
	# Edit ~/.gitconfig and then include the path to this file like this:
	# [include]
	# path = gitalias.txt
	alias gitalias='curl -L --output "$HOME/gitalias.txt" https://raw.githubusercontent.com/GitAlias/gitalias/master/gitalias.txt && git config --global include.path "gitalias.txt"'

	# When invoked without arguments gg will do a short Git status,
	# otherwise it will just pass on the given arguments to the Git command.
	# Status is likely to be the Git command one will execute the most,
	# hence this simple enhancement does prove very useful in practice.
	alias gg='_f() { if [[ $# == 0 ]]; then git status --short --branch; else git "$@"; fi }; _f'

	# All Git aliases start with gg for speed
	alias ggg='git status'
	alias ggp='git pull' # Fetch and merge
	alias ggf='git fetch'
	alias ggm='git merge'
	alias ggpu='git push'
	alias ggr='git reset' # Specify a file to un-add or no file to unstage all
	alias gga='git add'
	alias ggap='git add -p' # Interactively choose hunks
	alias ggac='git add --all && git commit --verbose -m' # Add "commit message"
	alias ggc='git commit --verbose -m' # Add "commit message"
	alias ggm='git commit --amend --verbose'
	alias ggl='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'
	alias ggd='git diff'
	alias ggds='git diff --stat'
	alias ggdc='git diff --cached'
	alias ggb='gitbranch' # Change branch
	alias ggcb='git checkout -b' # Create new branch
	alias ggst='git stash'
	alias ggpop='git stash pop'

	# Vacuum the local Git repository database, reduce it's size, and clean out logs
	# Link: https://stackoverflow.com/questions/2116778/reduce-git-repository-size
	alias gitclean='git reflog expire --all --expire=now && git gc --prune=now --aggressive'

	# Find all Git repos in the current directory recursively
	# Note: Excludes hidden and temp directories
	# You can find all git repos on the entire system using: locate .git | grep "/.git$"
	alias gitrepos="find . -type d -not -path '*/.git/*' -not -path '*/tmp/*' -not -path '*/temp/*' -not -path '*/.*' -exec test -e '{}/.git' ';' -print -prune"

	# Git Auto-Completion
	# Link: https://github.com/git/git/tree/master/contrib/completion
	# Install: wget -O ~/git-completion.bash https://github.com/git/git/raw/master/contrib/completion/git-completion.bash
	if [[ -f "$HOME/git-completion.bash" ]]; then
		source "$HOME/git-completion.bash"
	fi

	# If exa (with Git support) is installed...
	# Link: https://github.com/ogham/exa
	if [[ -n $(which exa 2> /dev/null) ]]; then
		# Add icons if unicode and the icon paramter is supported
		if [[ ! $_SKIP_EXA = false ]] && [[ $(locale charmap) == 'UTF-8' ]] && [[ -n $(\exa --help | grep -e '--icons' 2> /dev/null) ]]; then
			alias exa='exa --icons'
		fi
		alias lsg='exa --long --all --links --group --modified --classify --git --group-directories-first --color=auto --color-scale'
	fi

	# Nearly everything you can do in Git but in a terminal UI
	# Link: https://github.com/Extrawurst/gitui
	if [[ -x "$(command -v gitui)" ]]; then
		alias ggu='gitui'
	fi

	# Tig ncurses-based text-mode interface for git
	# Link: https://jonas.github.io/tig/
	if [[ -x "$(command -v tig)" ]]; then
		alias gitt='tig'
	fi

	# Git Commander
	# Link: https://github.com/golbin/git-commander
	# Install: npm install -g git-commander
	if [[ -x "$(command -v git-commander)" ]]; then
		alias gitc='git-commander'
	fi

	# GRV - Git Repository Viewer
	# Link: https://github.com/rgburke/grv
	if [[ -x "$(command -v grv)" ]]; then
		alias gitrv='grv'
	fi

	# LazyGit - Terminal UI for git commands
	# Link: https://github.com/jesseduffield/lazygit
	if [[ -x "$(command -v lazygit)" ]]; then
		alias lg='lazygit'
	fi

	# Ugit - Git Undo
	# Link: https://github.com/Bhupesh-V/ugit
	# Install: sh -c "$(curl -fsSL https://raw.githubusercontent.com/Bhupesh-V/ugit/master/install)"
	if [[ -x "$(command -v ugit)" ]]; then
		alias gitundo='ugit'
	fi

	# List Git files by last modified date
	# Link: https://stackoverflow.com/questions/14141344/git-status-list-last-modified-date
	alias gitmodifieddate='IFS=""; git status -s | while read -n2 mode; read -n1; read file; do echo $mode $(stat -c %y "$file") $file; done | sort -k1,4'

	# Returns you to the Git project's top level
	alias cg='cd `git rev-parse --show-toplevel`'

	# Change the Git branch
	# If the branch is not specified and a picker is installed, a list of
	# branches is shown to choose from
	# Supported pickers are: skim, fzy, fzf, peco, percol, pick, icepick, selecta, or sentaku
	function gitbranch() {
		if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
			if [[ -z "${@}" ]]; then
				local _FOUND_PICKER=false
				for _PICKER in fzy sk fzf peco percol pick icepick selecta sentaku zf; do
					if [[ -x "$(command -v $_PICKER)" ]]; then
						_FOUND_PICKER=true
						git checkout $(git branch --sort=-committerdate | cut -c 3- | $_PICKER)
						break;
					fi
				done
				if [[ $_FOUND_PICKER == false ]]; then
					echo -e "\033[1;34mMost Recent Branches By Commit Date:\033[0m"
					echo "$(git branch --sort=-committerdate | head -n 20)"
					git checkout
				fi
			else
				git checkout ${@}
			fi
		else
			echo -e '\033[1;31mERROR:\033[1;37m Current directory is not a Git repository\033[0m'
		fi
	}

	# Using the Git status short format information, here's a function that
	# uses Awk and the column command to give you customized status output
	# Link: https://stackoverflow.com/questions/8727003/enhanced-ls-with-git-status-information
	function gitls() {
		git status --porcelain | \
			awk 'BEGIN {FS=" "}
			{
				xstat = substr($0, 1, 1);
				ystat = substr($0, 2, 1);
				f = substr($0, 4);
				ri = index(f, " -> ");
				if (ri > 0) f = substr(f, 1, ri);
				if (xstat == " " && ystat ~ "M|D") stat = "not_updated";
				else if (xstat == "M" && ystat ~ " |M|D") stat = "updated_in_index";
				else if (xstat == "A" && ystat ~ " |M|D") stat = "added_to_index";
				else if (xstat == "D" && ystat ~ " |M") stat = "deleted_from_index";
				else if (xstat == "R" && ystat ~ " |M|D") stat = "renamed_in_index";
				else if (xstat == "C" && ystat ~ " |M|D") stat = "copied_in_index";
				else if (xstat ~ "M|A|R|C" && ystat == " ") stat = "index_and_work_tree_matches";
				else if (xstat ~ " |M|A|R|C" && ystat == "M") stat = "work_tree_changed_since_index";
				else if (xstat ~ " |M|A|R|C" && ystat == "D") stat = "deleted_in_work_tree";
				else if (xstat == "D" && ystat == "D") stat = "unmerged,both_deleted";
				else if (xstat == "A" && ystat == "U") stat = "unmerged,added_by_us";
				else if (xstat == "U" && ystat == "D") stat = "unmerged,deleted_by_them";
				else if (xstat == "U" && ystat == "A") stat = "unmerged,added_by_them";
				else if (xstat == "D" && ystat == "U") stat = "unmerged,deleted_by_us";
				else if (xstat == "A" && ystat == "A") stat = "unmerged,both_added";
				else if (xstat == "U" && ystat == "U") stat = "unmerged,both_modified";
				else if (xstat == "?" && ystat == "?") stat = "untracked";
				else if (xstat == "!" && ystat == "!") stat = "ignored";
				else stat = "unknown_status";
				print f "   " stat;
			}' | \
			column -t -s "  " | "$PAGER"
	}

	# Forces Git to overwrite local files and resets the branch (or master)
	# Important: If you have any local changes, they will be lost (if they're tracked)!
	function gitresetbranch() {
		local branch="${@}"
		if [ -z "${branch}" ]; then
			read -r -p "No branch was specified. Do you wish to use master? [y/N] " response
			case "$response" in
				[yY][eE][sS]|[yY])
					local branch="master"
					;;
				*)
					echo "Please specify a branch."
					return 1
					;;
			esac
		fi
		read -r -p "WARNING: If you have any local changes, they will be lost! Are you sure? [y/N] " response
		case "$response" in
			[yY][eE][sS]|[yY])
				echo git checkout ${branch} && git fetch --all && git reset --hard origin/${branch}
				;;
			*)
				return 0
				;;
		esac
	}

	# Set defaults for Git (~/.gitconfig)
	function gitfixsettings() {
		local checkmark="\r\033[1;32m✓\033[0m"

		# If GitAlias (see gitalias alias) is installed...
		if [[ -f "$HOME/gitalias.txt" ]]; then
			# Tell Git to include this file
			git config --global include.path "gitalias.txt"
			echo -e "${checkmark} Found gitalias.txt"
		fi

		# Set the user name
		local GIT_USER_NAME
		read -e -i "$(git config --get user.name)" -p "Enter your user name (ENTER to skip): " GIT_USER_NAME
		if [ -z "${GIT_USER_NAME}" ]; then
			GIT_USER_NAME="User"
		fi
		git config --global user.name "${GIT_USER_NAME}"

		# Set the email address
		local GIT_USER_EMAIL
		read -e -i "$(git config --get user.email)" -p "Enter your email (ENTER to skip): " GIT_USER_EMAIL
		if [ -z "${GIT_USER_EMAIL}" ]; then
			GIT_USER_EMAIL="user@example.com"
		fi
		git config --global user.email "${GIT_USER_EMAIL}"

		# You should add this manually with your own information
		# git config --global user.signingkey <gpg-key-id>

		# Set the default Git editor to your default Bash editor
		git config --global core.editor "${EDITOR}"
		echo -e "${checkmark} Default editor set to ${EDITOR}"

		# Set the dafault pager
		git config --global core.pager "less --ignore-case --LONG-PROMPT --LINE-NUMBERS"

		# Set defaults for diff and merge
		git config --global merge.conflictstyle "diff3"
		git config --global diff.colorMoved "default"

		# Set this if icdiff is installed
		if [[ -x "$(command -v icdiff)" ]]; then
			git config --global icdiff.options '--highlight --line-numbers --strip-trailing-cr'
			echo -e "${checkmark} Found icdiff"
		fi

		# If delta is installed...
		if [[ -x "$(command -v delta)" ]]; then
			# delta - Beautiful side by side colored diff with Git support and syntax highlighting
			# Link: https://github.com/dandavison/delta
			# Info: Add listed settings to your ~/.gitconfig
			# NOTE: use n and N to move between diff sections
			git config --global core.pager "delta"
			git config --global interactive.diffFilter "delta --color-only --features=interactive"
			git config --global delta.features "decorations"
			git config --global delta.side-by-side "true"
			git config --global delta.line-numbers "true"
			git config --global delta.interactive.keep-plus-minus-markers "false"
			git config --global delta.decorations.commit-decoration-style "blue ol"
			git config --global delta.decorations.commit-style "raw"
			git config --global delta.decorations.file-style "omit"
			git config --global delta.decorations.hunk-header-decoration-style "blue box"
			git config --global delta.decorations.hunk-header-file-style "red"
			git config --global delta.decorations.hunk-header-line-number-style "#067a00"
			git config --global delta.decorations.hunk-header-style "file line-number syntax"
			echo -e "${checkmark} Found delta"
		fi

		# If we are in a desktop environment and Ultracompare is not installed...
		# You will be prompted when you launch Ultracompare to automatically set up
		# Git, so just skip the other diff configurations since this app is paid
		# Link: https://www.ultraedit.com/products/ultracompare-linux/
		if [[ -n "${XDG_CURRENT_DESKTOP}" ]]; then
			echo -e "${checkmark} User is in desktop environment ${XDG_CURRENT_DESKTOP}"

			# If UltraCompare is installed...
			# You will be prompted when you launch UltraCompare to automatically set up
			# Git, so just skip the other diff configurations since this app is paid
			# Link: https://www.ultraedit.com/products/ultracompare-linux/
			if [[ -x "$(command -v ucx)" ]]; then
				echo -e "${checkmark} Found UltraCompare"

			# If Meld is installed...
			# Link: https://meldmerge.org/
			elif [[ -x "$(command -v meld)" ]]; then
				# These settings will not alter the behaviour of "git diff"
				# Link: https://stackoverflow.com/questions/34119866/setting-up-and-using-meld-as-your-git-difftool-and-mergetool
				# You use "git difftool" in exactly the same way as you use git diff
				# Example: git difftool <COMMIT_HASH> file_name
				# Example: git difftool <BRANCH_NAME> file_name
				# Example: git difftool <COMMIT_HASH_1> <COMMIT_HASH_2> file_name
				git config --global diff.tool meld
				git config --global difftool.meld.path "$(which meld)"
				git config --global difftool.meld.cmd 'meld "$LOCAL" "$REMOTE"'
				git config --global difftool.prompt false

				# "git mergetool" allows you to use a GUI merge program to resolve merge conflicts
				# Before using git mergetool you perform a merge in the usual way with git
				# then Mergetool can now be used to resolve the merge conflicts
				git config --global merge.tool meld
				git config --global mergetool.meld.path "$(which meld)"
				git config --global mergetool.prompt false

				# Choose which starting edit position you'd prefer; $MERGED for the file
				# which contains the partially merged file with the merge conflict info
				# or $BASE for the shared commit ancestor of $LOCAL and $REMOTE
				git config --global mergetool.meld.cmd 'meld "$LOCAL" "$MERGED" "$REMOTE" --output "$MERGED"'
				#git config --global mergetool.meld.cmd 'meld "$LOCAL" "$BASE" "$REMOTE" --output "$MERGED"'

				# Also set up the alias "git meld" which works on Cygwin
				git config --global alias.meld '!git difftool -t meld --dir-diff'
				echo -e "${checkmark} Found meld"

			# If KDiff3 is installed...
			# Link: https://kdiff3.sourceforge.net/
			elif [[ -x "$(command -v kdiff3)" ]]; then
				git config --global diff.guitool kdiff3
				git config --global difftool.kdiff3.path "$(which kdiff3)"
				git config --global difftool.kdiff3.trustExitCode false
				git config --global merge.tool kdiff3
				git config --global mergetool.kdiff3.path "$(which kdiff3)"
				git config --global mergetool.kdiff3.trustExitCode false
				echo -e "${checkmark} Found KDiff3"
			fi
		fi
	}
fi

#######################################################
### SYSTEMD ALIASES
#######################################################

if [[ -x "$(command -v systemctl)" ]]; then
	# Get a list of all services
	alias services='systemctl list-units --type=service --state=running,failed'
	alias servicesall='systemctl list-units --type=service'

	# Find what systemd services have failed
	alias failed='systemctl --failed'

	# Get the status of a services
	alias servicestatus='sudo systemctl status'

	# Start or stop services
	alias servicestart='sudo systemctl start'
	alias servicestop='sudo systemctl stop'
	alias servicekill='sudo systemctl kill'
	alias servicerestart='sudo systemctl restart' # Stop and start
	alias servicereload='sudo systemctl reload'   # Reload configuration

	# Clear system log entries from the systemd journal
	alias clearsystemlogs='echo -ne "\033[1;34mBefore\033[0m: "; journalctl --disk-usage; sudo journalctl --rotate; sudo journalctl --vacuum-time=1s; echo -ne "\033[1;34mAfter\033[0m: "; journalctl --disk-usage'

	# If SSH is installed...
	if [[ -x "$(command -v ssh)" ]]; then
		# Create aliases to start/enable and stop/disable the SSH server
		alias sshstatus='systemctl status sshd.service'
		alias sshstart='sudo systemctl start sshd.service && sudo systemctl enable sshd.service'
		alias sshstop='sudo systemctl stop sshd.service && sudo systemctl disable sshd.service'
		alias sshrestart='sudo systemctl restart sshd.service && sudo systemctl enable sshd.service'
	fi

	# If gpm is installed...
	# Link: https://github.com/telmich/gpm
	if [[ -x "$(command -v gpm)" ]]; then
		alias ttymouseon='sudo systemctl enable --now gpm'
		alias ttymouseoff='sudo systemctl stop gpm && sudo systemctl disable gpm'
		alias ttymousestatus='sudo systemctl status gpm'
	fi
fi

#######################################################
### CHANGING AND LISTING DIRECTORIES
#######################################################

# Aliases for faster pushd and popd: type "p" for pushd and "p-" for popd
# Link: https://opensource.com/article/19/8/navigating-bash-shell-pushd-popd
alias p='pushd'
alias p-='popd'
# Allow us to clear the directory stack
alias dirsclear='dirs -c'
# If you want to see the numeric position of each directory in the stack,
# you can use the -v (vertical) option - as DT suggests, use this by default
alias dirs='dirs -v'

# Alias and bookmark the web folder (try to guess it's location)
# This will NOT overwrite a "web" alias previously definded in .bash_aliases
if [[ "$(type -t web)" != 'alias' ]]; then
	if [[ -d /var/www/html ]]; then
		alias web='cd /var/www/html'
		export web="/var/www/html"
	elif [[ -d /srv/http ]]; then
		alias web='cd /srv/http'
		export web="/srv/http"
	fi
fi

# If lsx enhanced directory navigation is found, source it
# Link: https://github.com/souvikinator/lsx
if [[ -f "$HOME/.config/lsx/lsx.sh" ]]; then
	source ~/.config/lsx/lsx.sh
fi
# If lsx is installed, alias it to see hidden directories
if [[ -x "$(command -v lsx)" ]]; then
	alias lsx='lsx -a'
fi

# If nnn is installed, add an alias for a directory listing
# Link: https://github.com/jarun/nnn/
# The following command installs or updates all plugins:
# Install: curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh
# Plugins are installed to ${XDG_CONFIG_HOME:-$HOME/.config}/nnn/plugins
if [[ -x "$(command -v nnn)" ]]; then
	if [[ -f "$HOME/.config/nnn/plugins/finder" ]]; then
		export NNN_PLUG='f:finder;o:fzopen;p:mocplay;d:diffs;t:nmount;v:imgview'
		alias nnnplugins='curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh'
	fi
	#alias nnn='nnn -e'
	alias nnn='nnn -Headr'
fi

# TUIFI Manager
# Link: https://github.com/GiorgosXou/TUIFIManager
# Install: pip3 install tuifimanager --upgrade
if [[ -x "$(command -v tuifi)" ]]; then
	alias ff="tuifi"
fi

# List folders recursively in a tree
if [[ -x "$(command -v tree)" ]]; then
	alias treed='\tree -CAFd'
fi

# List files recursively in a tree
if [[ -x "$(command -v broot)" ]]; then
	# If broot is installed...
	# Link: https://github.com/Canop/broot
	# Link: https://computingforgeeks.com/broot-easy-directory-trees-navigation-in-linux/

	# To generate this source file, type: broot --install
	if [[ -f "$HOME/.config/broot/launcher/bash/br" ]]; then
		# Source the br function
		source "$HOME/.config/broot/launcher/bash/br"

		# If Git is installed, enable the Git functionality
		if [[ -x "$(command -v git)" ]]; then
			alias {lb,tree}='br --sizes --dates --show-root-fs --hidden --show-git-info'
		else
			alias {lb,tree}='br --sizes --dates --show-root-fs --hidden'
		fi
	else
		# If Git is installed, enable the Git functionality
		if [[ -x "$(command -v git)" ]]; then
			alias {lb,tree}='broot --sizes --dates --show-root-fs --hidden --show-git-info'
		else
			alias {lb,tree}='broot --sizes --dates --show-root-fs --hidden'
		fi
	fi

elif [[ $_SKIP_EXA = false ]] && ([[ -x "$(command -v exa)" ]] || [[ "$(type -t exa)" = 'alias' ]]); then
	# If exa is installed...
	# Link: https://github.com/ogham/exa
	alias tree='\exa --all --git --group-directories-first --header --long --tree'
elif [[ -x "$(command -v lsd)" ]]; then
	# If lsd is installed...
	# Link: https://github.com/Peltoche/lsd
	alias tree='\lsd --all --blocks permission,user,size,date,name --group-dirs first --header --long --tree'
elif [[ -x "$(command -v tree)" ]]; then
	# If tree is installed...
	# Link: https://www.tecmint.com/linux-tree-command-examples/
	alias tree='\tree -CAhF --dirsfirst'
fi

# Aliases for multiple directory listing commands
if [[ $_SKIP_LS_COLORIZED = false ]]; then

	# If exa (with Git support) is installed...
	# Link: https://github.com/ogham/exa
	if [[ $_SKIP_EXA = false ]] && ([[ -x "$(command -v exa)" ]] || [[ "$(type -t exa)" = 'alias' ]]); then

		# Add icons to exa if unicode and the icon paramter is supported
		if [[ $(locale charmap) == 'UTF-8' ]]; then
			(\exa --help | grep -q -e "--icons" &> /dev/null) && alias exa='exa --icons'
		fi

		# If Git is not slow,use the exa Git feature
		if [[ $_GIT_IS_SLOW = false ]]; then
			_EXA_GIT_FLAG="--git "
		fi

		alias ls="exa --all --classify --group-directories-first --color=auto --color-scale"
		alias ll="exa --long --all --links --group --modified --classify ${_EXA_GIT_FLAG}--group-directories-first --color=auto --color-scale"
		alias labc="exa --grid --all --classify --color=auto --color-scale --sort name"
		alias lx="exa --long --all --links --group --modified --classify ${_EXA_GIT_FLAG}--group-directories-first --color=auto --color-scale --sort extension"
		alias lk="exa --long --all --links --group --modified --classify ${_EXA_GIT_FLAG}--group-directories-first --color=auto --color-scale --sort size"
		alias lt="exa --long --all --links --group --modified --classify ${_EXA_GIT_FLAG}--group-directories-first --color=auto --color-scale --sort modified"
		alias lc="exa --long --all --links --group --modified --changed --classify ${_EXA_GIT_FLAG}--group-directories-first --color=auto --color-scale --sort changed"
		alias lu="exa --long --all --links --group --modified --accessed --classify ${_EXA_GIT_FLAG}--group-directories-first --color=auto --color-scale --sort accessed"
		alias new="exa --long --all --links --group --modified --classify ${_EXA_GIT_FLAG}--group-directories-first --color=auto --color-scale --sort modified | tail -10 | tac"
		alias lw="exa --all --classify --group-directories-first --color=auto --color-scale"
		alias lm="\ls -alh --color=always | \less -S"
		alias lr="exa --grid --all --classify --group-directories-first --color=auto --color-scale --recurse"
		alias l.="\ls -aFhd .*"
		alias lfile="ls -l | egrep -v '^d'"
		alias ldir="exa --all --classify --group-directories-first --color=auto --color-scale --only-dirs"
		alias ltree="\exa --all ${_EXA_GIT_FLAG}--group-directories-first --header --long --tree"

	# If lsd is installed, use it instead
	# Link: https://github.com/Peltoche/lsd
	elif [[ -x "$(command -v lsd)" ]]; then
		alias ls='lsd -AF --group-dirs first'
		alias ll='lsd --almost-all --header --long --group-dirs first'
		alias labc='lsd -lAv --header'
		alias lx='lsd -lAXh --header'
		alias lk='lsd -lASrh --header'
		alias lt='lsd -lAtrh --header'
		alias lc='\ls -lAcrh --color=always --header'
		alias lu='\ls -lAurh --color=always --header'
		alias new='lsd -lAtr --almost-all | tail -10 | tac'
		alias lw='\ls -xAh --color=always'
		alias lm='\ls -Alh --color=always | \less -S'
		alias lr='lsd -lRh'
		alias l.='lsd -d .*'
		alias lfile="lsd -lA | egrep -v '^d'"
		alias ldir="\ls -lA --color=always | egrep '^d'"
		alias ltree='\lsd --almost-all --blocks permission,user,size,date,name --group-dirs first --header --long --tree'

	# If Natls is installed, use it instead
	# Link: https://github.com/willdoescode/nat
	# Install: cargo install natls
	elif [[ -x "$(command -v natls)" ]]; then
		alias ls='natls --gdf --name'
		alias ll='natls --gdf --name --long'
		alias labc='natls --name'
		alias lx='\ls -FlsaXBh --color=auto'
		alias lk='natls --gdf --long --size'
		alias lt='natls --gdf --long --modified'
		alias lc='\ls -Flsacrh --color=auto'
		alias lu='\ls -Flsaurh --color=auto'
		alias new='\ls -latr | tail -10 | tac'
		alias lw='\ls -xAh --color=auto'
		alias lm='natls --gdf --name --long | \less -S'
		alias lr='\ls -lRh --color=auto'
		alias l.='\ls -Flsd .* --color=auto'
		alias lfile="\ls -l | egrep -v '^d'"
		alias ldir="\ls -la | egrep '^d'"
		alias ltree='\tree -CAhF --dirsfirst'

	# Use ls with command line options
	else
		alias ls='ls -aFh --color=always --group-directories-first'
		alias labc='ls -lap'                  # sort alphabetically
		alias lx='ll -laXBh'                  # sort by extension
		alias lk='ll -laSrh'                  # sort by size
		alias lt='ll -latrh'                  # sort by date
		alias lc='ll -lacrh'                  # sort by change time
		alias lu='ll -laurh'                  # sort by access time
		alias new='ls -latr | tail -10 | tac' # list recently created/updated files
		alias lw='ls -xAh'                    # wide listing format
		alias lm='ll -alh | \less -S'         # pipe through less
		alias lr='ls -lRh'                    # recursive ls
		alias l.='ll -d .* --color=auto'      # show hidden files
		alias lfile="ls -l | egrep -v '^d'"   # files only
		alias ldir="ls -la | egrep '^d'"      # directories only
		alias ltree='\tree -CAhF --dirsfirst' # tree view

		if [[ $_SKIP_GRC = false ]] && [[ -x "$(command -v grc)" ]]; then
			# If grc Generic Colouriser is installed
			# Link: https://github.com/garabik/grc
			alias ll='grc ls -l --all --classify --group-directories-first --human-readable --color=always'
		else
			# Use standard long listing format
			alias ll='llcolor'
		fi
	fi
else
	alias ls='ls -aFh --color=always'     # do add built-in colors to file types
	alias ll='ls -Fls'                    # long listing
	alias labc='ls -lap'                  # sort alphabetically
	alias lx='ll -laXBh'                  # sort by extension
	alias lk='ll -laSrh'                  # sort by size
	alias lt='ll -latrh'                  # sort by date
	alias lc='ll -lacrh'                  # sort by change time
	alias lu='ll -laurh'                  # sort by access time
	alias new='ls -latr | tail -10 | tac' # list recently created/updated files
	alias lw='ls -xAh'                    # wide listing format
	alias lm='ll -alh | \less -S'         # pipe through less
	alias lr='ls -lRh'                    # recursive ls
	alias l.='ll -d .*'                   # show hidden files
	alias lfile="ls -l | egrep -v '^d'"   # files only
	alias ldir="ls -la | egrep '^d'"      # directories only
fi

# List all files larger than a given size
# llfs +10k will find and display all files larger than 10 kilobytes in the currect directory
alias llfs='_f(){ find . -type f -size "$1" -exec ls --color --classify --human-readable -l {} \; ; }; _f'

# Show colors with the dir command
if [[ -x "$(command -v dir)" ]]; then
	alias dir='dir --color=auto  --almost-all --human-readable --group-directories-first -F'
	alias vdir='vdir --color=auto'
fi

# pwd also sends the path to the clipboard
# (xsel is slower than xclip so we'll look for xclip first)
# Link: https://ostechnix.com/access-clipboard-contents-using-xclip-and-xsel-in-linux/
if [[ -x "$(command -v xclip)" ]]; then

	# Copy a file's contents to the clipboard
	alias file2cb='xclip -sel clip <'

	# Save the clipboard contents to a file
	alias cb2file='xclip -o >'

	# Dump the clipboard contents to the console
	alias cbshow='xclip -o'

	# Clear/delete the clipboard contents
	alias cbclear='xclip -i /dev/null'

	# Pipe in/out of the clipboard
	# Usage: someapp | clipboard  # Pipe someapp's output into clipboard
	#        clipboard | someapp  # Pipe clipboard's content into someapp
	# Example: cat file | clipboard
	# Example: clipboard | less
	clipboard() {
		if [[ -p /dev/stdin ]] ; then
			# stdin is a pipe
			# stdin -> clipboard
			xclip -i -selection clipboard
		else
			# stdin is not a pipe
			# clipboard -> stdout
			xclip -o -selection clipboard
		fi
	}

elif [[ -x "$(command -v xsel)" ]]; then

	# Copy a file's contents to the clipboard
	alias file2cb='xsel -b <'

	# Save the clipboard contents to a file
	alias cb2file='xsel -ob >'

	# Dump the clipboard contents to the console
	alias cbshow='xsel -ob'

	# Clear/delete the clipboard contents
	alias cbclear='xsel -cb'

	# Pipe in/out of the clipboard
	clipboard() {
		if [[ -p /dev/stdin ]] ; then
			xsel -ib
		else
			xsel -ob
		fi
	}
fi

# When using the pwd command, copy the directory to the clipboard
alias pwd='_pwd_clipboard'
function _pwd_clipboard() {
	# Run the real pwd command and capture it's output
	_PWD_OUTPUT="$(\pwd $@)"
	echo "${_PWD_OUTPUT}"

	# If we are not in the enhancd program folder...
	if [[ "${PWD}" != *"/enhancd" ]]; then

		# If xclip is installed...
		if [[ -x "$(command -v xclip)" ]]; then
			echo -n "${_PWD_OUTPUT}" | xclip -selection clipboard 2> /dev/null

		# Or if xsel is installed...
		elif [[ -x "$(command -v xsel)" ]]; then
			echo -n "${_PWD_OUTPUT}" | xsel -ib 2> /dev/null
		fi

		# If Tmux is running...
		if [[ -n "$TMUX" ]]; then
			# Add to the tmux clipboard
			echo -n "${_PWD_OUTPUT}" | tmux loadb - 2> /dev/null
		fi
	fi
}

# Show the previous path
alias pwd-='echo ${OLDPWD}'

# Show full path of file or wildcard
alias fullpath='find "`pwd`" -name'

# List the PATH environment variable directories
alias path='echo -e ${PATH//:/\\n}'

# When changing a directory, don't show an extra line with the directory
# Link: https://askubuntu.com/questions/1316485/how-do-i-stop-cd-command-from-printing-absolute-path-everytime
if [[ $_SILENCE_CD_OUTPUT = true ]]; then
	alias cd='>/dev/null cd'
fi

# Change to the home directory
alias home='\cd ~'

# Allow changing directory when missing a space
alias cd..='\cd ..'

# Allow changing directory back when missing a space
alias cd-='cd -'

# Go back directories dot style
alias ..='\cd ..'
alias ...='\cd ../..'
alias ....='\cd ../../..'
alias .....='\cd ../../../..'

# Go back directories dot dot number style
alias ..2='..; ..'
alias ..3='..2; ..'
alias ..4='..3; ..'
alias ..5='..4; ..'

#######################################################
### FIND FILES OR FILE INFORMATION
#######################################################

# Searches for filenames (can use wildcards)
if [[ -x "$(command -v fdfind)" ]]; then
	# Use fdfind if installed
	# Link: https://github.com/sharkdp/fd
	alias f='fdfind'
elif [[ -x "$(command -v fd)" ]]; then
	# Use the shorter fd command
	alias f='fd'
else
	alias f='find . -type f -iname'
fi

# Searches for directories (can use wildcards)
# Example: finddir config
# Example: finddir "This has spaces"
alias finddir='find . -type d -iname'

# Recursively find all files modified in the last 24 hours (current directory)
alias find24='find . -mtime -1 -ls'

# Find all the symlinks containing search text (i.e. "/backup")
alias findlinks="find . -type l -printf '%p -> ' -exec readlink -f {} ';' | grep"

# To count how many files are in your current file system location:
alias countfiles='find . -type f | wc -l'

# Show logs in color
if [[ -x "$(command -v multitail)" ]]; then
	alias multitail='multitail -c'
fi

# Show all logs in /var/log
alias logs="find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

# To see if a command is aliased, a file, or a built-in command
alias check="type -t"

# If the mlocate package is installed
if [[ -x "$(command -v locate)" ]]; then
	# Case insensitive search and display only files present in your system
	alias locate='locate -i -e'

	# Update the locate database before locating a file
	alias ulocate='sudo updatedb && locate'

	# Always update the locate (mlocate) database as root
	alias updatedb='sudo updatedb'

	# Display the number of matching entries
	alias locount='locate -c'
fi

#######################################################
### FILE MANAGEMENT
#######################################################

# Safety net for changing permisions on /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Alias to make a file executable
# A combination of the letters ugoa controls which users' access to the
# file will be changed: the user who owns it (u), other users in the
# file's group (g), other users not in the file's group (o), or all users
# (a). If none of these are given, the effect is as if (a) were given,
# but bits that are set in the umask are not affected.
alias mx='chmod a+x'

# Make parent directories as needed
alias mkdir='mkdir -p'
alias md=mkdir

# When copying files, prompt before overwriting a file
alias cp='cp -i'

# When moving files, prompt for confirmation if the destination path exists
# Use -f if you want to skip all prompts (-i option is ignored)
alias mv='mv -i'

# Prompt whether to remove destinations
alias ln='ln -i'

# Prompt before every removal
alias rm='rm -I --preserve-root'

# Remove a directory and all files
alias rmd='\rm --recursive --force --verbose'

# When shredding files, shred no matter permissions and remove the file(s)
alias shred='shred --force --remove --verbose'

# Type any text into a file
alias typefile='echo "Press CTRL-d when done:" && echo "$(</dev/stdin)" >'

# ExifTool removes embedded Exif data (like location) from images, videos, and docs
# https://exiftool.org/
# https://linuxhandbook.com/remove-exif-data/
if [[ -x "$(command -v exiftool)" ]]; then
	alias cleanmeta='exiftool -overwrite_original -all='
fi

# Make mount command output pretty and human readable format
alias mount='mount | column -t'
alias m='mount'
alias um='umount'

# Your Linux system's filesystem table (or fstab) is a configuration table
# designed to automate mounting and unmounting file systems to a machine
# WARNING: Modifications to this file can make your system unbootable!
alias fstab='sudo cp /etc/fstab /etc/fstab.backup; sudoedit /etc/fstab'

# Display disk space available and show file system type
alias df='df --human-readable --print-type --exclude-type=squashfs'
alias ds='df --human-readable --print-type --exclude-type=squashfs --exclude-type=tmpfs --exclude-type=devtmpfs'

# Get the block size for a partition
# Example: blocksize /dev/sda
alias blocksize='sudo blockdev --getbsz'

# dua parallel disk space analyzer in interactive mode TUI/GUI (in color)
# Link: https://github.com/Byron/dua-cli
# Install: curl -LSfs https://raw.githubusercontent.com/byron/dua-cli/master/ci/install.sh | \sh -s -- --git byron/dua-cli --target x86_64-unknown-linux-musl --crate dua
if [[ -f "$HOME/.cargo/bin/dua" ]]; then
	alias diskspace="$HOME/.cargo/bin/dua i"
elif [[ -x "$(command -v dua)" ]]; then
	alias diskspace='dua i'
# gdu fast parallel disk usage analyzer written in Go
# Link: https://github.com/dundee/gdu
# Install: go install github.com/dundee/gdu/v5/cmd/gdu@latest
elif [[ -x "$(command -v gdu)" ]]; then
	alias diskspace='gdu'
# Ncdu is a disk usage analyzer with an ncurses interface
# Link: https://dev.yorhel.nl/ncdu
elif [[ -x "$(command -v ncdu)" ]]; then
	alias diskspace='ncdu'
# Dust is like du written in Rust and more intuitive
# Link: https://github.com/bootandy/dust
elif [[ -x "$(command -v dust)" ]]; then
	alias diskspace='dust -xd1'
# List all folders disk space sorted by largest space
else
	alias diskspace='du -S | sort -n -r | more'
fi

# Just show the size of the current folder or a specified folder
alias totalsize='du -sh'

# List disk space of immediate folders one level deep
alias folders='du -kh --max-depth=1'

# f3 - test and check real capacity for USB devices (backup your drive first)
# Link: https://github.com/AltraMayor/f3
# Link: https://www.linuxbabe.com/command-line/f3-usb-capacity-fake-usb-test-linux
if [[ -x "$(command -v f3probe)" ]]; then
	alias usbtest='sudo f3probe --destructive --time-ops'
fi

# Alias to show MySQL's data directory location
if [[ -x "$(command -v mysqld)" ]]; then
	alias mysqldatadir='mysqld --verbose --help 2>/dev/null | grep ^datadir | column --table'
fi

# Aliases for archives
alias mkbz2='tar -cvjf'
alias unbz2='tar -xvjf'
alias mkgz='tar -cvzf'
alias ungz='tar -xvzf'
alias mktar='tar -cvf'
alias untar='tar -xvf'

# Alias to launch a document, file, or URL in it's default X application
if [[ -x "$(command -v xdg-open)" ]]; then
	alias open='runfree xdg-open'
fi

# Alias to fuzzy find files in the current folder(s), preview them, and launch in an editor
if [[ -x "$(command -v fzf)" ]]; then
	if [[ -x "$(command -v xdg-open)" ]]; then
		alias preview='open $(fzf --info=inline --query="${@}" --preview="$PAGER {}")'
	else
		alias preview='edit $(fzf --info=inline --query="${@}" --preview="$PAGER {}")'
	fi
fi

# Alias for Midnight Commander (mc) to exit into current directory
# https://stackoverflow.com/questions/39017391/how-to-make-midnight-commander-exit-to-its-current-directory
if [[ -f "/usr/lib/mc/mc-wrapper.sh" ]]; then
	alias mc='source /usr/lib/mc/mc-wrapper.sh'
fi

# Check shell script syntax
if [[ -x "$(command -v shellcheck)" ]]; then
	alias schk='shellcheck'
fi

#######################################################
### DATE AND TIME
#######################################################

# Show the time
alias now='date +"%T"'

# Show the short date
alias today='date +"%Y-%m-%d"'

# Stop watch
alias stopwatch='date && echo "Press CTRL-D to stop" && time read'

# Countdown timer and stop watch
# Link: https://github.com/trehn/termdown
# Fonts: banner3, big, computer, doh, letters, roman, small, standard, univers
# Link: http://www.figlet.org/examples.html
if [[ -x "$(command -v termdown)" ]]; then
	alias termdown='termdown --blink --end --critical 10 --font doh'
	alias countdown="termdown --help | sed -n '/Options\:/q;p'"
	alias timer='termdown'
	alias clock='termdown --time'
fi

# Change a file's (or files using a wildcard) accessed and modified time to now
# NOTE: There is no file creation date in Unix, only access, modify, and change
alias filetimenow='touch -a -m'

#######################################################
### CPU, MEMORY, AND PROCESSES
#######################################################

# Display amount of free and used memory
alias free='free -h'

# When reporting a snapshot of the current processes:
# a = all users
# u = user-oriented format providing detailed information
# x = list the processes without a controlling terminal
# f = display a tree view of parent to child processes
alias ps='ps auxf'

# Show top ten processes
alias cpu='ps aux | sort -r -nk +4 | head | $PAGER'

# Show CPU information
alias cpuinfo='lscpu | $PAGER'

# Show the USB device tree
if [[ -x "$(command -v lsusb)" ]]; then
	alias usb='lsusb -t'
fi

# Show the PCI device tree
if [[ -x "$(command -v lspci)" ]]; then
	alias pci='lspci -tv'
fi

# Alias top
# Link: https://ostechnix.com/some-alternatives-to-top-command-line-utility-you-might-want-to-know/
# Link: https://www.linuxlinks.com/alternativestotop/
if [[ -x "$(command -v btop)" ]]; then
	alias top='btop'
elif [[ -x "$(command -v bpytop)" ]]; then
	alias top='bpytop'
elif [[ -x "$(command -v bashtop)" ]]; then
	alias top='bashtop'
elif [[ -x "$(command -v nmon)" ]]; then
	alias top='nmon'
elif [[ -x "$(command -v glances)" ]]; then
	alias top='glances'
elif [[ -x "$(command -v ytop)" ]]; then
	alias top='ytop'
elif [[ -x "$(command -v gtop)" ]]; then
	alias top='gtop'
elif [[ -x "$(command -v htop)" ]]; then
	alias top='htop'
fi

# Alias bottom
# Link: https://github.com/ClementTsang/bottom
if [[ -x "$(command -v btm)" ]]; then
	alias bottom='btm'
fi

# Show jobs
alias j='jobs -l'

# Change the cursor to a crosshair to select a window (requires xprop)
if [[ -x "$(command -v xprop)" ]]; then
	alias windowinfo='xprop'
fi

# Get active X-window process ID after a 3 second delay (requires xdotool)
if [[ -x "$(command -v xdotool)" ]]; then
	alias activewinpid='sleep 3 && xdotool getactivewindow getwindowpid'
fi

# Alias to clear RAM memory cache, buffer and swap space
# Link: https://www.tecmint.com/clear-ram-memory-cache-buffer-and-swap-space-on-linux/
alias flushcache="sudo free -h && sudo su -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n\033[1;33m%s\033[0m\n\n' 'Ram-cache and Swap Cleared'\" root&& free -h"

#######################################################
### NETWORKING
#######################################################

# yt-dlp fork of youtube-dl - Set the default download folder
# Link: https://github.com/yt-dlp/yt-dlp
if [[ -x "$(command -v yt-dlp)" ]]; then
	alias yt-dlp='yt-dlp --paths ~/Desktop/'
	alias ytd='yt-dlp'
# Youtube-dl - Use best settings
# Link: https://github.com/ytdl-org/youtube-dl
elif [[ -x "$(command -v youtube-dl)" ]]; then
	alias youtube-dl="youtube-dl --format 'best[vcodec*=avc]'"
	alias ytd='youtube-dl'
fi

# Resume wget by default
if [[ -x "$(command -v wget)" ]]; then
	alias wget='wget -c'
fi

# aria2 is a lightweight multi-protocol & multi-source command-line download utility
# It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink with multiple connections
# Link: https://aria2.github.io/
if [[ -x "$(command -v aria2c)" ]]; then
	alias {aria2c,download}='aria2c --max-connection-per-server=10 --continue=true --async-dns=false'
elif [[ -x "$(command -v wget)" ]]; then
	alias download='wget -c'
elif [[ -x "$(command -v curl)" ]]; then
	alias download='curl -L'
fi

# Stop pinging after sending 5 ECHO_REQUEST packets
alias ping='ping -c 5'

# Do not wait for ping interval 1 second, go fast
alias fastping='ping -c 100 -i.2'

# Show open ports
alias ports='netstat -tulanp'

# Display and monitor the disk IO usage
# Link: https://www.geeksforgeeks.org/iotop-command-in-linux-with-examples/
if [[ -x "$(command -v iotop)" ]]; then
	alias iotop='sudo iotop -o -a'
fi

# If nmap is installed, set an alias for a network scan of a host (takes a while)
# Scan delay slows things down but reduces throttling, anti-ddos, auto-block
# Link: https://nmap.org/
# Example: netscan localhost
if [[ -x "$(command -v nmap)" ]]; then
	alias netscan='sudo nmap --scan-delay 1.1s -v --resolve-all -A -sTUV'
fi

# Get local IP addresses
if [[ -x "$(command -v ip)" ]]; then
	alias iplocal="ip -br -c a"
else
	alias iplocal="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
fi

# Get public IP address (several options below)
alias ipexternal='wget -O - -q icanhazip.com && echo'
# alias ipexternal='wget -qO- ifconfig.me/ip && echo'
# alias ipexternal='curl ipinfo.io/ip && echo'

# Add an "alert" alias for long running commands
# Example: echo "This is an alert" | alert
# Link: https://askubuntu.com/questions/423646/use-of-default-alias-alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Make it easy to disable and reenable the Teamviewer service
# so that it's not constantly running and only when you need it
if [[ -x "$(command -v teamviewer)" ]]; then
	alias teamviewerstart='sudo teamviewer --daemon start'
	alias teamviewerstop='sudo teamviewer --daemon stop'
fi

#######################################################
### VISUAL
#######################################################

# Colorize the grep command output for ease of use (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Colorize messages for the kernel ring buffer
alias dmesg='dmesg --color'

# Clear the screen with both clear and cls shorthand
alias cls='clear'

# Search and play YouTube videos in the terminal
if [[ -x "$(command -v ytfzf)" ]]; then
	alias yt='ytfzf -l -t'
fi

# Convert images to ASCII in color
if [[ -x "$(command -v jp2a)" ]]; then
	alias jp2a='jp2a --color'
fi

# List fonts for toilet
if [[ -x "$(command -v toilet)" ]]; then
	alias toiletfont='ls /usr/share/figlet'
	alias toiletfontlist='for file in /usr/share/figlet/*.?lf; do toilet -f $(basename "$file") $(basename "$file"); done'
fi

# Launch the cmatrix screen saver (if installed)
if [[ -x "$(command -v cmatrix)" ]]; then
	alias matrix='cmatrix -b'
fi

#######################################################
### MISCELLANEOUS
#######################################################

# Alias to show the current TTY (CTRL-ALT-1 through 7)
alias whichtty='tty | sed -e "s:/dev/::"'

# Spell check a word with DidYouMean
# Link: https://github.com/hisbaan/didyoumean
if [[ -x "$(command -v dym)" ]]; then
	alias spell='dym -n 10 -y'
fi

# Alias's for safe and forced reboots
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# Update the fireware on Linux automatically and safely using fwupdmgr
# (used by companies like Corsair, Dell, HP, Intel, Logitech, etc.)
# Install: pkginstall fwupdmgr
# Link: https://fwupd.org
if [[ -x "$(command -v fwupdmgr)" ]]; then
	alias firmwareupdate='fwupdmgr get-devices && fwupdmgr refresh && fwupdmgr get-updates && fwupdmgr update'
fi

# When updating virus definitions, do it as root
if [[ -x "$(command -v freshclam)" ]]; then
	alias freshclam='sudo freshclam'
fi

# Check passwords with cracklib
# Link: https://www.cyberciti.biz/security/linux-password-strength-checker/
if [[ -x "$(command -v cracklib-check)" ]]; then
	alias pwcheck='cracklib-check<<<'
fi

# Glow is one of the best CLI markdown viewers with pager support
# Link: https://github.com/charmbracelet/glow
if [[ -x "$(command -v glow)" ]]; then
	alias glow='glow --all --pager'

	# Use --local if you want to load markdown without internet files or images
	alias glowsafe='glow --all --pager --local'

	# Show the Extreme Ultimate .bashrc README file
	if [[ -f "$HOME/.config/bashrc/README.md" ]]; then
		alias readme='glow ~/.config/bashrc/README.md'
	elif [[ -f "$HOME/README.md" ]]; then
		alias readme='glow ~/README.md'
	fi
fi

# fx is a JavaScript Object Notation (JSON) viewer
# Link: https://github.com/antonmedv/fx
if [[ -x "$(command -v fx)" ]]; then
	alias json='fx'

# jless is a command-line JSON viewer
# Link: https://jless.io/
elif [[ -x "$(command -v jless)" ]]; then
	alias json='jless'

# jq - Pretty Print JSON Files in the terminal
# Link: https://itsfoss.com/pretty-print-json-linux/
elif [[ -x "$(command -v jq)" ]]; then
	alias json='jq'
fi

# baca TUI ebook reader
# Link: https://github.com/wustho/baca
# Install: pip install baca
if [[ -x "$(command -v baca)" ]]; then
	alias ebook=baca
fi

# Speak with female voice
# Link: https://thomashunter.name/posts/2012-05-21-female-voice-using-espeak
if [[ -x "$(command -v espeak)" ]]; then
	alias say='espeak -ven-us+f4 -s170'
fi

# Aliases to modify GRUB
# https://www.howtogeek.com/196655/how-to-configure-the-grub2-boot-loaders-settings/
alias grubedit='sudoedit /etc/default/grub'
alias grubsave='sudo update-grub'

# Aliases for BtrFS file systems
if [[ -x "$(command -v btrfs)" ]]; then
	alias btrcheck='sudo btrfs fi show'                        # Check status of raid drives
	alias btrstats='sudo btrfs device stats'                   # Show device statistics
	alias btrscrub='sudo btrfs scrub start'                    # Start a scrub
	alias btrpause='sudo btrfs scrub cancel'                   # Cancel or pause a scrub
	alias btrresume='sudo btrfs scrub resume'                  # Resume a paused scrub
	alias btrstatus='sudo btrfs scrub status'                  # Show status of a scrub
	alias btrdefragfile='sudo btrfs filesystem defragment -vf' # Defrag a file
	alias btrdefragdir='sudo btrfs filesystem defragment -rvf' # Defrag a directory
fi

# Shows all the script files in a directory and which shell they require
alias scanscripts='for FILE in *; do [[ -f "$FILE" ]] && echo -n "$FILE - " && head -n 1 $FILE; done | grep "\#\!" 2> /dev/null'

# Vlock - lock all terminals
# Install: sudo apt install vlock
# Install: sudo pacman -S kbd
# https://odysee.com/@DistroTube:2/lock-your-terminal-sessions-with-vlock:0
if [[ -x "$(command -v vlock)" ]]; then
	# Alias Vlock to lock all terminals and can be typed with one hand
	alias lok='vlock --all'
fi

# Alias thefuck that corrects errors in previous console commands
# Link: https://github.com/nvbn/thefuck
if [[ -x "$(command -v thefuck)" ]]; then
	eval $(thefuck --alias fix)
fi

# If Distrobox is installed...
# Link: https://github.com/89luca89/distrobox
# Link: https://github.com/89luca89/distrobox/blob/main/docs/usage/usage.md
if [[ -x "$(command -v distrobox)" ]]; then
	# Create aliases for the most common commands
	alias db='distrobox'
	alias {dbe,distrobox-enter}='_distrobox-enter'
	alias dbl='distrobox list'
	alias dbls='distrobox-list-simple'
	alias dbs='distrobox stop'
	alias dbsa='distrobox-stop-all'
	alias dbhe='distrobox-host-exec'
	alias {dbup,distrobox-upgrade}='_distrobox-upgrade'
	alias {dbc,distrobox-check}='docker system df -v'

	# List only the names of each container
	# This takes no arguments and will mostly be used in scripts
	function distrobox-list-simple() {
		distrobox-list | awk -F '|' '{print $2}' | tail -n +2 | sed 's/^[ \t]*//;s/[ \t]*$//'
	}

	# Choose an installed container
	# This takes no arguments and will mostly be used in scripts
	function distrobox-pick() {
		distrobox-list-simple | createmenu
	}

	# Loop through and stop all containers
	function distrobox-stop-all() {
		local _BOX_LIST="$(distrobox-list-simple)"
		for _BOX in $_BOX_LIST; do
			\distrobox stop --yes $_BOX
		done
	}

	function _distrobox-enter() {
		if [ $# -eq 0 ]; then
			\distrobox enter "$(distrobox-pick)"
		else
			\distrobox enter "$@"
		fi
	}

	function _distrobox-upgrade() {
		if [ $# -eq 0 ]; then
			\distrobox upgrade --all
		else
			\distrobox upgrade "$@"
		fi
	}
fi

# Alias to restart KDE Plasma desktop without rebooting or logging out
if [[ -x "$(command -v kstart5)" ]] && [[ -x "$(command -v kquitapp5)" ]]; then
	alias {plasmarestart,kderestart}='kquitapp5 plasmashell && runfree kstart5 plasmashell'
fi

#######################################################
# Tmux Terminal Multiplexor Support
# Link: https://github.com/tmux/tmux/wiki
#######################################################

# Aliases for tmux terminal multiplexer if installed
if [[ -x "$(command -v tmux)" ]]; then

	# If you connect to a session with a different resolution terminal:
	#tmux resize-window -A &> /dev/null

	# Function to load TMUX with default session defined by _TMUX_LOAD_SESSION_NAME
	# If TMUX is already running, switch to a session name passed in as a parameter
	# TIP: Use CTRL-d to detach your session which closes but leaves the session
	# running. CTRL-d will also exit bash once outside of TMUX.
	# alias tm='tmux a -t main || tmux new -s main'
	function tm() {

		# Get the passed in or default session name
		if [[ -n "${@}" ]]; then
			local SESSION_NAME="${@}"
		elif [[ -n "${_TMUX_LOAD_SESSION_NAME}" ]]; then
			local SESSION_NAME="${_TMUX_LOAD_SESSION_NAME}"
		elif [[ "$(tmux list-sessions 2> /dev/null | wc -l)" -gt 0 ]]; then
			local SESSION_NAME="$(tmux ls -F "#{session_name}" | createmenu)"
		else
			local SESSION_NAME="$(whoami)"
		fi

		# Create the session if it doesn't exist
		TMUX='' tmux -u new-session -d -s "${SESSION_NAME}" 2> /dev/null

		# Attach if outside of TMUX
		if [[ -z "$TMUX" ]]; then
			tmux -u attach -t "${SESSION_NAME}" 2> /dev/null && exit

		# Switch if we are already inside of TMUX
		else
			tmux -u switch-client -t "${SESSION_NAME}" 2> /dev/null
		fi
	}

	function tmsessiongroup() {
		# Tmux allows you to create "session groups" - multiple sessions that can all attach to the same set of windows
		# (Allow multiple monitors to attach to the same session but independently view separate panes)
		# Link: https://unix.stackexchange.com/questions/282365/using-multiple-terminal-x-windows-with-one-tmux-session
		# To switch from one to the other using xdotool:
		# xdotool search --name 'session1:0:' windowactivate
		# xdotool search --name 'session2:1:' windowactivate

		# Get a list of sessions
		local _TMUX_OPEN_SESSIONS="$(tmux ls -F "#{session_name}" 2> /dev/null)"

		# If the chosen session is blank
		if [ -z "${_TMUX_OPEN_SESSIONS}" ]; then
			# Show an error and exit
			echo -e "\033[1;31mERROR:\033[1;37m No session found\033[0m"
			return 1
		fi

		# If a new session name was not passed in...
		if [ $# -eq 0 ]; then
			# Get the name of the last session
			local _TMUX_LAST_SESSION=$(echo "${_TMUX_OPEN_SESSIONS}" | head -n 1)

			# Generate a new session name based on the last session
			local _COUNTER=2
			local _TMUX_RANDOM_NAME
			while [ -z "${_TMUX_RANDOM_NAME}" ]; do
				if [[ "${_TMUX_OPEN_SESSIONS}" =~ "${_TMUX_LAST_SESSION}${_COUNTER}" ]]; then
					let _COUNTER=_COUNTER+1
				else
					_TMUX_RANDOM_NAME="${_TMUX_LAST_SESSION}${_COUNTER}"
				fi
			done

			# Ask for the new session name from a menu
			read -e -i "${_TMUX_RANDOM_NAME}" -p "New Session Name: " _TMUX_NEW_SESSION
		else
			# Use the passed in session name
			local _TMUX_NEW_SESSION="${@}"
		fi

		# Make sure the new session name doesn't already exist
		if [[ "${_TMUX_OPEN_SESSIONS}" =~ "${_TMUX_NEW_SESSION}" ]]; then
			# Show an error and exit
			echo -e "\033[1;31mERROR:\033[1;37m Session \033[1;36m${_TMUX_NEW_SESSION}\033[1;37m already exists\033[0m"
			return 1
		fi

		# If the chosen session is blank
		if [ -z ${_TMUX_NEW_SESSION} ]; then
			# Show an error and exit
			echo -e "\033[1;31mERROR:\033[1;37m You must specify a new session name\033[0m"
			return 1
		fi

		# Change the prompt
		_PS3_OLD="${PS3}"
		PS3="Choose an existing session to connect to: "

		# Ask for the session to connect to
		local _TMUX_EXISTING_SESSION=$(echo "${_TMUX_OPEN_SESSIONS}" | sort | createmenu)

		# Put the settings back to their original values
		PS3="${_PS3_OLD}"
		IFS="${_IFS_OLD}"

		# If the chosen session is blank
		if [ -z ${_TMUX_EXISTING_SESSION} ]; then
			# Show an error and exit
			echo -e "\033[1;31mERROR:\033[1;37m You must specify an existing session\033[0m"
			return 1
		fi

		# Create a session group
		if ($(tmux -u new-session -t "${_TMUX_EXISTING_SESSION}" -s "${_TMUX_NEW_SESSION}")); then
			return 0
		else
			# Show an error and exit
			echo -e "\033[1;31mERROR:\033[1;37m Could not connect to session \033[1;36m${_TMUX_EXISTING_SESSION}\033[0m"
			return 1
		fi
	}

	# Detach from Tmux - and optionally run a command if specified
	# For example, detach and log into an SSH server already running Tmux
	# so you don't run a Tmux session inside of your local Tmux session
	# Example: tmd ssh username@server.net
	function tmd() {
		# If Tmux is running...
		if [[ -n "$TMUX" ]]; then
			# If no parameters were pass in...
			if [ $# -eq 0 ]; then
				# Detach from the session
				tmux detach
			else
				# Detach and then execute the parameters
				eval "tmux detach -E '${@}'"
			fi

		# Tmux is NOT running so no need to detach...
		else
			# Only do something if a command is passed in...
			if [ $# -gt 0 ]; then
				# Run the command
				eval "${@}"
			fi
		fi
	}

	# List all the sessions
	alias tmlist='tmux ls'

	# List all the connected clients
	alias tmclients='tmux lsc'

	# Create a new session
	alias {tmnew,tmjoin}='tm'

	# Attach to an existing session
	#alias tmattach='tmux -u new-session -A -s'
	alias tmattach='tmux -u attach-session -t "$(tmux ls -F "#{session_name}" | createmenu)"'

	# Rename a session: tmrename [session] [new_name]
	alias tmrename='tmux rename -t'

	# Kill a session
	alias tmkill='tmux kill-session -t'

	# Kill all sessions
	alias tmreset='tmux kill-server'

# Tmux is not installed, but Zellij is and is very user friendly
elif [[ -x "$(command -v zellij)" ]]; then
	# Redirect these Tmux aliases to Zellij instead
	alias {tm,tmnew,tmjoin}='znew'
	alias tmlist='zlist'
	alias tmattach='zattach'
	alias tmkill='zkill'
	alias tmreset='zreset'

# Tmux is not installed, but Screen is
# Link: https://linuxize.com/post/how-to-use-linux-screen/
elif [[ -x "$(command -v screen)" ]]; then
	alias tm="echo 'Tmux is not installed, but screen is installed on this system.'"

fi

#######################################################
# Zellij Terminal Multiplexor Support
# Link: https://zellij.dev/documentation/introduction.html
#######################################################

# Aliases for Zellij terminal multiplexer if installed
if [[ -x "$(command -v zellij)" ]]; then

	# Function to load Zellij with a default session named the logged in user
	# You can also pass in a specific session name as a parameter
	function znew() {
		# Get the passed in or default session name
		if [[ -n "${@}" ]]; then
			local SESSION_NAME="${@}"
		elif [[ "$(zellij list-sessions 2> /dev/null | wc -l)" -gt 0 ]]; then
			local SESSION_NAME=""
		else
			local SESSION_NAME="$(whoami)"
		fi

		# Create the session if it doesn't exist
		zellij --session "${SESSION_NAME}" 2> /dev/null || zellij attach "${SESSION_NAME}"
	}

	# Aliases for Zellij
	alias {zj,zjoin}='znew'
	alias zlist='zellij list-sessions'
	alias zattach='zellij attach "$(zellij list-sessions | createmenu)"'
	alias zkill='zellij kill-session'
	alias zreset='zellij kill-all-sessions'

	# Include the bash completion and aliases from Zellij (i.e. zr, zrf, ze, zef)
	source <(zellij setup --generate-completion bash) >/dev/null 2>&1
fi

#######################################################
# Abduco lets programs run independently of the controlling terminal
# Note: CTRL+\ will detach the session
# Link: https://www.brain-dump.org/projects/abduco/
#######################################################

if [[ -x "$(command -v abduco)" ]]; then

	# Start or connect to an abduco session
	function aa() {
		if [[ ${#} -eq 0 ]]; then
			if [[ $(abduco | wc -l) -gt 1 ]]; then
				abduco -a "$(abduco | tail -n +2 | sed 's:\s\+:\t:g' | cut -f 5 | createmenu)" bash
			else
				abduco -c "${USER}" bash
			fi
		else
			abduco -A "${@}" bash
		fi
	}

	# Connect to an abduco session read-only
	function aaro() {
		abduco -Ar "${@}" bash
	}

	# List any abduco sessions
	alias aals='abduco'

	# Kill all abduco sessions
	alias aareset='pkill abduco'
fi

#######################################################
# Easy Cross-Platform Package Management Aliases
#######################################################

# Depending on the installed package managers, set up some package aliases
if [[ -x "$(command -v paru)" ]]; then # Arch
	# Link: https://github.com/Morganamilo/paru
	# Link: https://itsfoss.com/paru-aur-helper/
	# NOTE: To get search results to start at the bottom and go upwards, enable BottomUp in paru.conf
	alias has='paru -Si'
	alias pkgupdateall='paru -Syyu --sudoloop --noconfirm --newsonupgrade && if type flatpak >/dev/null 2>&1; then sudo flatpak update --assumeyes --noninteractive; fi && if type snap >/dev/null 2>&1; then sudo snap refresh; fi && if type tldr >/dev/null 2>&1; then tldr --update; fi'
	alias pkgupdate='paru --sync --sudoloop --noconfirm'
	alias pkginstall='paru --sync --sudoloop --noconfirm'
	alias pkgremove='paru --remove'
	alias pkgclean='paru --clean'
	alias pkgsearch='paru --bottomup'
	alias pkglist='paru -Qe'
	alias pkglistmore='paru -Q' # Also includes dependencies
elif [[ -x "$(command -v yay)" ]]; then # Arch
	# Link: https://github.com/Jguer/yay
	alias has='yay -Si'
	alias pkgupdateall='yay -Syyu --sudoloop && if type flatpak >/dev/null 2>&1; then sudo flatpak update; fi && if type snap >/dev/null 2>&1; then sudo snap refresh; fi && if type tldr >/dev/null 2>&1; then tldr --update; fi'
	alias pkgupdate='yay -S'
	alias pkginstall='yay -S'
	alias pkgremove='yay -Rns'
	alias pkgclean='yay -Yc'
	alias pkgsearch='yay'
	alias pkglist='yay -Qe'
	alias pkglistmore='yay -Q' # Also includes dependencies
elif [[ -x "$(command -v pamac)" ]]; then    # Manjaro
	# Link: https://wiki.manjaro.org/index.php/Pamac
	alias has='sudo pamac info'
	alias pkgupdateall='sudo pamac upgrade -a && if type tldr >/dev/null 2>&1; then tldr --update; fi'
	alias pkgupdate='sudo pamac update'
	alias pkginstall='sudo pamac install'
	alias pkgremove='sudo pamac remove'
	alias pkgclean='sudo pamac remove --orphans'
	alias pkgsearch='sudo pamac search -a'
	alias pkglist='pacman -Qe'
	alias pkglistmore='pacman -Q' # Also includes dependencies
elif [[ -x "$(command -v pacman)" ]] && [[ -n $(uname -r | grep arch) ]]; then # Arch (No AUR)
	# Link: https://archlinux.org/pacman/
	alias has='pacman -Q --info'
	alias pkgupdateall='sudo pacman -Syyu && if type flatpak >/dev/null 2>&1; then sudo flatpak update; fi && if type snap >/dev/null 2>&1; then sudo snap refresh; fi && if type tldr >/dev/null 2>&1; then tldr --update; fi'
	alias pkgupdate='sudo pacman -S'
	alias pkginstall='sudo pacman -S'
	alias pkgremove='sudo pacman -Rns'
	alias pkgclean='pacman -Qtdq | sudo pacman -Rns -'
	alias pkgsearch='pacman -Ss'
	alias pkglist='pacman -Qe'
	alias pkglistmore='pacman -Q' # Also includes dependencies
elif [[ -x "$(command -v dnf)" ]]; then # RedHat/Fedora
	# Link: https://fedoraproject.org/wiki/DNF
	alias has='dnf info'
	alias pkgupdateall='sudo dnf upgrade --refresh'
	alias pkgupdate='sudo dnf upgrade'
	alias pkginstall='sudo dnf install'
	alias pkgremove='sudo dnf remove'
	alias pkgclean='sudo dnf autoremove'
	alias pkgsearch='sudo dnf search'
	alias pkglist='dnf list installed'
	alias pkgdependencies='yum whatprovides'
elif [[ -x "$(command -v yum)" ]]; then # RedHat/Fedora
	# Link: https://access.redhat.com/articles/yum-cheat-sheet
	alias has='yum info'
	alias pkgupdateall='sudo yum clean all && yum -y update'
	alias pkgupdate='sudo yum update'
	alias pkginstall='sudo yum install'
	alias pkgremove='sudo yum remove'
	alias pkgclean='sudo yum autoremove'
	alias pkgsearch='sudo yum search'
	alias pkglist='yum list installed'
	alias pkgdependencies='yum whatprovides'
elif [[ -x "$(command -v nala)" ]]; then # Debian/Ubuntu/Raspbian
	# Link: https://gitlab.com/volian/nala
	# Link: https://itsfoss.com/nala/
	alias has='nala show'
	alias pkgupdateall='sudo nala update && sudo nala upgrade && if type pacstall >/dev/null 2>&1; then pacstall --upgrade; fi'
	alias pkgupdate='sudo nala update'
	alias pkginstall='sudo nala install --install-suggests'
	alias pkgremove='sudo nala remove'
	alias pkgclean='sudo nala clean --fix-broken'
	alias pkgsearch='sudo nala search'
	alias pkglist='sudo nala list --installed'
	alias pkgmirrors='sudo nala fetch'
elif [[ -x "$(command -v apt)" ]]; then # Debian/Ubuntu/Raspbian
	# Link: https://itsfoss.com/apt-command-guide/
	alias has='apt show'
	alias pkgupdateall='sudo apt update --assume-yes && sudo apt upgrade --assume-yes && if type pacstall >/dev/null 2>&1; then pacstall --upgrade; fi && if type tldr >/dev/null 2>&1; then tldr --update; fi'
	alias pkgupdate='sudo apt-get install --only-upgrade'
	alias pkginstall='sudo apt install'
	alias pkgremove='sudo apt remove'
	alias pkgclean='sudo apt autoremove'
	alias pkgsearch='sudo apt search'
	alias pkglist='sudo apt list --installed'
	alias pkgcheck='sudo apt update --assume-yes && apt list --upgradable'
elif [[ -x "$(command -v apt-get)" ]]; then # Debian/Ubuntu
	# Link: https://help.ubuntu.com/community/AptGet/Howto
	alias has='apt-cache show'
	alias pkgupdateall='sudo apt-get update && sudo apt-get upgrade && if type pacstall >/dev/null 2>&1; then pacstall --upgrade; fi && if type tldr >/dev/null 2>&1; then tldr --update; fi'
	alias pkgupdate='sudo apt-get install --only-upgrade'
	alias pkginstall='sudo apt-get install'
	alias pkgremove='sudo apt-get remove'
	alias pkgclean='sudo apt-get autoremove'
	alias pkgsearch='sudo apt-cache search'
	alias pkglist='sudo dpkg -l'
elif [[ -x "$(command -v zypper)" ]]; then # SUSE
	# Link: https://en.opensuse.org/SDB:Zypper_usage
	alias has='zypper info'
	alias pkgupdateall='sudo zypper patch'
	alias pkgupdate='sudo zypper up'
	alias pkginstall='sudo zypper in'
	alias pkgremove='sudo zypper rm'
	alias pkgclean='sudo zypper packages --orphaned'
	alias pkgsearch='sudo zypper se'
	alias pkglist='zypper se --installed-only'
elif [[ -x "$(command -v eopkg)" ]]; then # Solus
	# Link: https://getsol.us/articles/package-management/basics/en/
	alias has='sudo eopkg info'
	alias pkgupdateall='sudo eopkg upgrade'
	alias pkgupdate='sudo eopkg upgrade'
	alias pkginstall='sudo eopkg install'
	alias pkgremove='sudo eopkg remove'
	alias pkgsearch='sudo eopkg search'
	alias pkglist='eopkg li -l'
elif [[ -x "$(command -v emerge)" ]]; then # Gentoo (Portage)
	# Link: https://www.linode.com/docs/guides/portage-package-manager/
	alias has='equery files'
	alias pkgupdateall='sudo emerge --sync && sudo emerge --update --deep --with-bdeps=y --newuse @world && sudo emerge --depclean && sudo revdep-rebuild'
	alias pkgupdate='sudo emerge -u'
	alias pkginstall='sudo emerge'
	alias pkgremove='sudo emerge --depclean'
	alias pkgsearch='sudo emerge --search'
	alias pkglist='equery list "*"'
elif [[ -x "$(command -v slackpkg)" ]]; then # Slackware
	# Link: https://www.linux.com/training-tutorials/intro-slackware-package-management/
	alias has='slackpkg info'
	alias pkgupdateall='slackpkg update && slackpkg install-new && slackpkg upgrade-all'
	alias pkgupdate='upgradepkg'
	alias pkginstall='installpkg'
	alias pkgremove='removepkg'
	alias pkglist='pkgtool'
elif [[ -x "$(command -v urpmi)" ]]; then # Mandrake
	# Link: https://wiki.mageia.org/en/URPMI
	alias has='urpmq --summary -Y'
	alias pkgupdateall='urpmi --auto-update'
	alias pkgupdate='urpmi'
	alias pkginstall='urpmi'
	alias pkgremove='urpme'
	alias pkgsearch='urpmq --summary -Y'
	alias pkglist='rpm -qa'
elif [[ -x "$(command -v apt-cyg)" ]]; then # Cygwin
	# Link: http://stephenjungels.com/jungels.net/projects/apt-cyg/
	alias has='apt-cyg show'
	alias pkgupdateall='apt-cyg update'
	alias pkgupdate='apt-cyg update'
	alias pkginstall='apt-cyg install'
	alias pkgremove='apt-cyg remove'
	alias pkgsearch='apt-cyg find'
	alias pkglist='cygcheck --check-setup'
elif [[ -x "$(command -v brew)" ]]; then # macOS
	# Link: https://brew.sh/
	alias has='brew info'
	alias pkgupdateall='brew update'
	alias pkgupdate='brew update'
	alias pkginstall='brew install'
	alias pkgremove='brew uninstall'
	alias pkgclean='brew cleanup'
	alias pkgsearch='brew search'
	alias pkglist='brew list'
fi

# If this is an Arch based distrobution with pacman...
if [[ -x "$(command -v pacman)" ]] && [[ -n $(uname -r | grep arch) ]]; then

	# Install a list of packages with regex
	# https://wiki.archlinux.org/title/pacman#Installing_specific_packages
	function pkginstallregex() {
		if [ $# -eq 0 ]; then
			echo "No regex provided"
			exit 1
		else
			sudo pacman -S $(pacman -Ssq "${@}")
		fi
	}

	# To mark a package as explicitly installed or only a dependency
	alias pkgmarkasexplicit='sudo pacman -D --asexplicit'
	alias pkgmarkasdependency='sudo pacman -D --asdeps'

	# Check for default configuration file default backups
	alias pacnew='sudo true && echo "Pacman backup configuration files found:"; sudo find /etc -type f \( -iname \*.pacnew -o -iname \*.pacsave \) | sort -t"/" -k2.2r -k2.1'

	# Force remove a package ignoring required dependencies
	alias pkgforceremove='sudo pacman -Rd --nodeps'

	# Search for a package containing a file
	alias pkgsearchcontainingfile='sudo pacman -Fy'

	# List all the local files in an installed package
	alias pkglocalpackagefiles='pacman -Ql'

	# Verify the presence of the files installed by a package
	alias pkgverifylocalpackage='sudo pacman -Qkk'

	# Verify all packages
	# Link: https://unix.stackexchange.com/questions/659756/arch-linux-reinstall-all-broken-packages-after-poweroff-during-system-upgrade
	alias pkgverifyall="pacman -Qk 2>/dev/null | grep -v ' 0 missing files'"

	# Show the latest Arch linux update news
	alias archnews='w3m https://www.archlinux.org/ | sed -n "/Latest News/,/Older News/p" | "${PAGER}"'

	# Pacseek - browse and search through the Arch Linux package databases and AUR
	# Link: https://github.com/moson-mo/pacseek
	if [[ -x "$(command -v pacseek)" ]]; then
		alias pkg='pacseek'
	fi

	# If perl is installed (preset on most systems)...
	# Link: https://wiki.archlinux.org/title/Perl
	# Install: sudo pacman -S perl
	if [[ -x "$(command -v perl)" ]]; then

		# Use a much more detailed package listing with descriptions (AUR separated)
		# pkglist [search] will search for all installed packages instead
		unalias pkglist >/dev/null 2>/dev/null
		function pkglist() {
			if [ $# -eq 0 ]; then
				# In order to make this accurate, lets get a basic list of all the main repositories (minus the AUR) to check against
				repo="$(pacman -Sl core | awk '/\[.*[[:alpha:]]+]$/ {print $2}')\n$(pacman -Sl extra | awk '/\[.*[[:alpha:]]+]$/ {print $2}')\n$(pacman -Sl community | awk '/\[.*[[:alpha:]]+]$/ {print $2}')\n$(pacman -Sl multilib | awk '/\[.*[[:alpha:]]+]$/ {print $2}')\n"

				# If it's in the repo list, it's not the AUR
				echo -e "\033[1;34m=============== \033[1;33mNative Arch Packages\033[1;34m ===============\033[0m"
				for line in "$(pacman -Qqe | while read line; do if [[ $repo =~ $line ]]; then echo "$line"; fi; done)"; do \pacman -Qi $(echo "$line") ; done | perl -pe 's/ +/ /gm' | perl -pe 's/^(Groups +: )(.*)/$1($2)/gm' | perl -0777 -pe 's/^Name : (.*)\nVersion :(.*)\nDescription : ((?!None).*)?(?:.|\n)*?Groups :((?! \(None\)$)( )?.*)?(?:.|\n(?!Name))+/$1$4 - $3/gm' | grep -A1 --color -P "^[^\s]+"

				# If it's not in the repo list, it is from the AUR or Chaotic-AUR (or a custom repository)
				echo -e "\n\033[1;34m=============== \033[1;33mArch User Repository (AUR)\033[1;34m ===============\033[0m"
				for line in "$(pacman -Qqe | while read line; do if [[ ! $repo =~ $line ]]; then echo "$line"; fi; done)"; do \pacman -Qi $(echo "$line") ; done | perl -pe 's/ +/ /gm' | perl -pe 's/^(Groups +: )(.*)/$1($2)/gm' | perl -0777 -pe 's/^Name : (.*)\nVersion :(.*)\nDescription : ((?!None).*)?(?:.|\n)*?Groups :((?! \(None\)$)( )?.*)?(?:.|\n(?!Name))+/$1$4 - $3/gm' | grep -A1 --color -P "^[^\s]+"
			else
				# If a search parameter was specified, just grep the parameter and ignore which repo
				for line in "$(\pacman -Qqe)"; do \pacman -Qi $(echo "$line") ; done | perl -pe 's/ +/ /gm' | perl -pe 's/^(Groups +: )(.*)/$1($2)/gm' | perl -0777 -pe 's/^Name : (.*)\nVersion :(.*)\nDescription : ((?!None).*)?(?:.|\n)*?Groups :((?! \(None\)$)( )?.*)?(?:.|\n(?!Name))+/$1$4 - $3/gm' | grep -A1 --color -P "^[^\s]+" | grep "${@}"
			fi
		}
	fi

	# If pacman-contrib (contributed scripts and tools for pacman) is installed...
	# Install: sudo pacman -S pacman-contrib
	if [[ -x "$(command -v paccache)" ]]; then

		# Add aliases to find dependencies
		alias pkgdependencies='pactree --color' # --unique --depth 1
		alias pkgwhatuses='pactree --reverse --color'

		# The checkupdates script (also from Arch pacman-contrib)
		# NOTE: The benefit to this is it does NOT need SUDO/ROOT access
		alias pkgcheck='checkupdates | sort | \less --no-init --ignore-case --LONG-PROMPT --LINE-NUMBERS'

		# Alias to fix Arch Pacman install error "invalid or corrupted package" with a
		# new PGP key, clear anything older than the last 3 installs, and remove locks
		# Link: https://odysee.com/@DistroTube:2/solved-pacman-wouldn't-let-me-run-an:0
		alias pacmanfix='sudo rm -f /var/lib/pacman/db.lck && sudo paccache -r && sudo pacman -Sy archlinux-keyring'
		alias pacmanfixkeys='sudo rm -f /var/lib/pacman/db.lck; sudo rm -R /etc/pacman.d/gnupg/; sudo rm -R /root/.gnupg/; sudo gpg --refresh-keys && sudo pacman-key --init && sudo pacman-key --populate && sudo pacman -Sy archlinux-keyring'
	fi
fi

# If apt package manager is installed, add aliases to find dependencies in Ubuntu/Debian
if [[ -x "$(command -v apt-cache)" ]]; then
	alias pkgdependencies='apt-cache depends'
	# If apt-rdepends is installed (sudo apt install apt-rdepends)
	if [[ -x "$(command -v apt-rdepends)" ]]; then
		alias pkgwhatuses='apt-rdepends'
	fi
fi

# Aliases for flatpak packages if installed
if [[ -x "$(command -v flatpak)" ]]; then
	alias flatpakhas='flatpak info'
	alias flatpakupdateall='sudo flatpak update'
	alias flatpakupdate='sudo flatpak update'
	alias flatpakinstall='sudo flatpak install'
	alias flatpakremove='sudo flatpak uninstall'
	alias flatpakwipe='sudo flatpak uninstall --delete-data'
	alias flatpakclean='sudo flatpak repair && sudo flatpak uninstall --unused'
	alias flatpaksearch='flatpak search'
	alias flatpaklist='flatpak list --columns=name,app:f,version:e,description:e --app'
	alias flatpaksize='flatpak list --columns=app:f,name,size:f,installation:e'
	alias flatpakremotes='flatpak remotes --show-details'

	# Create missing or recreate broken Flatpak icons (might require restart)
	if [ -d "/var/lib/flatpak/exports/share/applications/" ]; then
		alias flatpakmakeicons='\cp /var/lib/flatpak/exports/share/applications/*.desktop ~/.local/share/applications/'
	else
		alias flatpakmakeicons='find /var/lib/flatpak/app/ -type f -iname "*.desktop" -exec cp {} ~/.local/share/applications \;'
	fi

	# Make sure the Flatpak environment variable (for icons) is correct
	XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
fi

# Aliases for snap packages if installed
if [[ -x "$(command -v snap)" ]]; then
	alias snaphas='snap info'
	alias snapupdateall='sudo snap refresh --list'
	alias snapupdate='sudo snap refresh'
	alias snapinstall='sudo snap install'
	alias snapremove='sudo snap remove'
	alias snapclean='LANG=C snap list --all | while read snapname ver rev trk pub notes; do if [[ $notes = *disabled* ]]; then sudo snap remove "$snapname" --revision="$rev"; fi; done'
	alias snapsearch='snap find'
	alias snaplist='snap list'
	alias snapsize='du -hcs /var/lib/snapd/snaps/*'
fi

#######################################################
# Alias for sudo replacements on machines with one user
#######################################################

if [[ $_SKIP_SUDO_ALTERNATIVE = false ]]; then

	# A very slim alternative to both sudo and doas
	# Link: https://codeberg.org/sw1tchbl4d3/rdo
	# Config: sudoedit /etc/rdo.conf
	# username=yourusername
	# wrong_pw_sleep=1000
	# session_ttl=5
	if [[ -x "$(command -v rdo)" ]]; then
		alias sudo='rdo'

		# If sudoedit is not avaliable, alias it
		if [[ ! -x "$(command -v sudoedit)" ]]; then
			alias sudoedit='sudo --preserve-env edit'
		fi

	# A port of OpenBSD's doas offers two benefits over sudo:
	# 1) Its configuration file has a simple syntax and
	# 2) It is smaller, requiring less effort to audit the code
	# This makes it harder for both admins and coders to make mistakes that potentially open security holes in the system
	# Link: https://github.com/Duncaen/OpenDoas or https://github.com/slicer69/doas
	# Link: https://youtu.be/eamEZCj-CuQ
	# Config: Add "permit <user> as root" in /etc/doas.conf or /usr/local/etc/doas.conf
	elif [[ -x "$(command -v doas)" ]]; then
		alias sudo='doas'

		# Replace sudoedit only if doasedit exists
		# Link: https://github.com/AN3223/scripts/blob/master/doasedit
		if [[ -x "$(command -v doasedit)" ]]; then
			alias sudoedit='doasedit'
		fi
	fi
fi

#######################################################
# General Function "Aliases"
#######################################################

# Function to run upon exit of shell
function _exit() {
	# Show who logged out
	local COLOR="\033[1;31m"     # Light Red
	local HIGHLIGHT="\033[1;34m" # Light Blue
	local NOCOLOR="\033[0m"
	echo -e "${COLOR}User ${HIGHLIGHT}$(echo $USER)${COLOR} has logged out of ${HIGHLIGHT}$(echo $HOSTNAME)${COLOR}.${NOCOLOR}"
}
trap _exit EXIT

# Calculator that uses bc or Bash's built-in arithmetic
# Example: = 5*5+2
if [[ -n "$(command -v bc)" ]]; then
	# Start calculator with math support
	# echo 'if (scale == 0) scale=4' > ~/.config/bcrc
	# Link: https://www.gnu.org/software/bc/manual/html_mono/bc.html
	alias bc='bc --mathlib'
	if [[ -f ~/.bcrc ]]; then
		export BC_ENV_ARGS=~/.bcrc
	elif [[ -f ~/.config/bcrc ]]; then
		export BC_ENV_ARGS=~/.config/bcrc
	fi
	export BC_LINE_LENGTH=0

	function =() {
		bc <<< ${@}
	}
else
	function =() {
		local IFS=' '
		local _CALC="${*//p/+}"
		_CALC="${_CALC//x/*}"
		echo "$(($_CALC))"
	}
fi

# Finds the current Linux distribution, name, version, and kernel version
function ver() {
	if [[ -x "$(command -v uname)" ]]; then
		uname --kernel-name --kernel-release --machine && echo
	fi
	if [[ -x "$(command -v hostnamectl)" ]]; then
		hostnamectl && echo
	fi
	if [[ -x "$(command -v lsb_release)" ]]; then
		lsb_release -a && echo
	fi
	cat /etc/*-release 2> /dev/null
}

# Search process names to kill
# https://unix.stackexchange.com/questions/443472/alias-for-killing-all-processes-of-a-grep-hit
function smash() {
	local T_PROC=$1
	local T_PIDS=($(pgrep -i "$T_PROC"))
	if [[ "${#T_PIDS[@]}" -ge 1 ]]; then
		echo "Found the following processes:"
		for pid in "${T_PIDS[@]}"; do
			echo "$pid" "$(\ps -p "$pid" -o comm= | awk -F'/' '{print $NF}')" | column -t
		done
		if ask "Kill them?" N; then
			for pid in "${T_PIDS[@]}"; do
				echo "Killing ${pid}..."
				( kill -15 "$pid" ) && continue
				sleep 2
				( kill -2 "$pid" ) && continue
				sleep 2
				( kill -1 "$pid" ) && continue
				echo "Cannot terminate" >&2 && return 1
			done
		else
			echo "Exiting..."
			return 0
		fi
	else
		echo "No processes found for: $1" >&2 && return 1
	fi
}

# Extracts any archive(s)
function extract() {
	for archive; do
		if [ -f "$archive" ] ; then
			case "$archive" in
				*.tar.bz2)   tar xvjf "$archive"   ;;
				*.tar.gz)    tar xvzf "$archive"   ;;
				*.bz2)       bunzip2 "$archive"    ;;
				*.rar)       rar x "$archive"      ;;
				*.gz)        gunzip "$archive"     ;;
				*.tar)       tar xvf "$archive"    ;;
				*.tbz2)      tar xvjf "$archive"   ;;
				*.tgz)       tar xvzf "$archive"   ;;
				*.zip)       unzip "$archive"      ;;
				*.Z)         uncompress "$archive" ;;
				*.7z)        7z x "$archive"       ;;
				*)           echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

# Generate a random password without installing any external tooling
# Pass the number of characters for the password on the command line
# Add the parameter +s to include symbols and -s to exclude them
# Example: genpw
# Example: genpw +s 24
# Example: genpw 8
# Example: genpw 12 -s
# HINT: Check passwords with cracklib: echo "1234abc" | cracklib-check
# Link: https://www.cyberciti.biz/security/linux-password-strength-checker/
function genpw() {
	local _PASSWORD_LENGTH
	local _PASSWORD_SYMBOLS

	if [[ ${1} -gt 0 ]]; then
		_PASSWORD_LENGTH=${1}
	elif [[ ${2} -gt 0 ]]; then
		_PASSWORD_LENGTH=${2}
	else
		read -e -i "16" -p "How many characters? " _PASSWORD_LENGTH
		if [[ ! ${_PASSWORD_LENGTH} -gt 0 ]]; then
			_PASSWORD_LENGTH=16
		fi
	fi

	if [[ ${1} == '-s' ]] || [[ ${2} == '-s' ]]; then
		_PASSWORD_SYMBOLS=false
	elif [[ ${1} == '+s' ]] || [[ ${2} == '+s' ]]; then
		_PASSWORD_SYMBOLS=true
	else
		if ask "Do you want to include symbols?" Y; then
			_PASSWORD_SYMBOLS=true
		fi
	fi

	if [[ -x "$(command -v apg)" ]]; then
		if [[ ${_PASSWORD_SYMBOLS} == true ]]; then
			apg -a 1 -n 10 -m ${_PASSWORD_LENGTH} -l
		else
			apg -a 0 -n 10 -m ${_PASSWORD_LENGTH} -l
		fi
	elif [[ -x "$(command -v pwgen)" ]]; then
		if [[ ${_PASSWORD_SYMBOLS} == true ]]; then
			pwgen --capitalize --numerals --symbols --secure -C ${_PASSWORD_LENGTH} 40
		else
			pwgen --capitalize --numerals --secure -C ${_PASSWORD_LENGTH} 40
		fi
	elif [[ -x "$(command -v gpg)" ]]; then
		for ((n=0;n<10;n++)); do
			if [[ ${_PASSWORD_SYMBOLS} == true ]]; then
				gpg --gen-random 1 1024 | tr -dc a-zA-Z0-9'`~!@#$%^&*-_=+()[]{}|;:",.?<>/\\'"'" | head -c${_PASSWORD_LENGTH}; echo
			else
				gpg --gen-random 1 1024 | tr -dc a-zA-Z0-9 | head -c${_PASSWORD_LENGTH}; echo
			fi
		done
	elif [[ -x "$(command -v openssl)" ]]; then
		for ((n=0;n<10;n++)); do
			if [[ ${_PASSWORD_SYMBOLS} == true ]]; then
				openssl rand 1024 | tr -dc a-zA-Z0-9'`~!@#$%^&*-_=+()[]{}|;:",.?<>/\\'"'" | head -c${_PASSWORD_LENGTH}; echo
			else
				openssl rand 1024 | tr -dc a-zA-Z0-9 | head -c${_PASSWORD_LENGTH}; echo
			fi
		done
	else
		for ((n=0;n<10;n++)); do
			if [[ ${_PASSWORD_SYMBOLS} == true ]]; then
				cat /dev/urandom | tr -dc a-zA-Z0-9'`~!@#$%^&*-_=+()[]{}|;:",.?<>/\\'"'" | head -c${_PASSWORD_LENGTH}; echo
			else
				cat /dev/urandom | tr -dc a-zA-Z0-9 | head -c${_PASSWORD_LENGTH}; echo
			fi
		done
	fi
}

# See what command you are using the most (this parses the history command)
function mostused() {
	history \
	| awk ' { a[$4]++ } END { for ( i in a ) print a[i], i | "sort -rn | head -n10"}' \
	| awk '$1 > max{ max=$1} { bar=""; i=s=10*$1/max;while(i-->0)bar=bar"#"; printf "%25s %15d %s %s", $2, $1,bar, "\n"; }'
}

# Start a program but immediately disown it and detach it from the terminal
function runfree() {
	"$@" > /dev/null 2>&1 & disown
}

# Make a string safe to be used in regular expressions
function regexformat() {
	echo -n "$(printf '%s' "${1}" | sed 's/[.[\(\)\ *^$+?{|]/\\&/g')"
}

# Trim leading and trailing characters on the clipboard
function trimcb() {
	if [[ -x "$(command -v xclip)" ]]; then
		echo -e "$(xclip -o)" | sed 's/^[ 	]*//;s/[ 	]*$//' | xclip -selection clipboard
	elif [[ -x "$(command -v xsel)" ]]; then
		echo -e "$(xsel)" | sed 's/^[ 	]*//;s/[ 	]*$//' | xsel -bi
	else
		echo "Dependency xclip or xsel not found."
	fi
}

# Long format directory listing with color columns (only requires gawk)
function llcolor {
	if [[ -x "$(command -v gawk)" ]]; then
		# Show long directory listings with color columns
		\ls -l --all --classify --group-directories-first --human-readable --color=always "$@" | awk '
			BEGIN {
				FPAT = "([[:space:]]*[^[:space:]]+)";
				OFS = "";
			}
			{
				$1 = "\033[0;37m" $1 "\033[0m";
				$2 = "\033[0;34m" $2 "\033[0m";
				$3 = "\033[0;35m" $3 "\033[0m";
				$4 = "\033[0;31m" $4 "\033[0m";
				$5 = "\033[0;33m" $5 "\033[0m";
				$6 = "\033[0;32m" $6 "\033[0m";
				$7 = "\033[0;32m" $7 "\033[0m";
				$8 = "\033[0;36m" $8 "\033[0m";
				print
			}
		'
	else # Gawk not installed...
		# Show long directory listings with highest compatibility
		\ls -Fls "$@"
	fi
}

# Commands pushd and popd now output the directory stack after modification
# and also prevents duplicate directories being added to the directory stack
pushd() {
	builtin pushd "${@}" > /dev/null
	dirsdedup
	echo "Directory Stack:"
	dirs -v
}

popd() {
	builtin popd "${@}" > /dev/null
	echo "Directory Stack:"
	dirs -v
}

# Removes duplicate directories in the directory stack for pushd
dirsdedup(){
	declare -a new=() copy=("${DIRSTACK[@]:1}")
	declare -A seen
	local v i
	seen[$PWD]=1
	for v in "${copy[@]}"
	do if [ -z "${seen[$v]}" ]
	then new+=("$v")
		seen[$v]=1
	fi
	done
	dirs -c
	for ((i=${#new[@]}-1; i>=0; i--))
	do builtin pushd -n "${new[i]}" >/dev/null
	done
}

# View a comma delimited (.CSV) file
function csvview() {
	cat "${@}" | sed 's/,/ ,/g' | column -t -s, | less -S
}

# Send file(s) to the trash
# Example: trash file1.ext file2.ext
# Link: https://www.tecmint.com/trash-cli-manage-linux-trash-from-command-line/
function trash() {
	if [[ -x "$(command -v trash-put)" ]]; then
		trash-put "${@}"
	elif [[ -d $HOME/.local/share/Trash/files ]]; then
		mv "${@}" $HOME/.local/share/Trash/files/
	elif [[ -d $HOME/.local/share/trash/files ]]; then
		mv "${@}" $HOME/.local/share/trash/files/
	elif [[ -d $HOME/.Trash ]]; then
		mv "${@}" $HOME/.Trash/
	elif [[ -d $HOME/.trash ]]; then
		mv "${@}" $HOME/.trash/
	else
		mkdir $HOME/.trash
		mv "${@}" $HOME/.trash/
	fi
}

# Display the contents of the trash
function trashlist() {
	if [[ -x "$(command -v trash-list)" ]]; then
		trash-list
	elif [[ -d $HOME/.local/share/Trash/files ]]; then
		ll $HOME/.local/share/Trash/files/
	elif [[ -d $HOME/.local/share/trash/files ]]; then
		ll "${@}" $HOME/.local/share/trash/files/
	elif [[ -d $HOME/.Trash ]]; then
		ll "${@}" $HOME/.Trash/
	elif [[ -d $HOME/.trash ]]; then
		ll "${@}" $HOME/.trash/
	else
		echo "No trash folder exists."
	fi
}

# Empty and permanently delete all the files in the trash
function trashempty() {
	if [[ -x "$(command -v trash-empty)" ]]; then
		trash-empty
	elif [[ -d $HOME/.local/share/Trash/files ]]; then
		rm -rf ~/.local/share/Trash/files/{..?*,.[!.]*,*} 2>/dev/null
	elif [[ -d $HOME/.local/share/trash/files ]]; then
		rm -rf ~/.local/share/trash/files/{..?*,.[!.]*,*} 2>/dev/null
	elif [[ -d $HOME/.Trash ]]; then
		rm -rf ~/.Trash/{..?*,.[!.]*,*} 2>/dev/null
	elif [[ -d $HOME/.trash ]]; then
		rm -rf ~/.trash/{..?*,.[!.]*,*} 2>/dev/null
	fi
}

# Restore the trash only is trash-cli is installed
# trash-cli - Command Line Interface to FreeDesktop.org Trash
# Link: https://github.com/andreafrancia/trash-cli
if [[ -x "$(command -v restore-trash)" ]]; then
	alias trashrestore='restore-trash'
elif [[ -x "$(command -v trash-restore)" ]]; then
 	alias trashrestore='trash-restore'
fi

# Check the sha256 checksum of a downloaded file using a checksum file like sha256sum.txt
function checksha256() {
	if [[ "$#" -lt 2 ]] || [[ $1 = "--help" ]] || [[ $1 = "-h" ]]; then
		echo -e "\033[1;33mSyntax:\033[0m"
		echo -e "checksha256 \033[0;36m[downloaded file]\033[0m \033[0;36m[checksum file]\033[0m"
		return 1
	fi
	if [[ -x "$(command -v sha256sum)" ]]; then
		if [[ $(sha256sum "${1}" | cut -d' ' -f 1) == $(grep -Po '\b[a-zA-Z0-9]{64}\b' "${2}") ]]; then
			echo -e "\033[0;32mGood"
		else
			echo -e "\033[0;31mBad"
		fi
	else
		echo -e "\033[1;31mError:\033[0m The application sha256sum is not installed."
	fi
}

# Searches for text in all files in the current folder
function findtext() {
	# If The Silver Searcher is installed, use that
	# Link: https://github.com/ggreer/the_silver_searcher
	# Hint: You can use --ignore "dir/or/file"
	if [[ -x "$(command -v ag)" ]]; then
		ag --color --ignore-case --hidden --literal "${@}" 2> /dev/null

	# If ripgrep is installed, use that
	# Link: https://github.com/BurntSushi/ripgrep
	elif [[ -x "$(command -v rg)" ]]; then
		rg --pretty "${@}" | more

	else # Use grep
		# Link: https://www.howtogeek.com/496056/how-to-use-the-grep-command-on-linux/
		# Hint: You can use --exclude='/dir/or/file'
		# -i case-insensitive
		# -I ignore binary files
		# -H causes filename to be printed
		# -r recursive search
		# -n causes line number to be printed
		# optional: -F treat search term as a literal, not a regular expression
		# optional: -l only print filenames and not the matching lines ex. grep -irl "$@" *
		grep -iIHrn --color=always "${@}" . | $PAGER -r
	fi
}

# Searches for text in source code files located in the current path
function findcode() {
	# If The Silver Searcher is installed, use that
	# Link: https://github.com/ggreer/the_silver_searcher
	# Hint: You can use --ignore "dir/or/file"
	if [[ -x "$(command -v ag)" ]]; then
		ag --color --ignore-case --hidden --literal --ignore "*.min.*" --file-search-regex ".*\.(ada|asm|c|cbl|conf|cpp|cpy|cs|css|f|f90|for|go|groovy|h|hpp|htm|html|inc|ini|java|js|json|lib|lua|m|mat|mk|php|pl|py|r|rb|rlib|rs|sc|scala|scss|sh|sql|swift|tcl|template|tpl|ts|vb|vba|vbs|xml|yaml|yml)" "${@}" 2> /dev/null

	# If ripgrep is installed, use that
	# Link: https://github.com/BurntSushi/ripgrep
	elif [[ -x "$(command -v rg)" ]]; then
		rg --pretty "${@}" -g '*.{ada,asm,c,cbl,conf,cpp,cpy,cs,css,f,f90,for,go,groovy,h,hpp,htm,html,inc,ini,java,js,json,lib,lua,m,mat,mk,php,pl,py,r,rb,rlib,rs,sc,scala,scss,sh,sql,swift,tcl,template,tpl,ts,vb,vba,vbs,xml,yaml,yml}' | more

	# Use grep (see findtext function above for options explanation)
	# Hint: You can use --exclude='/dir/or/file'
	else
		grep -iIHrnF --color=always \
			--include=*.ada \
			--include=*.asm \
			--include=*.c \
			--include=*.cbl \
			--include=*.conf \
			--include=*.cpp \
			--include=*.cpy \
			--include=*.cs \
			--include=*.css \
			--include=*.f \
			--include=*.f90 \
			--include=*.for \
			--include=*.go \
			--include=*.groovy \
			--include=*.h \
			--include=*.hpp \
			--include=*.htm \
			--include=*.html \
			--include=*.inc \
			--include=*.ini \
			--include=*.java \
			--include=*.js \
			--include=*.json \
			--include=*.lib \
			--include=*.lua \
			--include=*.m \
			--include=*.mat \
			--include=*.mk \
			--include=*.php \
			--include=*.pl \
			--include=*.py \
			--include=*.r \
			--include=*.rb \
			--include=*.rlib \
			--include=*.rs \
			--include=*.sc \
			--include=*.scala \
			--include=*.scss \
			--include=*.sh \
			--include=*.sql \
			--include=*.swift \
			--include=*.tcl \
			--include=*.template \
			--include=*.tpl \
			--include=*.ts \
			--include=*.vb \
			--include=*.vba \
			--include=*.vbs \
			--include=*.xml \
			--include=*.yaml \
			--include=*.yml \
			--exclude='*.min.*' \
			"${@}" . | $PAGER -r
	fi
}

# Copy file with a progress bar
function cpp() {
	if [[ -x "$(command -v rsync)" ]]; then
		# rsync -avh --progress "${1}" "${2}"
		rsync -ah --info=progress2 "${1}" "${2}"
	else
		set -e
		strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
		| awk '{
		count += $NF
		if (count % 10 == 0) {
			percent = count / total_size * 100
			printf "%3d%% [", percent
			for (i=0;i<=percent;i++)
				printf "="
				printf ">"
				for (i=percent;i<100;i++)
					printf " "
					printf "]\r"
				}
			}
		END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
	fi
}

# Copy and go to the directory
function cpg() {
	if [[ -d "$2" ]];then
		cp "$1" "$2" && cd "$2"
	else
		cp "$1" "$2"
	fi
}

# Move and go to the directory
function mvg() {
	if [[ -d "$2" ]];then
		mv "$1" "$2" && cd "$2"
	else
		mv "$1" "$2"
	fi
}

# Create and go to the directory
function mkdirg() {
	mkdir -p "$@"
	cd "$@"
}

# Repeat a command n times
function repeat() {
	local i max
	max=$1; shift;
	for ((i=1; i <= max ; i++)); do  # --> C-like syntax
		eval "$@";
	done
}

# Goes up a specified number of directories  (i.e. up 4)
function up() {
	local d=""
	limit=$1
	for ((i=1 ; i <= limit ; i++))
		do
			d="$d"/..
		done
	d=$(echo $d | sed 's/^\///')
	if [[ -z "$d" ]]; then
		d=..
	fi
	cd "$d"
}

# Returns the last 2 fields of the working directory
function pwdtail() {
	pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}

if [[ -x "$(command -v openssl)" ]]; then

	# If base64 isn't available, use openssl's version to do the same thing
	if [[ ! -x "$(command -v base64)" ]]; then
		alias base64='openssl base64'
	fi

	# If base64 isn't available, use openssl's version to do the same thing
	if [[ ! -x "$(command -v md5sum)" ]]; then
		alias md5sum='openssl md5'
	fi

	# SHA1
	alias sha1='openssl sha1'
fi

# Encryption has been changed to gpg from SSL due to security
# Link: https://stackoverflow.com/questions/28247821/openssl-vs-gpg-for-encrypting-off-site-backups
# Install: pkginstall gnupg # gpg2 on SUSE
if [[ -x "$(command -v gpg)" ]]; then
	## Uses OpenSSL AES 256bit Cipher Block Chaining Encryption to encrypt a file
	function encrypt() {
		if [[ "${#}" -lt 1 ]] || [[ "${1}" = "--help" ]] || [[ "${1}" = "-h" ]]; then
			echo -e "\033[1;33mSyntax:\033[0m"
			echo -e "encrypt \033[0;36m[input_file]\033[0m \033[1;30m(output file will end in .gpg)\033[0m"
			return
		elif [[ ! -r "${1}" ]]; then
			echo -e "\033[1;31mError:\033[0m File ${1} not found"
			return 1
		fi
		echo "Encrypting ${1}..."
		# equivalents in the gpg.conf file
		# s2k-mode 3
		# s2k-count 65011712
		# s2k-digest-algo SHA512
		# s2k-cipher-algo AES256
		gpg --s2k-mode 3 --s2k-count 65011712 --s2k-digest-algo SHA512 --s2k-cipher-algo AES256 --symmetric "${1}"
		echo -e "\033[1;32mFile ${_encrypted_file} successfully encrypted\033[0m"
	}

	## Uses OpenSSL AES 256bit Cipher Block Chaining Encryption to decrypt a file
	function decrypt() {
		if [[ "${#}" -lt 1 ]] || [[ "${1}" = "--help" ]] || [[ "${1}" = "-h" ]]; then
			echo -e "\033[1;33mSyntax:\033[0m"
			echo -e "decrypt \033[0;36m[encrypted_file.gpg]\033[0m"
			return
		elif [[ ! -r "${1}" ]]; then
			echo -e "\033[1;31mError:\033[0m File ${1} not found"
			return 1
		fi
		echo "Decrypting ${1}..."
		if gpg "${1}" ; then
			echo -e "\033[1;32mFile successfully decrypted\033[0m"
		else
			echo -e "\033[1;31mError decrypting ${1}\033[0m"
		fi
	}
fi

# Print a list of colors
function colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

# Print a list of 256 colors
function colors256() {
	for i in {0..255} ; do
		printf "\x1b[38;5;${i}mcolour${i}\n"
	done
}

# Test for 24bit true color in the terminal
function colors24bit() {
	echo 'If the gradients are smooth, you are displaying 24bit true color.'
	awk 'BEGIN{
		s='1234567890';
		s=s s s s s s s s s s s s s s s s s s s s s s s;
		for (colnum = 0; colnum<256; colnum++) {
			r = 255-(colnum*255/255);
			g = (colnum*510/255);
			b = (colnum*255/255);
			if (g>255) g = 510-g;
			printf "\033[48;2;%d;%d;%dm", r,g,b;
			printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
			printf "%s\033[0m", substr(s,colnum+1,1);
		}
		printf "\n";
	}'
}

# Prints random height bars across the width of the screen
# (great with lolcat application on new terminal windows)
function sparkbars() {
	columns=$(tput cols)
	chars=▁▂▃▄▅▆▇█
	for ((i = 1; i <= $columns; i++))
	do
		echo -n "${chars:RANDOM%${#chars}:1}"
	done
	echo
}

# View Apache logs (requires multitail)
function apachelog () {
	if [ -d /var/log/httpd ]; then
		cd /var/log/httpd && ls -Ah && multitail --no-repeat -c -s 2 /var/log/httpd/*_log
	else
		cd /var/log/apache2 && ls -Ah && multitail --no-repeat -c -s 2 /var/log/apache2/*.log
	fi
}

# Auto-find and edit the Apache configuration
function apacheconfig() {
	if [[ -x "$(command -v httpd)" ]] || [[ -x "$(command -v apache2)" ]]; then
		if [[ -f /etc/httpd/conf/httpd.conf ]]; then
			sudoedit /etc/httpd/conf/httpd.conf
		elif [[ -f /etc/httpd/httpd.conf ]]; then
			sudoedit /etc/httpd/httpd.conf
		elif [[ -f /etc/apache2/apache2.conf ]]; then
			sudoedit /etc/apache2/apache2.conf
		elif [[ -f /usr/local/apache2/apache2.conf ]]; then
			sudoedit /usr/local/apache2/apache2.conf
		elif [[ -f /usr/local/etc/httpd/httpd.conf ]]; then
			sudoedit /usr/local/etc/httpd/httpd.conf
		else
			echo "Error: Apache config file could not be found."
			echo "Searching for possible locations:"
			# sudo updatedb && locate httpd.conf && locate apache2.conf
			# apachectl -V
			httpd -V 2> /dev/null || apachectl -V 2> /dev/null || apache2 -V
		fi
	else
		echo "Apache is not installed."
	fi
}

# Find the Apache service and restart/start it
function apacherestart() {
	# If we are using Systemd...
	if [[ -x "$(command -v systemctl)" ]]; then
		if [[ -x "$(command -v httpd)" ]]; then
			sudo systemctl restart httpd
		elif [[ -x "$(command -v apache2)" ]]; then
			sudo systemctl restart apache2
		else
			echo 'Error: Could not find Apache service name'
			return 1
		fi

	# If using init.d...
	elif [[ -x /etc/init.d ]]; then
		if [[ -f /etc/init.d/httpd ]]; then
			sudo /etc/init.d/httpd restart
		elif [[ -f /etc/init.d/apache2 ]]; then
			sudo /etc/init.d/apache2 restart
		else
			echo 'Error: Could not find Apache service name'
			return 1
		fi

	# Other systems including OpenRC...
	elif [[ -x "$(command -v service)" ]]; then
		if [[ -x "$(command -v httpd)" ]]; then
			sudo service httpd restart
		elif [[ -x "$(command -v apache2)" ]]; then
			sudo service apache2 restart
		else
			echo 'Error: Could not find Apache service name'
			return 1
		fi

	else # Unknown
		echo 'Error: Could not find service controller'
		return 1
	fi
}

# Check the syntax of a PHP file for errors
function phpchecksyntax() {
	if [ $# -eq 0 ]; then
		echo -e '\033[1;31mERROR:\033[1;37m You must specify a PHP file\033[0m'
		return 1
	fi
	echo -e "\033[1;31m[\033[1;36mPHP Check\033[1;31m]\033[1;33m->\033[1;32m${1}\033[0;0m"
	php -l "${1}"
}

# Auto-find and edit the PHP configuration file
function phpconfig() {
	if [[ -x "$(command -v php)" ]]; then
		local _php_ini_file=$(php -r 'echo php_ini_loaded_file();')
		if [[ -f "${_php_ini_file}" ]]; then
			echo "Found: ${_php_ini_file}"
			sudoedit "${_php_ini_file}"
		elif [[ -f /etc/php.ini ]]; then
			echo "Found: /etc/php.ini"
			sudoedit /etc/php.ini
		elif [[ -f /etc/php/php.ini ]]; then
			echo "Found: /etc/php/php.ini"
			sudoedit /etc/php/php.ini
		else
			echo "Error: php.ini file could not be found automatically."
			echo "Searching for possible locations:"
			# sudo updatedb && locate php.ini
			php --ini
		fi
	else
		echo "PHP is not installed."
	fi
}

# Auto-find and edit the MySQL configuration file
function mysqlconfig() {
	if [[ -x "$(command -v mysqld)" ]]; then
		if [[ -f /etc/my.cnf ]]; then
			sudoedit /etc/my.cnf
		elif [[ -f /etc/mysql/my.cnf ]]; then
			sudoedit /etc/mysql/my.cnf
		elif [[ -f /usr/local/etc/my.cnf ]]; then
			sudoedit /usr/local/etc/my.cnf
		elif [[ -f /usr/bin/mysql/my.cnf ]]; then
			sudoedit /usr/bin/mysql/my.cnf
		elif [[ -f "$HOME/my.cnf" ]]; then
			sudoedit "$HOME/my.cnf"
		else
			echo "Error: my.cnf file could not be found automatically."
			echo "Searching for possible locations:"
			# sudo updatedb && locate my.cnf
			mysqld --verbose --help | grep -A 1 "Default options"
		fi
	else
		echo "MySQL is not installed."
	fi
}

# Confirm/Ask a question - See 'killps' for example of use
# General-purpose function to ask Yes/No questions in Bash,
# either with or without a default answer.
# It keeps repeating the question until it gets a valid answer.
# Link: https://gist.github.com/davejamesmiller/1965569
# Example Usage:
#   if ask "Do you want to do such-and-such?"; then
# Default to Yes if the user presses enter without giving an answer:
#   if ask "Do you want to do such-and-such?" Y; then
# Default to No if the user presses enter without giving an answer:
#   if ask "Do you want to do such-and-such?" N; then
# Or if you prefer the shorter version:
#   ask "Do you want to do such-and-such?" && said_yes
#   ask "Do you want to do such-and-such?" || said_no
function ask() {
	local prompt default reply

	if [[ ${2:-} = 'Y' ]]; then
		prompt='Y/n'
		default='Y'
	elif [[ ${2:-} = 'N' ]]; then
		prompt='y/N'
		default='N'
	else
		prompt='y/n'
		default=''
	fi

	while true; do
		# Ask the question (not using "read -p" as it uses stderr not stdout)
		echo -ne "$1 [$prompt] "

		# Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
		read -r reply </dev/tty

		# Default?
		if [[ -z $reply ]]; then
			reply=$default
		fi

		# Check if the reply is valid
		case "$reply" in
			Y*|y*) return 0 ;;
			N*|n*) return 1 ;;
		esac
	done
}

# This function requires multi-line text to be piped in
# Supported optional pickers are: fzy, skim, fzf, peco, percol, pick, icepick, selecta, sentaku, zf
# Example: ls -1 ~ | createmenu
# Example: echo -e "Jen\nTom\nJoe Bob\nAmy\nPat" | sort | createmenu
# Example: cat "menuitems.txt" | createmenu
# Example: _TMUX_SESSION="$(tmux ls -F "#{session_name}" 2> /dev/null | createmenu)"
function createmenu() {

	# Get the piped in multiple lines of text
	local _INPUT="${*:-$(</dev/stdin)}"

	# Count the lines of text
	local _INPUT_LINES=$(echo "${_INPUT}" | wc -l)

	# If there is no input, just exit with an error
	if [ -z "${_INPUT}" ]; then
		return 1

	# If there is only one line, no choice is needed
	elif [ ${_INPUT_LINES} -eq 1 ]; then
		echo "${_INPUT[0]}"
		return 0
	fi

	# Do we have a picker installed?
	local _FOUND_PICKER=false
	for _PICKER in fzy sk fzf peco percol pick icepick selecta sentaku zf; do
		if [[ -x "$(command -v $_PICKER)" ]]; then
			_FOUND_PICKER=true
			break;
		fi
	done

	# If we found a picker, use it
	if [ $_FOUND_PICKER == true ]; then
		echo "${_INPUT}" | ${_PICKER}

	# Use Bash's built in select option
	else

		# Parse only on new lines
		_IFS_OLD="#{IFS}"
		IFS=$'\n'

		# Turn off globbing filename generation
		set -f

		# Show a list to pick an item from
		select RESULT in ${_INPUT[@]}; do
			if [ -n "${RESULT}" ]; then
				echo "${RESULT}"
				break
			fi
		done < /dev/tty

		# Restore settings
		set +f
	fi
}

# A full chmod calculator on command line (type chmodcalc for usage and examples)
function chmodcalc() {
	# Define colors
	local BLUE="\033[0;34m"
	local CYAN="\033[0;36m"
	local GREEN="\033[0;32m"
	local MAGENTA="\033[0;35m"
	local RED="\033[0;31m"
	local YELLOW="\033[0;33m"
	local ERROR="\033[1;31m"
	local NOCOLOR="\033[0m"

	# Define local variables
	local text=""
	local output=""
	local example=""
	local i=0
	local n=0
	local formatted=""

	if [ "$#" -eq 1 ]; then
		if [ "${#1}" -ge 4 ]; then
			echo -e "${RED}Error: Invalid octal.${NOCOLOR}";
			return 128;
		fi
		text="$1"
		output=""
		example=""
		i=0
		while (( i++ < ${#text} ))
		do
			char=$(expr substr "${text}" "${i}" 1)
			case $char in
			0)
				part[${i}]="---"
				;;
			1)
				part[${i}]="--x"
				;;
			2)
				part[${i}]="-w-"
				;;
			3)
				part[${i}]="-wx"
				;;
			4)
				part[${i}]="r--"
				;;
			5)
				part[${i}]="r-x"
				;;
			6)
				part[${i}]="rw-"
				;;
			7)
				part[${i}]="rwx"
				;;
			*)
				part[${i}]="Error: Invalid octal."
				break
				;;
			esac
			example[${i}]="${part[${i}]//-}"
		done
		echo -e "${GREEN}${part[1]}${NOCOLOR} ${YELLOW}${part[2]}${NOCOLOR} ${RED}${part[3]}${NOCOLOR}"
		echo ""
		echo "Examples:"
		echo -e "${CYAN}chmod${NOCOLOR} ${CYAN}-R${NOCOLOR} ${MAGENTA}${text}${NOCOLOR} ${BLUE}./*${NOCOLOR}"
		echo -e "${CYAN}chmod${NOCOLOR} ${CYAN}-R${NOCOLOR} ${CYAN}u=${GREEN}${example[1]}${NOCOLOR}${CYAN},g=${YELLOW}${example[2]}${NOCOLOR}${CYAN},o=${RED}${example[3]}${NOCOLOR} ${BLUE}./*${NOCOLOR}"
		echo ""
	elif [ "$#" -eq 3 ]; then
		formatted=""
		for p
		do
			n=0
			[[ $p =~ .*r.* ]] && (( n+=4 ))
			[[ $p =~ .*w.* ]] && (( n+=2 ))
			[[ $p =~ .*x.* ]] && (( n+=1 ))
			formatted=${formatted}$(printf "${n}")
			# printf $n
		done
		echo -e "${CYAN}${formatted}${NOCOLOR}"
		chmodcalc "${formatted}"
	else
		echo -e "${ERROR}Error: 1 or 3 parameters required.${NOCOLOR}"
		echo ""
		echo -e "Syntax: ${CYAN}chmodcalc${NOCOLOR} ${GREEN}[owner]${NOCOLOR} ${YELLOW}[group]${NOCOLOR} ${RED}[other]${NOCOLOR}"
		echo -e "Example: ${GREEN}chmodcalc${NOCOLOR} ${GREEN}rwx${NOCOLOR} ${YELLOW}rw${NOCOLOR} ${RED}r${NOCOLOR}"
		echo ""
		echo -e "Syntax: ${CYAN}chmodcalc [octal]${NOCOLOR}"
		echo -e "Example: ${GREEN}chmodcalc 777${NOCOLOR}"
		echo ""
		echo -e "You can also use symbols instead of numeric values with chmod"
		echo -e "${BLUE}chmod u=rwx,g=rw,o=r filename.ext${NOCOLOR}"
		echo ""
		echo -e "To calculate octals: ${BLUE}read${NOCOLOR} is ${CYAN}4${NOCOLOR}, ${BLUE}write${NOCOLOR} is ${CYAN}2${NOCOLOR}, and ${BLUE}execute${NOCOLOR} is ${CYAN}1${NOCOLOR}"
		echo ""
	fi
}

# Function to recursively set permissions for only files
function chmodfiles() {
	# If the second parameter is not passed, set to the current working directory using $PWD
	local _directory="${2:-${PWD}}"
	local _permission="$1"

	# Exit if the directory does not exist
	if [ -z "$_permission" ]; then
		echo "Sets permissions for files recursively"
		echo "Syntax:";
		echo "  chmodfiles [mode] [optional folder]";
		echo "Example:";
		echo "  chmodfiles 664";
		echo "  chmodfiles +x /some/path";
		return 1;
	fi

	# Exit if the directory does not exist
	if [ ! -d "$_directory" ]; then
		echo "Error: Directory $_directory not found.";
		return 2;
	fi

	# Get confirmation
	echo "This will recursively change all permissions to $_permission for the files in the directory:"
	echo "$_directory"

	if ask "Are you sure?" N; then
		find "$_directory" -type f -exec chmod $_permission {} \;
		echo "Done."
	fi
}

# Function to recursively set permissions for only directories
alias chmodfolders='chmoddirs'
function chmoddirs() {
	# If the second parameter is not passed, set to the current working directory using $PWD
	local _directory="${2:-${PWD}}"
	local _permission="$1"

	# Exit if the directory does not exist
	if [ -z "$_permission" ]; then
		echo "Sets permissions for directories recursively"
		echo "Syntax:";
		echo "  chmoddirs [mode] [optional folder]";
		echo "Example:";
		echo "  chmoddirs 775";
		echo "  chmoddirs +x /some/path";
		return 1;
	fi

	# Exit if the directory does not exist
	if [ ! -d "$_directory" ]; then
		echo "Error: Directory $_directory not found.";
		return 2;
	fi

	# Get confirmation
	echo "This will recursively change all permissions to $_permission for the directories:"
	echo "$_directory"

	if ask "Are you sure?" N; then
		find "$_directory" -type d -name \* -exec chmod $_permission {} \;
		echo "Done."
	fi
}

# Recursively set permissions of code files and directories
# WARNING: Will remove executable permissions on script files
function chfix() {
	# Directory and file permissions
	local _dir_permissions="0775"  # rwx rwx rx
	local _file_permissions="0664" # rw  rw  r

	# Permissions for user and group
	#local _user="www-data"
	#local _group="www-data"

	## If $1 is not passed, set to the current working dir using $PWD
	local _directory="${1:-${PWD}}"

	## Exit if the directory does not exist
	if [ ! -d "$_directory" ]; then
		echo "Error: Directory $_directory not found.";
		return 1;
	fi

	## Make sure we are not inside a protected folder
	if [[ "$_directory" = "/" ||
		"$_directory" = "/root" ||
		"$_directory" = "/bin" ||
		"$_directory" = "/boot" ||
		"$_directory" = "/etc" ||
		"$_directory" = "/home" ||
		"$_directory" = "/lib" ||
		"$_directory" = "/lib64" ||
		"$_directory" = "/mnt" ||
		"$_directory" = "/opt" ||
		"$_directory" = "/proc" ||
		"$_directory" = "/sbin" ||
		"$_directory" = "/usr/bin" ||
		"$_directory" = "/usr/lib" ||
		"$_directory" = "/usr/lib64" ||
		"$_directory" = "/usr/sbin" ||
		"$_directory" = "/srv" ||
		"$_directory" = "/usr" ||
		"$_directory" = "/var" ||
		"$_directory" = "/var/www" ]]; then
		echo "Error: Cannot change $_dir because it is a protected directory.";
		return 2;
	fi

	## Get confirmation
	echo "This will change all permissions for the webserver directories and files and change ownership in:"
	echo "$_directory"

	if ask "Are you sure?" N; then
		#sudo chown -R ${_user}:${_group} "$_directory"
		sudo find "$_directory" -type f -exec chmod $_file_permissions {} \;
		sudo find "$_directory" -type d -name \* -exec chmod $_dir_permissions {} \;
		echo "Done."
	fi
}

# Alias to copy/clone file permissions
function chmodcopy() {
	if [ $# -lt 2 ]; then
	    echo "Usage: chmodcopy [source_file] [destination_file]"
	    return 1
	fi
	chmod --reference="${@}"
}

# Compress a file (even binary files) to the clipboard as base64 text
function file2asc() {
	# If no parameters or file does not exist...
	if [ ${#} -eq 0 ] || [ ! -f "${1}" ]; then
		>&2 echo "Usage: file2asc [filename]"
		exit 1
	fi
	if [[ ! -x "$(command -v gzip)" ]]; then
		>&2 echo "Requires gzip/gunzip"
		exit 1
	fi

	# If xclip is installed...
	if [[ -x "$(command -v xclip)" ]]; then
		\cat "${1}" | gzip -9 | base64 | xclip -selection clipboard
		echo "The clipboard now contains the file: ${1}"

	# If xsel is installed...
	elif [[ -x "$(command -v xsel)" ]]; then
		\cat "${1}" | gzip -9 | base64 | xsel -ib
		echo "The clipboard now contains the file: ${1}"

	# We might have a headless environment with no clipboard...
	else
		# If there is no pager specified like less...
		if [[ -z "$PAGER" ]]; then
			echo printf '=%.0s' {1..80}
			\cat "${1}" | gzip -9 | base64
			echo printf '=%.0s' {1..80}
		else # Use the pager
			# To save text as a file from less, type s then type the file name
			\cat "${1}" | gzip -9 | base64 | "$PAGER"
		fi
	fi

	# Done!
	echo "Use asc2file to convert the base64 ascii text to a file."
}

# Convert compressed base64 clipboard back to a file
function asc2file() {
	# If no parameters...
	if [ ${#} -eq 0 ]; then
		>&2 echo "Usage: asc2file [filename]"
		exit 1
	fi
	if [[ ! -x "$(command -v gunzip)" ]]; then
		>&2 echo "Requires gzip/gunzip"
		exit 1
	fi

	# If xclip is installed...
	if [[ -x "$(command -v xclip)" ]]; then
		xclip -selection clipboard -o | base64 -di | gunzip > ${1}

	# If xsel is installed...
	elif [[ -x "$(command -v xsel)" ]]; then
		xsel -ob | base64 -di | gunzip > ${1}

	# We might have a headless environment with no clipboard...
	else
		echo -e "\033[1;33mPaste the text and press \033[1;36mCTRL+d\033[1;33m when done:\033[0m "
		$(</dev/stdin) | base64 -di | gunzip > ${1}
	fi

	if [[ -x "$(command -v realpath)" ]]; then
		echo "The file was saved: $( \realpath "${1}" )"
	else
		echo "The file was saved: ${1}"
	fi
}

# Fixes permissions in a user's home folder
# If no user is specified, the current user is selected
function fixuserhome() {
	# If no parameter was specified...
	if [[ -z "${@}" ]]; then
		# Use the current user
		local _username="$(whoami)"
	else
		# Use the passed in parameter
		local _username="${@}"
	fi

	# If the home folder doesn't exist...
	if [ ! -d "/home/${_username}" ]; then
		echo "Error: User ${_username} does not have a home folder."
		return 1
	fi

	# Set the hourglass and checkmark characters
	local hourglass="\033[0;33m⌛\033[0m"
	local checkmark="\r\033[1;32m✓\033[0m"

	# Confirm
	if ask "\033[1;31mWARNING:\033[0m Change all permissions for user \033[0;36m${_username}\033[0m's home folder?" N; then
		sudo true # Prompt now instead of later and mess up the progress display

		if ask "Reset group ownership permissions to \033[0;36m${_username}\033[0m?" Y; then
			echo -ne "${hourglass} Set the owner and group as ${_username}"
			sudo chown -R ${_username}:${_username} /home/${_username}
		else
			echo -ne "${hourglass} Set the owner as ${_username}"
			sudo chown -R ${_username} /home/${_username}
		fi
		echo -e "${checkmark}"

		echo -ne "${hourglass} Make sure we have read and write access to all files"
		chmod -R u+rw /home/${_username}
		echo -e "${checkmark}"

		echo -ne "${hourglass} Remove write access from group"
		chmod -R g-w /home/${_username}
		echo -e "${checkmark}"

		echo -ne "${hourglass} Remove all access from others"
		chmod -R o-rwx /home/${_username}
		echo -e "${checkmark}"

		echo -ne "${hourglass} Make .sh shell script files executable"
		#chmod ug+x /home/${_username}/{.,}*.sh # Only in the home folder root
		find /home/${_username} -type f \( -name "*.sh" -o -name ".*.sh" \) -exec chmod ug+x {} \;
		echo -e "${checkmark}"

		echo -ne "${hourglass} Make sure all directories have execute permissions"
		# The X (capital X, NOT small x) is ignored for files but is used for directories
		chmod -R ug+X /home/${_username}
		echo -e "${checkmark}"

		echo -ne "${hourglass} Remove group permissions for directories without group read"
		find /home/${_username} -type d ! -perm -g+r -execdir chmod g-wx {} \;
		echo -e "${checkmark}"

		# If there is a ~/.local/share/kwalletd directory...
		if [[ -d "/home/${_username}/.local/share/kwalletd" ]]; then
			echo -ne "${hourglass} User only access to KDE Wallet keyring"
			chmod -R go-rwx /home/${_username}/.local/share/kwalletd
			echo -e "${checkmark}"
		fi

		# If there is a ~/.local/share/keyrings directory...
		if [[ -d "/home/${_username}/.local/share/keyrings" ]]; then
			echo -ne "${hourglass} User only access to GNOME keyring"
			chmod -R go-rwx /home/${_username}/.local/share/keyrings
			echo -e "${checkmark}"
		fi

		# If there is an .ssh directory...
		if [[ -d "/home/${_username}/.ssh" ]]; then
			echo -ne "${hourglass} User only access to .ssh and private keys"
			chmod -R go-rwx /home/${_username}/.ssh
			echo -e "${checkmark}"
		fi

		# If there is a .putty directory...
		if [[ -d "/home/${_username}/.putty" ]]; then
			echo -ne "${hourglass} User only access to .putty and ssh keys"
			chmod -R go-rwx /home/${_username}/.putty
			echo -e "${checkmark}"
		fi

		# If there is a .pki directory...
		if [[ -d "/home/${_username}/.pki" ]]; then
			echo -ne "${hourglass} User only access to .pki keys and certificates"
			chmod -R go-rwx /home/${_username}/.pki
			echo -e "${checkmark}"
		fi

		# If there is a .gnupg directory...
		if [[ -d "/home/${_username}/.gnupg" ]]; then
			echo -ne "${hourglass} User only access to .gnupg and private keys"
			chmod -R go-rwx /home/${_username}/.gnupg
			echo -e "${checkmark}"
		fi

		# If KeePassXC/KeePass/KeeWeb is installed...
		if [[ -x "$(command -v keepassxc)" ]] || [[ -x "$(command -v keepass)" ]] || [[ -x "$(command -v keeweb)" ]]; then
			echo -ne "${hourglass} User only access to KeePassXC/KeePass/KeeWeb .kdbx files"
			find /home/${_username} -type f \( -name "*.kdbx" -o -name ".*.kdbx" \) -exec chmod go-rwx {} \;
			echo -e "${checkmark}"
		fi

		# If there is a pass directory...
		if [[ -d "/home/${_username}/.password-store" ]]; then
			echo -ne "${hourglass} User only access to pass data"
			chmod -R go-rwx /home/${_username}/.password-store
			echo -e "${checkmark}"
		fi

		# If there is a Bitwarden directory...
		if [[ -d "/home/${_username}/.config/Bitwarden" ]]; then
			echo -ne "${hourglass} User only access to Bitwarden data"
			chmod -R go-rwx /home/${_username}/.config/Bitwarden
			echo -e "${checkmark}"
		fi
		if [[ -d "/home/${_username}/.var/app/com.bitwarden.desktop" ]]; then
			echo -ne "${hourglass} User only access to Bitwarden data (Flatpak)"
			chmod -R go-rwx /home/${_username}/.var/app/com.bitwarden.desktop
			echo -e "${checkmark}"
		fi

		# Check for Tor settings
		if [[ -d "/home/${_username}/.local/share/torbrowser" ]]; then
			echo -ne "${hourglass} User only access to Tor browser data"
			chmod -R go-rwx /home/${_username}/.local/share/torbrowser
			echo -e "${checkmark}"
		fi
		if [[ -d "/home/${_username}/.var/app/com.github.micahflee.torbrowser-launcher" ]]; then
			echo -ne "${hourglass} User only access to Tor browser data (Flatpak)"
			chmod -R go-rwx /home/${_username}/.var/app/com.github.micahflee.torbrowser-launcher
			echo -e "${checkmark}"
		fi

		# Check for Brave settings
		if [[ -d "/home/${_username}/.config/BraveSoftware" ]]; then
			echo -ne "${hourglass} User only access to Brave browser data"
			chmod -R go-rwx /home/${_username}/.config/BraveSoftware
			echo -e "${checkmark}"
		fi
		if [[ -d "/home/${_username}/.var/app/com.brave.Browser" ]]; then
			echo -ne "${hourglass} User only access to Brave browser data (Flatpak)"
			chmod -R go-rwx /home/${_username}/.var/app/com.brave.Browser
			echo -e "${checkmark}"
		fi

		# Check for Chrome settings
		if [[ -d "/home/${_username}/.config/google-chrome" ]]; then
			echo -ne "${hourglass} User only access to Chrome browser data"
			chmod -R go-rwx /home/${_username}/.config/google-chrome
			echo -e "${checkmark}"
		fi
		if [[ -d "/home/${_username}/.var/app/com.google.Chrome" ]]; then
			echo -ne "${hourglass} User only access to Chrome browser data (Flatpak)"
			chmod -R go-rwx /home/${_username}/.var/app/com.google.Chrome
			echo -e "${checkmark}"
		fi

		# Check for Chromium settings
		if [[ -d "/home/${_username}/.config/chromium" ]]; then
			echo -ne "${hourglass} User only access to Chromium browser data"
			chmod -R go-rwx /home/${_username}/.config/chromium
			echo -e "${checkmark}"
		fi
		if [[ -d "/home/${_username}/.var/app/org.chromium.Chromium" ]]; then
			echo -ne "${hourglass} User only access to Chromium browser data (Flatpak)"
			chmod -R go-rwx /home/${_username}/.var/app/org.chromium.Chromium
			echo -e "${checkmark}"
		fi
		if [[ -d "/home/${_username}/.var/app/net.sourceforge.chromium-bsu" ]]; then
			echo -ne "${hourglass} User only access to Ungoogled Chromium browser data (Flatpak)"
			chmod -R go-rwx /home/${_username}/.var/app/net.sourceforge.chromium-bsu
			echo -e "${checkmark}"
		fi

		# Check for Firefox settings
		if [[ -d "/home/${_username}/.mozilla" ]]; then
			echo -ne "${hourglass} User only access to Firefox browser data"
			chmod -R go-rwx /home/${_username}/.mozilla
			echo -e "${checkmark}"
		fi
		if [[ -d "/home/${_username}/.var/app/org.mozilla.firefox" ]]; then
			echo -ne "${hourglass} User only access to Firefox browser data (Flatpak)"
			chmod -R go-rwx /home/${_username}/.var/app/org.mozilla.firefox
			echo -e "${checkmark}"
		fi

		# Check for LibreWolf settings
		if [[ -d "/home/${_username}/.librewolf" ]]; then
			echo -ne "${hourglass} User only access to LibreWolf browser data"
			chmod -R go-rwx /home/${_username}/.librewolf
			echo -e "${checkmark}"
		fi
		if [[ -d "/home/${_username}/.var/app/io.gitlab.librewolf-community" ]]; then
			echo -ne "${hourglass} User only access to LibreWolf browser data (Flatpak)"
			chmod -R go-rwx /home/${_username}/.var/app/io.gitlab.librewolf-community
			echo -e "${checkmark}"
		fi

		# Check for Opera settings
		if [[ -d "/home/${_username}/.config/opera" ]]; then
			echo -ne "${hourglass} User only access to Opera browser data"
			chmod -R go-rwx /home/${_username}/.config/opera
			echo -e "${checkmark}"
		fi

		# Check for Vivaldi settings
		if [[ -d "/home/${_username}/.config/vivaldi" ]]; then
			echo -ne "${hourglass} User only access to Vivaldi browser data"
			chmod -R go-rwx /home/${_username}/.config/vivaldi
			echo -e "${checkmark}"
		fi

		# Check for Evolution settings
		if [[ -d "/home/${_username}/.config/evolution" ]]; then
			echo -ne "${hourglass} User only access to Evolution email data"
			chmod -R go-rwx /home/${_username}/.config/evolution
			echo -e "${checkmark}"
		fi
		if [[ -d "/home/${_username}/.var/app/org.gnome.Evolution" ]]; then
			echo -ne "${hourglass} User only access to Evolution email data (Flatpak)"
			chmod -R go-rwx /home/${_username}/.var/app/org.gnome.Evolution
			echo -e "${checkmark}"
		fi

		# Check for Geary settings
		if [[ -d "/home/${_username}/.local/share/geary" ]]; then
			echo -ne "${hourglass} User only access to Geary email data"
			chmod -R go-rwx /home/${_username}/.local/share/geary
			echo -e "${checkmark}"
		fi
		if [[ -d "/home/${_username}/.var/app/org.gnome.Geary" ]]; then
			echo -ne "${hourglass} User only access to Geary email data (Flatpak)"
			chmod -R go-rwx /home/${_username}/.var/app/org.gnome.Geary
			echo -e "${checkmark}"
		fi

		# Check for Thunderbird settings
		if [[ -d "/home/${_username}/.thunderbird" ]]; then
			echo -ne "${hourglass} User only access to Thunderbird email data"
			chmod -R go-rwx /home/${_username}/.thunderbird
			echo -e "${checkmark}"
		fi
		if [[ -d "/home/${_username}/.var/app/org.mozilla.Thunderbird" ]]; then
			echo -ne "${hourglass} User only access to Thunderbird email data (Flatpak)"
			chmod -R go-rwx /home/${_username}/.var/app/org.mozilla.Thunderbird
			echo -e "${checkmark}"
		fi

		# Check for Element settings
		if [[ -d "/home/${_username}/.config/Element" ]]; then
			echo -ne "${hourglass} User only access to Element chat data"
			chmod -R go-rwx /home/${_username}/.config/Element
			echo -e "${checkmark}"
		fi
		if [[ -d "/home/${_username}/.var/app/im.riot.Riot" ]]; then
			echo -ne "${hourglass} User only access to Element chat data (Flatpak)"
			chmod -R go-rwx /home/${_username}/.var/app/im.riot.Riot
			echo -e "${checkmark}"
		fi

		# Check for Signal settings
		if [[ -d "/home/${_username}/.config/Signal" ]]; then
			echo -ne "${hourglass} User only access to Signal chat data"
			chmod -R go-rwx /home/${_username}/.config/Signal
			echo -e "${checkmark}"
		fi
		if [[ -d "/home/${_username}/.var/app/org.signal.Signal" ]]; then
			echo -ne "${hourglass} User only access to Signal chat data (Flatpak)"
			chmod -R go-rwx /home/${_username}/.var/app/org.signal.Signal
			echo -e "${checkmark}"
		fi

		if [[ -f "/home/${_username}/.config/birthdays.csv" ]]; then
			echo -ne "${hourglass} User only access to birthday/anniversary reminder data"
			chmod 600 /home/${_username}/.config/birthdays.csv
			echo -e "${checkmark}"
		elif [[ -f "${_BDAY_FILE}" ]]; then
			echo -ne "${hourglass} User only access to birthday/anniversary reminder data"
			chmod 600 "${_BDAY_FILE}"
			echo -e "${checkmark}"
		fi

		# [OPTIONAL] Copy group permissions to other
		#echo -ne "${hourglass} Copy group permissions to other"
		#chmod -R o=g /home/${_username}
		#echo -e "${checkmark}"

		# [OPTIONAL] Copy user permissions to group
		#echo -ne "${hourglass} Copy user permissions to group"
		#chmod -R g=u /home/${_username}
		#echo -e "${checkmark}"

		# Set the setgid bit, so that files/folder under the directory
		# will be created with the same group as <directory>
		echo -ne "${hourglass} Set the setgid bit to inherit folder permissions"
		chmod g+s /home/${_username}
		echo -e "${checkmark}"

		# If Access Control Lists (ACL) is installed...
		# To "activate" ACL, you have to remount the drive with the "acl" option
		# NOTE: Btrfs and Xfs filesystem use the ACL mount option by default
		# Example /etc/fstab Entry:
		# UUID=abc123def456 / ext4 defaults,acl 0 1
		# Type "man acl" for more information
		if [[ -x "$(command -v setfacl)" ]]; then
			# Use getfacl [directory] to check ACL for these directories
			echo -ne "${hourglass} Modify default ACL entries"
			setfacl -d -m u::rwx /home/${_username}
			setfacl -d -m g::rx /home/${_username}
			setfacl -d -m o::X /home/${_username}
			echo -e "${checkmark}"
		fi

		echo "Done!"
	else
		return 0
	fi
}

# Copy over configuration settings from one account to root/default/another
function configcopy() {
	if [ -z "${1}" ] || [ -z "${2}" ]; then
		echo -e "Usage: \033[1;32mcopyconfig [from_user] [to_user]\033[0m"
		echo -ne "Users can be \033[1;36mroot\033[0m, \033[1;36mdefault\033[0m (/etc/skel), or users \033[1;36m"
		cut -d: -f1,3 /etc/passwd | egrep ':[0-9]{4}$' | cut -d: -f1 | tr '\n' ' ' | tr -d '[:space:]'
		echo -e "\033[0m."
		return
	elif [ "${1}" == "${2}" ]; then
		echo -e "\033[1;31mError:\033[0m The from and to user parameters cannot be the same."
		return 2
	elif [ ! -d "/home/${1}" ] && [ "${1}" != "root" ] && [ "${1}" != "default" ]; then
		echo -e "\033[1;31mError:\033[0m User ${1} does not exist."
		return 1
	elif [ ! -d "/home/${2}" ] && [ "${2}" != "root" ] && [ "${2}" != "default" ]; then
		echo -e "\033[1;31mError:\033[0m User ${2} does not exist."
		return 1
	elif [ "${1}" == "default" ] && [ "${2}" == "root" ]; then
		dirfrom=/etc/skel/
		dirto=/root/
		owner=root
	elif [ "${1}" == "default" ]; then
		dirfrom=/etc/skel/
		dirto=/home/"${2}"/
		owner="${2}"
	elif [ "${2}" == "default" ] && [ "${1}" == "root" ]; then
		dirfrom=/root/
		dirto=/etc/skel/
		owner=root
	elif [ "${2}" == "default" ]; then
		dirfrom=/home/"${1}"/
		dirto=/etc/skel/
		owner=root
	elif [ "${1}" == "root" ]; then
		dirfrom=/root/
		dirto=/home/"${2}"/
		owner="${2}"
	elif [ "${2}" == "root" ]; then
		dirfrom=/home/"${1}"/
		dirto=/root/
		owner=root
	else
		dirfrom=/home/"${1}"/
		dirto=/home/"${2}"/
		owner="${2}"
	fi

	# Ask for confirmation
	if ! ask "Are you sure? This will overwrite configuration files in ${dirto%/}" N; then
		return
	fi

	# Add any additional files here
	declare -a files
	[ -f "${dirfrom}.bash_logout" ]  && files+=(".bash_logout")
	[ -f "${dirfrom}.bash_profile" ] && files+=(".bash_profile")
	[ -f "${dirfrom}.bashrc" ]       && files+=(".bashrc")
	[ -f "${dirfrom}.bashrc_help" ]  && files+=(".bashrc_help")
	[ -f "${dirfrom}.inputrc" ]      && files+=(".inputrc")
	[ -f "${dirfrom}.nanorc" ]       && files+=(".nanorc")
	[ -f "${dirfrom}.p10k.zsh" ]     && files+=(".p10k.zsh")
	[ -f "${dirfrom}.screenrc" ]     && files+=(".screenrc")
	[ -f "${dirfrom}.vimrc" ]        && files+=(".vimrc")
	[ -f "${dirfrom}.Xauthority" ]   && files+=(".Xauthority")
	[ -f "${dirfrom}.zshrc" ]        && files+=(".zshrc")

	# Loop through and copy the files over
	for file in "${files[@]}"; do
		sudo \cp "${dirfrom}""${file}" "${dirto}" 2>/dev/null || :
		sudo chown "${owner}":"${owner}" "${dirto}""${file}"
		echo -e "\033[1;32m✓\033[0m Copied file: \033[1;36m${file}\033[0m"
	done

	# Copy other Extreme Ultimate bashrc settings
	if [[ -d "${dirfrom}".config/bashrc ]]; then
		sudo mkdir -p ${dirto}.config
		sudo \cp -R "${dirfrom}".config/bashrc "${dirto}".config/ 2>/dev/null
		echo -e "\033[1;32m✓\033[0m Copied files: \033[1;36mBashrc Config\033[0m"
	fi

	# Fish
	if [[ -d "${dirfrom}".config/fish ]]; then
		sudo mkdir -p ${dirto}.config
		sudo \cp -R "${dirfrom}".config/fish "${dirto}".config/ 2>/dev/null
		echo -e "\033[1;32m✓\033[0m Copied files: \033[1;36mFish\033[0m"
	fi

	# Micro (skip backups and buffers directories)
	if [[ -f "${dirfrom}".config/micro/settings.json ]]; then
		sudo mkdir -p ${dirto}.config/micro
		sudo \cp "${dirfrom}".config/micro/settings.json "${dirto}".config/micro/settings.json 2>/dev/null
		sudo \cp "${dirfrom}".config/micro/bindings.json "${dirto}".config/micro/bindings.json 2>/dev/null
		sudo \cp -R "${dirfrom}".config/micro/plug "${dirto}".config/micro/ 2>/dev/null
		echo -e "\033[1;32m✓\033[0m Copied files: \033[1;36mMicro\033[0m"
	fi

	# Tmux
	sudo \cp -R "${dirfrom}".tmux* "${dirto}" 2>/dev/null
	if [[ -e "${dirto}".tmux.conf ]]; then
		sudo chown "${owner}":"${owner}" "${dirto}".tmux.conf
		echo -e "\033[1;32m✓\033[0m Copied files: \033[1;36mTmux\033[0m"
	fi
	if [[ -d "${dirto}".tmux ]]; then
		sudo chown -R "${owner}":"${owner}" "${dirto}".tmux
	fi

	# We are done
	echo -e "Owner set to: \033[1;35m${owner}\033[0m"
	echo -e "\033[1;33mFinished\033[0m copying configuation files from \033[1;34m${dirfrom%/}\033[0m to \033[1;34m${dirto%/}\033[0m"
	return
}

# When executed, will toggle the hosts file on and off
function hoststoggle() {
	# Confirm we want to do this...
	if ask "Are you sure you wish to modify the hosts file?" N; then

		# If the hosts backup file exists, restore it
		if [ -f /etc/hosts.backup_temporary ]; then
			sudo \rm -f /etc/hosts
			sudo \mv /etc/hosts.backup_temporary /etc/hosts
			sudo chmod 644 /etc/hosts
			echo -e "\033[1;34mHosts file \033[1;32mrestored\033[1;34m.\033[0m"
			echo -e "(File is $(sudo cat /etc/hosts | wc -l) lines long.)"
			sudo head -16 /etc/hosts

		# Make a backup of the hosts file
		elif [ -f /etc/hosts ]; then
			sudo \mv /etc/hosts /etc/hosts.backup_temporary

			# Replaces the hosts file with a generic empty hosts file
			sudo bash -c 'printf "#\n# /etc/hosts: static lookup table for host names\n#\n\n127.0.0.1       localhost\n255.255.255.255 broadcasthost\n::1             localhost\n::1             ip6-localhost ip6-loopback\nfe00::0         ip6-localnet\nff00::0         ip6-mcastprefix\nff02::1         ip6-allnodes\nff02::2         ip6-allrouters\nff02::3         ip6-allhosts\n" >> /etc/hosts'

			sudo chmod 644 /etc/hosts
			echo -e "\033[1;34mHosts file \033[1;31mdisabled\033[1;34m.\033[0m"

		# Supports hBlock - A POSIX-compliant shell script that gets a list of domains
		# that serve ads, tracking scripts and malware from multiple sources and creates
		# a hosts file, among other formats, that prevents your system from connecting
		# to them. See https://github.com/hectorm/hblock
		elif [ -x "$(command -v hblock)" ]; then
			if [ -f /etc/hosts.personal ]; then
				sudo /usr/bin/hblock --header /etc/hosts.personal
			else
				sudo /usr/bin/hblock
			fi
			sudo chmod 644 /etc/hosts
			echo -e "\033[1;34mHosts file \033[1;33mrecreated\033[1;34m.\033[0m"

		# No hosts file was found
		else
			echo -e "\033[1;31mERROR:\033[1;37m Hosts file and backup not found.\033[0m"
		fi
	fi
}

# For some reason, rot13 pops up everywhere
function rot13() {
	if [[ $# -eq 0 ]]; then
		tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
	else
		echo $* | tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
	fi
}

# Trim leading and trailing spaces
function trim() {
	local var=$@
	var="${var#"${var%%[![:space:]]*}"}"  # remove leading whitespace characters
	var="${var%"${var##*[![:space:]]}"}"  # remove trailing whitespace characters
	echo -n "$var"
}

#######################################################
# Show the initial information HUD on initial Bash load
#######################################################

# If we are NOT root or in a virtual terminal console or TMUX or Git Bash...
if [[ $EUID -ne 0 ]] && \
	[[ ! "$(tty)" =~ /dev/tty ]] && \
	[[ ! "$TERM" =~ screen ]] && \
	[[ -z "$TMUX" ]] && \
	[[ "$_KERNEL_NAME" != "MINGW" ]] && \
	[[ "$_KERNEL_NAME" != "CYGWI" ]] && \
	[[ $_SKIP_SYSTEM_INFO = false ]]; then

	# Link: https://github.com/LinusDierheimer/fastfetch
	if [[ -x "$(command -v fastfetch)" ]]; then
		fastfetch

	# Link: https://ostechnix.com/neofetch-display-linux-systems-information/
	elif [[ -x "$(command -v neofetch)" ]]; then
		neofetch
		printf '\e[A\e[K' # Move the cursor up one line

	# Link: https://github.com/KittyKatt/screenFetch
	elif [[ -x "$(command -v screenfetch)" ]]; then
		screenfetch

	# Link: https://github.com/deater/linux_logo
	elif [[ -x "$(command -v linuxlogo)" ]]; then
		linuxlogo

	# Link: https://lclarkmichalek.github.io/archey3/
	elif [[ -x "$(command -v archey)" ]]; then
		archey

	# Link: https://github.com/dylanaraps/pfetch
	elif [[ -f "$HOME/pfetch.sh" ]]; then
		"$HOME/pfetch.sh"
	elif [[ -x "$(command -v pfetch.sh)" ]]; then
		pfetch.sh
	fi
fi

#######################################################
# Show text or ASCII on initial Bash load
# Create ASCII: jp2a --color ~/input_image.jpg > ~/.bash_motd_shown
# Test: cat ~/.bash_motd_shown
#######################################################

# If the file exists and we are NOT root...
if [[ -f "$HOME/.bash_motd_shown" ]] && [[ $EUID -ne 0 ]]; then

	# Show the ASCII text or image
	cat "$HOME/.bash_motd_shown"
fi

#######################################################
# Show upgrade information on new terminal windows
# Note: This is disabled by default because it takes several seconds to run
#######################################################

if [[ $_SKIP_UPGRADE_NOTIFY = false ]]; then

	# If this is an Arch based distrobution...
	# Add to your crontab (this runs every 3 hours): 0 */3 * * * /usr/bin/pacman -Sy
	if [[ -x "$(command -v pacman)" ]] && [[ -x "$(command -v paccache)" ]]; then

		# Show if there are updates available
		_PACKAGE_UPDATE_COUNT=$(pacman -Q --upgrades | wc -l)
		if [[ "$_PACKAGE_UPDATE_COUNT" -gt "0" ]]; then
			echo -e "\033[1;33m*\033[0m \033[0;32mThere are\033[0m \033[1;37m"$_PACKAGE_UPDATE_COUNT"\033[0m \033[0;32mavaliable program updates\033[0m"
			echo -e "\033[1;30m*\033[0m \033[0;36mType\033[0m \033[1;35mpacman -Qu\033[0m \033[0;36mfor more information\033[0m"
			echo
		fi

	# If this is an Ubuntu based distro...
	# Add to your crontab (this runs every 3 hours): 0 */3 * * * /usr/bin/apt update
	elif [[ -x "/usr/lib/update-notifier/apt-check" ]]; then

		# Show if there are updates available
		IFS=';' read _PACKAGE_UPDATE_COUNT _PACKAGE_SECURITY_UPDATE_COUNT < <(/usr/lib/update-notifier/apt-check 2>&1)
		if [[ "$_PACKAGE_UPDATE_COUNT" -gt "0" ]]; then
			echo -e "\033[1;33m*\033[0m \033[0;32mThere are\033[0m \033[1;37m"$_PACKAGE_UPDATE_COUNT"\033[0m \033[0;32mavaliable program updates\033[0m"
		fi
		if [[ "$_PACKAGE_SECURITY_UPDATE_COUNT" -gt "0" ]]; then
			echo -e "\033[1;30m*\033[0m \033[0;36mThere are\033[0m \033[1;35m"$_PACKAGE_SECURITY_UPDATE_COUNT"\033[0m \033[0;36msecurity updates.\033[0m"
		fi
		if [[ "$_PACKAGE_UPDATE_COUNT" -gt "0" ]] || [[ "$_PACKAGE_SECURITY_UPDATE_COUNT" -gt "0" ]]; then
			echo
		fi
	fi
fi

################################################################################
# Birthday/anniversary reminder that shows a message in your teminal
# Reads the birthday CSV file: ~/.config/birthdays.csv
# The format is (year is optional and can be left blank):
# Month,Day,Year,"Message"
# Jan,1,2000,"This is a message!"
#
# Toilet application is a required dependency
# Arch/Manjaro:  sudo pacman -S toilet
# Ubuntu/Debian: sudo apt-get install toilet
################################################################################

# Make an alias to edit the birthday csv file
if [[ -f "${HOME}/.config/birthdays.csv" ]]; then
	alias ebd="edit ~/.config/birthdays.csv"
elif [[ -f "${_BDAY_FILE}" ]]; then
	alias ebd="edit ${_BDAY_FILE}"
fi

# Show a birthday or anniversary reminder
function birthday() {
	# Use extended globbing for more advanced pattern matching
	# This is also necessary for programmable completion
	shopt -s extglob

	# If the birthday CSV file exists and toilet is installed...
	if [[ $_SKIP_BDAY_REMINDER = false ]] && [[ -f "${_BDAY_FILE}" ]]; then

		# Loop through the birthday CSV file: ~/.config/birthdays.csv
		# The first line is ignored (header) and the format is:
		# Month,Day,Year,"Message"
		# Jan,1,1985,"This is a message!"
		while IFS=, read -r _BDAY_MONTH _BDAY_DAY _BDAY_YEAR _BDAY_MESSAGE; do

			# Compare the month (case insensitive) and the day (remove leading zeros)
			if [[ "$(date +%^b)" = "${_BDAY_MONTH^^}" ]] && [[ "$(date +%-d)" = "${_BDAY_DAY##+(0)}" ]]; then

				# Remove the surrounding quotes from the message
				_BDAY_MESSAGE="${_BDAY_MESSAGE%\"}"
				_BDAY_MESSAGE="${_BDAY_MESSAGE#\"}"

				# Show the message using toilet and the future font
				if [[ -x "$(command -v toilet)" ]]; then
					toilet --font="${_BDAY_FONT}" --termwidth --gay "${_BDAY_MESSAGE}"
				elif [[ -x "$(command -v lolcat)" ]]; then
					echo "${_BDAY_MESSAGE}" | lolcat --spread=0.4
				else
					echo -e "\033[1;36m${_BDAY_MESSAGE}\033[0m"
				fi

				# If the year is a number and not blank...
				if [ -n "${_BDAY_YEAR}" ] && [ "${_BDAY_YEAR}" -eq "${_BDAY_YEAR}" ] 2>/dev/null; then
					echo -e "\033[1;33m$(( ($(date +%s) - $(date --date="${_BDAY_MONTH} ${_BDAY_DAY} ${_BDAY_YEAR}" +%s))/(60*60*24)/365 ))\033[0m Years"
				fi

				#echo ""
			fi

		# Strip off the first line in the CSV file
		done < <(tail -n +2 "${_BDAY_FILE}")
	fi
}

# If we aren't supposed to skip this...
if [[ $_SKIP_BDAY_REMINDER = false ]]; then
	# Call the birthday function
	birthday
fi

#######################################################
# Show the calendar when Bash starts
#######################################################

if [[ $_SHOW_BASH_CALENDAR = true ]]; then
	if [[ -x "$(command -v gcal)" ]]; then
		gcal -H '\e[34m:\e[0m:\e[32m:\e[0m' -q "${_GCAL_COUNTRY_CODE}"
	else
		cal -3
	fi
fi

#######################################################
# bashmarks Directory Bookmarks
# Link: https://github.com/huyng/bashmarks
# Install: git clone git://github.com/huyng/bashmarks.git
# s <bookmark_name> - Saves the current directory as "bookmark_name"
# g <bookmark_name> - Goes (cd) to the directory associated with "bookmark_name"
# p <bookmark_name> - Prints the directory associated with "bookmark_name"
# d <bookmark_name> - Deletes the bookmark
# l                 - Lists all available bookmarks
#######################################################

# If bashmarks is installed, load it
if [[ -f "$HOME/bashmarks/bashmarks.sh" ]]; then
	source "$HOME/bashmarks/bashmarks.sh"
elif [[ -f "$HOME/.local/bin/bashmarks.sh" ]]; then
	source "$HOME/.local/bin/bashmarks.sh"
elif [[ -f /usr/share/bashmarks/bashmarks.sh ]]; then
	source /usr/share/bashmarks/bashmarks.sh
fi

#######################################################
# Zoxide is a smarter cd command (inspired by z and autojump)
# Link: https://github.com/ajeetdsouza/zoxide
# Install: curl -sS https://webinstall.dev/zoxide | bash
#######################################################

if [[ -x "$(command -v zoxide)" ]]; then
	eval "$(zoxide init bash)"
fi

#######################################################
# commacd Improved cd
# Link: https://github.com/shyiko/commacd
# Install: curl -sSL https://github.com/shyiko/commacd/raw/v1.0.0/commacd.sh -o ~/.commacd.sh
#######################################################

# If commacd is installed
if [[ -f "$HOME/.commacd.sh" ]]; then
	source "$HOME/.commacd.sh"
elif [[ -f /usr/share/commacd/commacd.bash ]]; then
	source /usr/share/commacd/commacd.bash
fi

#######################################################
# Improve navigation and searching your command history
#######################################################

# Search command line history
alias h='history | grep'

# HSTR Easily navigate and search your command history and favorites
# (has favorites, syncs across shells, does not require an extra database, but does not show the time since a command)
# Link: https://github.com/dvorka/hstr
# Manual: man hstr
if [[ -x "$(command -v hstr)" ]]; then

	# Alias hh for hstr
	alias hh='hstr'

	# Get more colors
	export HSTR_CONFIG=hicolor

	# Bind hstr to CTRL-r (for Vi mode check doc)
	bind '"\C-r": "\C-a hstr -- \C-j"'

	# Bind 'kill last command' to CTRL-x k
	bind '"\C-xk": "\C-a hstr -k \C-j"'

# McFly - fly through your shell history using a small neural network
# (shows the time since the command, but does not have favorites, and has issues syncing history across multiple shells)
# NOTE: You can type % to match any number of characters when searching
# Link: https://github.com/cantino/mcfly
# Install: curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly
elif [[ -x "$(command -v mcfly)" ]]; then

	# Initialize McFly
	eval "$(mcfly init bash)"

	# Alias hh for McFly
	alias hh='mcfly search'

	# Enable fuzzy searching
	export MCFLY_FUZZY=2

	# Change the maximum number of results shown (default: 10)
	export MCFLY_RESULTS=60

	# To swap the color scheme for use in a light terminal, change this
	export MCFLY_LIGHT=FALSE

# Rich Enhanced Shell History (resh) Context-based replacement/enhancement for zsh and bash shell history
# (shows more information, has raw mode, but uses own database, does not have favorites, can't delete history)
# Link: https://github.com/curusarn/resh
# Install: (git clone https://github.com/curusarn/resh.git && cd resh && scripts/rawinstall.sh)
# Update: reshctl update
# WARNING: Install automatically adds lines to the end of the ~/.bashrc file
elif [[ -f ~/.resh/shellrc ]]; then

	# Source the scripts
	source ~/.resh/shellrc
	[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

	# Bind 'kill last command' to CTRL-x k
	bind '"\C-xk": "\C-a hstr -k \C-j"'

	# Alias hh for resh
	alias hh='resh'

fi

#######################################################
# qfc Command Line File Completion (Ctrl-F to list files)
# Link: https://github.com/pindexis/qfc
# Install: git clone https://github.com/pindexis/qfc $HOME/.qfc
#######################################################

# If qfc is installed, run it's initiation script
# Ctrl-f will pop up to select directories or files
# Ctrl-/ to cd into directory using qfc
if [[ -f "$HOME/.qfc/bin/qfc.sh" ]]; then
	source "$HOME/.qfc/bin/qfc.sh"
	qfc_quick_command 'cd' '\C-_' 'cd "$0"'
elif [[ -f /usr/share/qfc/qfc.sh ]]; then
	source /usr/share/qfc/qfc.sh
	qfc_quick_command 'cd' '\C-_' 'cd "$0"'
fi

#######################################################
# Settings and Exports
#######################################################

# Make sure 256 color terminals are enabled
# export TERM=xterm-256color
# Linux tries very hard to set it to a sane value depending on things
# like which terminal you are actually using and how you are connected
# You can override a particular value which the login process
# often chooses but which is not to your liking
case $TERM in "") TERM=xterm-256color;; esac

# For use with LS_COLORS
export use_color=true

# Tell NCURSES to use UTF-8 encoding
export NCURSES_NO_UTF8_ACS=1

# Upgrade less command functionality
alias les='\less -f -r -n -F'
if [[ -x "$(command -v moar)" ]]; then
	# Use moar
	# Link: https://github.com/walles/moar
	export PAGER='moar'
	export MANPAGER='moar'
	alias less='moar' # I love the irony
	alias les='moar -no-linenumbers'
elif [[ -n "$LESSOPEN" ]]; then
	# Use less over most if it has syntax highlighting
	export PAGER='less'
	export MANPAGER='less'
elif [[ -x "$(command -v most)" ]]; then
	# Use most
	# Link: https://www.jedsoft.org/most/
	export PAGER='most'
	export MANPAGER='most'
	alias less='most'
else
	export PAGER='less'
	export MANPAGER='less'
fi

# If bat is installed...
# https://github.com/sharkdp/bat
if [[ -x "$(command -v batcat)" ]]; then
	export PAGER='less' # Bat expects and uses less
	export MANPAGER='batcat --style=plain'
	alias bat='batcat --force-colorization'
elif [[ -x "$(command -v bat)" ]]; then
	export PAGER='less' # Bat expects and uses less
	export MANPAGER='bat --style=plain'
	alias bat='bat --force-colorization'
fi

# If bat-extras is installed with the extra commands:
# batgrep, batman, batpipe, batwatch, batdiff, prettybat
# Link: https://github.com/eth-p/bat-extras
if [[ -x "$(command -v batman)" ]]; then
	alias man='batman'
fi

# ccat is the colorizing cat
# Link: https://github.com/owenthereal/ccat
if [[ -x "$(command -v ccat)" ]]; then
	alias cat='ccat'
fi

# Color for manpages in less makes manpages a little easier to read
if [[ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ]]; then
	export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
elif [[ -x "$(command -v src-hilite-lesspipe.sh)" ]]; then
	export LESSOPEN="| src-hilite-lesspipe.sh %s"
fi

# NOTE: Use \less with the back-slash to remove line numbers
# or you can use -n or --line-numbers if moar/most are not installed
export LESS='-x4 --ignore-case --RAW-CONTROL-CHARS --LONG-PROMPT --prompt=%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#######################################################
# Vivid LS_COLORS Generator
# Link: https://github.com/sharkdp/vivid
# Themes: https://github.com/sharkdp/vivid/tree/master/themes
#######################################################
# LS_COLORS (lscolors-git in Arch AUR repository)
# Link: https://github.com/trapd00r/LS_COLORS
# Install:
# mkdir /tmp/LS_COLORS && curl -L https://api.github.com/repos/trapd00r/LS_COLORS/tarball/master | tar xzf - --directory=/tmp/LS_COLORS --strip=1
# ( cd /tmp/LS_COLORS && sh install.sh )
#######################################################

# Colors for ls
export CLICOLOR=1

if [[ -x "$(command -v vivid)" ]]; then
	# Vivid is installed
	export LS_COLORS="$(vivid generate snazzy)"
	_LS_COLORS_SOURCE="Vivid"
elif [[ -f "$HOME/.local/share/lscolors.sh" ]]; then
	# LS_COLORS is installed locally
	source "$HOME/.local/share/lscolors.sh"
	_LS_COLORS_SOURCE="LS_COLORS Local"
elif [[ -f /usr/share/LS_COLORS/dircolors.sh ]]; then
	# LS_COLORS is installed system wide
	source /usr/share/LS_COLORS/dircolors.sh
	_LS_COLORS_SOURCE="LS_COLORS System Wide"
elif [[ -x /usr/bin/dircolors ]]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	_LS_COLORS_SOURCE="dircolors"
else
	# Export a custom ls color profile based on LS_COLORS
	export LS_COLORS='bd=38;5;68:ca=38;5;17:cd=38;5;113;1:di=38;5;30:do=38;5;127:ex=38;5;208;1:pi=38;5;126:fi=0:ln=target:mh=38;5;222;1:no=0:or=48;5;196;38;5;232;1:ow=38;5;220;1:sg=48;5;3;38;5;0:su=38;5;220;1;3;100;1:so=38;5;197:st=38;5;86;48;5;234:tw=48;5;235;38;5;139;3:*LS_COLORS=48;5;89;38;5;197;1;3;4;7:*.txt=38;5;253:*README=38;5;220;1:*README.rst=38;5;220;1:*README.md=38;5;220;1:*LICENSE=38;5;220;1:*COPYING=38;5;220;1:*INSTALL=38;5;220;1:*COPYRIGHT=38;5;220;1:*AUTHORS=38;5;220;1:*HISTORY=38;5;220;1:*CONTRIBUTORS=38;5;220;1:*PATENTS=38;5;220;1:*VERSION=38;5;220;1:*NOTICE=38;5;220;1:*CHANGES=38;5;220;1:*.log=38;5;190:*.adoc=38;5;184:*.asciidoc=38;5;184:*.etx=38;5;184:*.info=38;5;184:*.markdown=38;5;184:*.md=38;5;184:*.mkd=38;5;184:*.nfo=38;5;184:*.org=38;5;184:*.pod=38;5;184:*.rst=38;5;184:*.tex=38;5;184:*.textile=38;5;184:*.bib=38;5;178:*.json=38;5;178:*.jsonl=38;5;178:*.jsonnet=38;5;178:*.libsonnet=38;5;142:*.ndjson=38;5;178:*.msg=38;5;178:*.pgn=38;5;178:*.rss=38;5;178:*.xml=38;5;178:*.fxml=38;5;178:*.toml=38;5;178:*.yaml=38;5;178:*.yml=38;5;178:*.RData=38;5;178:*.rdata=38;5;178:*.xsd=38;5;178:*.dtd=38;5;178:*.sgml=38;5;178:*.rng=38;5;178:*.rnc=38;5;178:*.accdb=38;5;60:*.accde=38;5;60:*.accdr=38;5;60:*.accdt=38;5;60:*.db=38;5;60:*.fmp12=38;5;60:*.fp7=38;5;60:*.localstorage=38;5;60:*.mdb=38;5;60:*.mde=38;5;60:*.sqlite=38;5;60:*.typelib=38;5;60:*.nc=38;5;60:*.cbr=38;5;141:*.cbz=38;5;141:*.chm=38;5;141:*.djvu=38;5;141:*.pdf=38;5;141:*.PDF=38;5;141:*.mobi=38;5;141:*.epub=38;5;141:*.docm=38;5;111;4:*.doc=38;5;111:*.docx=38;5;111:*.odb=38;5;111:*.odt=38;5;111:*.rtf=38;5;111:*.pages=38;5;111:*.odp=38;5;166:*.pps=38;5;166:*.ppt=38;5;166:*.pptx=38;5;166:*.ppts=38;5;166:*.pptxm=38;5;166;4:*.pptsm=38;5;166;4:*.csv=38;5;78:*.tsv=38;5;78:*.numbers=38;5;112:*.ods=38;5;112:*.xla=38;5;76:*.xls=38;5;112:*.xlsx=38;5;112:*.xlsxm=38;5;112;4:*.xltm=38;5;73;4:*.xltx=38;5;73:*.key=38;5;166:*config=1:*cfg=1:*conf=1:*rc=1:*authorized_keys=1:*known_hosts=1:*.ini=1:*.plist=1:*.profile=1:*.bash_profile=1:*.bash_login=1:*.bash_logout=1:*.zshenv=1:*.zprofile=1:*.zlogin=1:*.zlogout=1:*.viminfo=1:*.pcf=1:*.psf=1:*.hidden-color-scheme=1:*.hidden-tmTheme=1:*.last-run=1:*.merged-ca-bundle=1:*.sublime-build=1:*.sublime-commands=1:*.sublime-keymap=1:*.sublime-settings=1:*.sublime-snippet=1:*.sublime-project=1:*.sublime-workspace=1:*.tmTheme=1:*.user-ca-bundle=1:*.rstheme=1:*.epf=1:*.git=38;5;197:*.gitignore=38;5;240:*.gitattributes=38;5;240:*.gitmodules=38;5;240:*.awk=38;5;172:*.bash=38;5;172:*.bat=38;5;172:*.BAT=38;5;172:*.sed=38;5;172:*.sh=38;5;172:*.zsh=38;5;172:*.vim=38;5;172:*.kak=38;5;172:*.ahk=38;5;41:*.py=38;5;41:*.ipynb=38;5;41:*.xsh=38;5;41:*.rb=38;5;41:*.gemspec=38;5;41:*.pl=38;5;208:*.PL=38;5;160:*.pm=38;5;203:*.t=38;5;114:*.msql=38;5;222:*.mysql=38;5;222:*.pgsql=38;5;222:*.sql=38;5;222:*.tcl=38;5;64;1:*.r=38;5;49:*.R=38;5;49:*.gs=38;5;81:*.clj=38;5;41:*.cljs=38;5;41:*.cljc=38;5;41:*.cljw=38;5;41:*.scala=38;5;41:*.sc=38;5;41:*.dart=38;5;51:*.asm=38;5;81:*.cl=38;5;81:*.lisp=38;5;81:*.rkt=38;5;81:*.el=38;5;81:*.elc=38;5;241:*.eln=38;5;241:*.lua=38;5;81:*.moon=38;5;81:*.c=38;5;81:*.C=38;5;81:*.h=38;5;110:*.H=38;5;110:*.tcc=38;5;110:*.c++=38;5;81:*.h++=38;5;110:*.hpp=38;5;110:*.hxx=38;5;110:*.ii=38;5;110:*.M=38;5;110:*.m=38;5;110:*.cc=38;5;81:*.cs=38;5;81:*.cp=38;5;81:*.cpp=38;5;81:*.cxx=38;5;81:*.cr=38;5;81:*.go=38;5;81:*.f=38;5;81:*.F=38;5;81:*.for=38;5;81:*.ftn=38;5;81:*.f90=38;5;81:*.F90=38;5;81:*.f95=38;5;81:*.F95=38;5;81:*.f03=38;5;81:*.F03=38;5;81:*.f08=38;5;81:*.F08=38;5;81:*.nim=38;5;81:*.nimble=38;5;81:*.s=38;5;110:*.S=38;5;110:*.rs=38;5;81:*.scpt=38;5;219:*.swift=38;5;219:*.sx=38;5;81:*.vala=38;5;81:*.vapi=38;5;81:*.hi=38;5;110:*.hs=38;5;81:*.lhs=38;5;81:*.agda=38;5;81:*.lagda=38;5;81:*.lagda.tex=38;5;81:*.lagda.rst=38;5;81:*.lagda.md=38;5;81:*.agdai=38;5;110:*.zig=38;5;81:*.v=38;5;81:*.pyc=38;5;240:*.tf=38;5;168:*.tfstate=38;5;168:*.tfvars=38;5;168:*.css=38;5;125;1:*.less=38;5;125;1:*.sass=38;5;125;1:*.scss=38;5;125;1:*.htm=38;5;125;1:*.html=38;5;125;1:*.jhtm=38;5;125;1:*.mht=38;5;125;1:*.eml=38;5;125;1:*.mustache=38;5;125;1:*.coffee=38;5;074;1:*.java=38;5;074;1:*.js=38;5;074;1:*.mjs=38;5;074;1:*.jsm=38;5;074;1:*.jsp=38;5;074;1:*.php=38;5;81:*.ctp=38;5;81:*.twig=38;5;81:*.vb=38;5;81:*.vba=38;5;81:*.vbs=38;5;81:*Dockerfile=38;5;155:*.dockerignore=38;5;240:*Makefile=38;5;155:*MANIFEST=38;5;243:*pm_to_blib=38;5;240:*.nix=38;5;155:*.dhall=38;5;178:*.rake=38;5;155:*.am=38;5;242:*.in=38;5;242:*.hin=38;5;242:*.scan=38;5;242:*.m4=38;5;242:*.old=38;5;242:*.out=38;5;242:*.SKIP=38;5;244:*.diff=48;5;197;38;5;232:*.patch=48;5;197;38;5;232;1:*.bmp=38;5;97:*.dicom=38;5;97:*.tiff=38;5;97:*.tif=38;5;97:*.TIFF=38;5;97:*.cdr=38;5;97:*.flif=38;5;97:*.gif=38;5;97:*.icns=38;5;97:*.ico=38;5;97:*.jpeg=38;5;97:*.JPG=38;5;97:*.jpg=38;5;97:*.nth=38;5;97:*.png=38;5;97:*.psd=38;5;97:*.pxd=38;5;97:*.pxm=38;5;97:*.xpm=38;5;97:*.webp=38;5;97:*.ai=38;5;99:*.eps=38;5;99:*.epsf=38;5;99:*.drw=38;5;99:*.ps=38;5;99:*.svg=38;5;99:*.avi=38;5;114:*.divx=38;5;114:*.IFO=38;5;114:*.m2v=38;5;114:*.m4v=38;5;114:*.mkv=38;5;114:*.MOV=38;5;114:*.mov=38;5;114:*.mp4=38;5;114:*.mpeg=38;5;114:*.mpg=38;5;114:*.ogm=38;5;114:*.rmvb=38;5;114:*.sample=38;5;114:*.wmv=38;5;114:*.3g2=38;5;115:*.3gp=38;5;115:*.gp3=38;5;115:*.webm=38;5;115:*.gp4=38;5;115:*.asf=38;5;115:*.flv=38;5;115:*.ts=38;5;115:*.ogv=38;5;115:*.f4v=38;5;115:*.VOB=38;5;115;1:*.vob=38;5;115;1:*.ass=38;5;117:*.srt=38;5;117:*.ssa=38;5;117:*.sub=38;5;117:*.sup=38;5;117:*.vtt=38;5;117:*.3ga=38;5;137;1:*.S3M=38;5;137;1:*.aac=38;5;137;1:*.amr=38;5;137;1:*.au=38;5;137;1:*.caf=38;5;137;1:*.dat=38;5;137;1:*.dts=38;5;137;1:*.fcm=38;5;137;1:*.m4a=38;5;137;1:*.mod=38;5;137;1:*.mp3=38;5;137;1:*.mp4a=38;5;137;1:*.oga=38;5;137;1:*.ogg=38;5;137;1:*.opus=38;5;137;1:*.s3m=38;5;137;1:*.sid=38;5;137;1:*.wma=38;5;137;1:*.ape=38;5;136;1:*.aiff=38;5;136;1:*.cda=38;5;136;1:*.flac=38;5;136;1:*.alac=38;5;136;1:*.mid=38;5;136;1:*.midi=38;5;136;1:*.pcm=38;5;136;1:*.wav=38;5;136;1:*.wv=38;5;136;1:*.wvc=38;5;136;1:*.afm=38;5;66:*.fon=38;5;66:*.fnt=38;5;66:*.pfb=38;5;66:*.pfm=38;5;66:*.ttf=38;5;66:*.otf=38;5;66:*.woff=38;5;66:*.woff2=38;5;66:*.PFA=38;5;66:*.pfa=38;5;66:*.7z=38;5;40:*.a=38;5;40:*.arj=38;5;40:*.bz2=38;5;40:*.cpio=38;5;40:*.gz=38;5;40:*.lrz=38;5;40:*.lz=38;5;40:*.lzma=38;5;40:*.lzo=38;5;40:*.rar=38;5;40:*.s7z=38;5;40:*.sz=38;5;40:*.tar=38;5;40:*.tbz=38;5;40:*.tgz=38;5;40:*.warc=38;5;40:*.WARC=38;5;40:*.xz=38;5;40:*.z=38;5;40:*.zip=38;5;40:*.zipx=38;5;40:*.zoo=38;5;40:*.zpaq=38;5;40:*.zst=38;5;40:*.zstd=38;5;40:*.zz=38;5;40:*.apk=38;5;215:*.ipa=38;5;215:*.deb=38;5;215:*.rpm=38;5;215:*.jad=38;5;215:*.jar=38;5;215:*.ear=38;5;215:*.war=38;5;215:*.cab=38;5;215:*.pak=38;5;215:*.pk3=38;5;215:*.vdf=38;5;215:*.vpk=38;5;215:*.bsp=38;5;215:*.dmg=38;5;215:*.crx=38;5;215:*.xpi=38;5;215:*.iso=38;5;124:*.img=38;5;124:*.bin=38;5;124:*.nrg=38;5;124:*.qcow=38;5;124:*.fvd=38;5;124:*.sparseimage=38;5;124:*.toast=38;5;124:*.vcd=38;5;124:*.vdi=38;5;124:*.vhd=38;5;124:*.vhdx=38;5;124:*.vfd=38;5;124:*.vmdk=38;5;124:*.swp=38;5;244:*.swo=38;5;244:*.tmp=38;5;244:*.sassc=38;5;244:*.pacnew=38;5;33:*.un~=38;5;241:*.orig=38;5;241:*.BUP=38;5;241:*.bak=38;5;241:*.o=38;5;241:*core=38;5;241:*.mdump=38;5;241:*.rlib=38;5;241:*.dll=38;5;241:*.aria2=38;5;241:*.dump=38;5;241:*.stackdump=38;5;241:*.zcompdump=38;5;241:*.zwc=38;5;241:*.part=38;5;239:*.r[0-9]{0,2}=38;5;239:*.zx[0-9]{0,2}=38;5;239:*.z[0-9]{0,2}=38;5;239:*.pid=38;5;248:*.state=38;5;248:*lockfile=38;5;248:*lock=38;5;248:*.err=38;5;160;1:*.error=38;5;160;1:*.stderr=38;5;160;1:*.pcap=38;5;29:*.cap=38;5;29:*.dmp=38;5;29:*.allow=38;5;112:*.deny=38;5;196:*.service=38;5;45:*@.service=38;5;45:*.socket=38;5;45:*.swap=38;5;45:*.device=38;5;45:*.mount=38;5;45:*.automount=38;5;45:*.target=38;5;45:*.path=38;5;45:*.timer=38;5;45:*.snapshot=38;5;45:*.lnk=38;5;39:*.application=38;5;116:*.cue=38;5;116:*.description=38;5;116:*.directory=38;5;116:*.m3u=38;5;116:*.m3u8=38;5;116:*.md5=38;5;116:*.properties=38;5;116:*.sfv=38;5;116:*.theme=38;5;116:*.torrent=38;5;116:*.urlview=38;5;116:*.webloc=38;5;116:*.asc=38;5;192;3:*.bfe=38;5;192;3:*.enc=38;5;192;3:*.gpg=38;5;192;3:*.signature=38;5;192;3:*.sig=38;5;192;3:*.p12=38;5;192;3:*.pem=38;5;192;3:*.pgp=38;5;192;3:*.p7s=38;5;192;3:*id_dsa=38;5;192;3:*id_rsa=38;5;192;3:*id_ecdsa=38;5;192;3:*id_ed25519=38;5;192;3:*.32x=38;5;213:*.cdi=38;5;213:*.fm2=38;5;213:*.rom=38;5;213:*.sav=38;5;213:*.st=38;5;213:*.a00=38;5;213:*.a52=38;5;213:*.A64=38;5;213:*.a64=38;5;213:*.a78=38;5;213:*.adf=38;5;213:*.atr=38;5;213:*.gb=38;5;213:*.gba=38;5;213:*.gbc=38;5;213:*.gel=38;5;213:*.gg=38;5;213:*.ggl=38;5;213:*.ipk=38;5;213:*.j64=38;5;213:*.nds=38;5;213:*.nes=38;5;213:*.sms=38;5;213:*.8xp=38;5;121:*.8eu=38;5;121:*.82p=38;5;121:*.83p=38;5;121:*.8xe=38;5;121:*.stl=38;5;216:*.dwg=38;5;216:*.ply=38;5;216:*.wrl=38;5;216:*.xib=38;5;208:*.iml=38;5;166:*.DS_Store=38;5;239:*.localized=38;5;239:*.CFUserTextEncoding=38;5;239:*CodeResources=38;5;239:*PkgInfo=38;5;239:*.nib=38;5;57:*.car=38;5;57:*.dylib=38;5;241:*.entitlements=1:*.pbxproj=1:*.strings=1:*.storyboard=38;5;196:*.xcconfig=1:*.xcsettings=1:*.xcuserstate=1:*.xcworkspacedata=1:*.pot=38;5;7:*.pcb=38;5;7:*.mm=38;5;7:*.gbr=38;5;7:*.scm=38;5;7:*.xcf=38;5;7:*.spl=38;5;7:*.Rproj=38;5;11:*.sis=38;5;7:*.1p=38;5;7:*.3p=38;5;7:*.cnc=38;5;7:*.def=38;5;7:*.ex=38;5;7:*.example=38;5;7:*.feature=38;5;7:*.ger=38;5;7:*.ics=38;5;7:*.map=38;5;7:*.mf=38;5;7:*.mfasl=38;5;7:*.mi=38;5;7:*.mtx=38;5;7:*.pc=38;5;7:*.pi=38;5;7:*.plt=38;5;7:*.rdf=38;5;7:*.ru=38;5;7:*.sch=38;5;7:*.sty=38;5;7:*.sug=38;5;7:*.tdy=38;5;7:*.tfm=38;5;7:*.tfnt=38;5;7:*.tg=38;5;7:*.vcard=38;5;7:*.vcf=38;5;7:*.xln=38;5;7:'
	_LS_COLORS_SOURCE="Custom Colors"
fi

#######################################################
# grc Generic Colouriser
# Link: https://github.com/garabik/grc
#######################################################

if [[ $_SKIP_GRC = false ]] && [[ -x "$(command -v grc)" ]]; then
	GRC_ALIASES=true
	if [[ -f "$HOME/.local/bin/grc.sh" ]]; then
		source ~/.local/bin/grc.sh
	elif [[ -f "/etc/profile.d/grc.sh" ]]; then
		source /etc/profile.d/grc.sh
	elif [[ -f "/etc/grc.sh" ]]; then
		source /etc/grc.sh
	else
		GRC="$(which grc)"
		if tty -s && [ -n "$TERM" ] && [ "$TERM" != dumb ] && [ -n "$GRC" ]; then
			alias as='colourify as'
			alias blkid='colourify blkid'
			alias colourify="$GRC -es"
			alias configure='colourify ./configure'
			if [[ "$(type -t df)" != 'alias' ]]; then alias df='colourify df -khT'; fi
			if [[ "$(type -t diff)" != 'alias' ]]; then alias diff='colourify diff'; fi
			alias dig='colourify dig'
			alias docker-compose='colourify docker-compose'
			alias docker-machine='colourify docker-machine'
			alias docker='colourify docker'
			alias du='colourify du'
			#alias env='colourify env'
			alias fdisk='colourify fdisk'
			alias findmnt='colourify findmnt'
			alias free='colourify free -m'
			alias g++='colourify g++'
			alias gas='colourify gas'
			alias gcc='colourify gcc'
			alias getsebool='colourify getsebool'
			alias head='colourify head'
			alias id='colourify id'
			alias ifconfig='colourify ifconfig'
			alias ip='colourify ip'
			alias iptables='colourify iptables'
			alias journalctl='colourify journalctl'
			alias kubectl='colourify kubectl'
			if [[ "$(type -t ld)" != 'alias' ]]; then alias ld='colourify ld'; fi
			alias lsof='colourify lsof'
			alias lspci='colourify lspci'
			alias m='colourify mount'
			alias make='colourify make'
			alias mount='colourify mount'
			alias mtr='colourify mtr'
			alias netstat='colourify netstat'
			alias ping='colourify ping -c 5'
			alias ps='colourify ps auxf'
			alias semanage='colourify semanage'
			alias sockstat='colourify sockstat'
			alias ss='colourify ss'
			alias tail='colourify tail'
			alias traceroute6='colourify traceroute6'
			alias traceroute='colourify traceroute'
		fi
	fi
	# Override lsblk to enhance the color output
	#alias lsblk='colourify lsblk --exclude 1,7 --output NAME,MAJ:MIN,RM,SIZE,RO,TYPE,MOUNTPOINTS'
	alias lsblk='colourify lsblk --exclude 1,7 --output NAME,MAJ:MIN,TYPE,FSTYPE,RM,MOUNTPOINTS,LABEL,SIZE,FSUSE%,RO,UUID 2> /dev/null || colourify lsblk --exclude 1,7'
else
	# List block devices but show more info including the files systems and permissions
	# and removes all mem and loopback devices (like snap packages) from the list
	#alias lsblk='\lsblk --exclude 1,7 --output NAME,MAJ:MIN,RM,SIZE,RO,TYPE,MOUNTPOINTS'
	alias lsblk='\lsblk --exclude 1,7 --output NAME,MAJ:MIN,TYPE,FSTYPE,RM,MOUNTPOINTS,LABEL,SIZE,FSUSE%,RO,UUID 2> /dev/null || \lsblk --exclude 1,7'
fi

#######################################################
# mysql-colorize
# Link: https://github.com/zpm-zsh/mysql-colorize
# Install: git clone https://github.com/horosgrisa/mysql-colorize.bash ~/.bash/mysql-colorize
#######################################################

# If qfc is installed
if [[ -f "$HOME/.bash/mysql-colorize/mysql-colorize.bash" ]]; then
	source "$HOME/.bash/mysql-colorize/mysql-colorize.bash"
fi

#######################################################
# Nethogs shows which processes are using network bandwidth
# Link: https://github.com/raboof/nethogs
#######################################################
# lsof command stands for List Of Open File
# Link: https://www.geeksforgeeks.org/lsof-command-in-linux-with-examples/
#######################################################
# iftop is a network analyzing tool used to view the bandwidth related stats
# Link: https://www.geeksforgeeks.org/iftop-command-in-linux-with-examples/
#######################################################

if [[ -x "$(command -v nethogs)" ]]; then
	# Watch real time network activity by process
	alias netwatch='sudo nethogs -d 0.5 -C'
elif [[ -x "$(command -v iftop)" ]]; then
	# Use iftop
	alias netwatch='sudo iftop'
else
	# Watch real time network activity using lsof instead
	alias netwatch='lsof -i -r 10'
fi

#######################################################
# Diff Enhancement
#######################################################

if [[ -x "$(command -v delta)" ]]; then
	if [[ -x "$(command -v batdiff)" ]]; then
		# bat-extras diff uses delta
		# Link: https://github.com/eth-p/bat-extras
		alias diff='batdiff --delta'
	else
		# delta - Beautiful side by side colored diff with Git support and syntax highlighting
		# Link: https://github.com/dandavison/delta
		# Info: Add listed settings to your ~/.gitconfig
		alias diff='delta --side-by-side --line-numbers'
	fi
	export DIFFPROG="delta --side-by-side --line-numbers"
elif [[ -x "$(command -v icdiff)" ]]; then
	# Icdiff - Improved (side by side) colored diff
	# Link: https://github.com/jeffkaufman/icdiff
	alias diff='icdiff --line-numbers --strip-trailing-cr'
	export DIFFPROG="icdiff --line-numbers --strip-trailing-cr"
elif [[ -x "$(command -v colordiff)" ]]; then
	# Colorize diff output if colordiff is installed
	alias diff='colordiff'
	export DIFFPROG="colordiff"
else
	if [[ ${EDITOR} = 'nvim' ]]; then
		export DIFFPROG="nvim -d"
	elif [[ ${EDITOR} = 'vim' ]]; then
		export DIFFPROG="vim -d"
	else
		export DIFFPROG="\diff --side-by-side --suppress-common-lines --ignore-all-space --ignore-blank-lines --strip-trailing-cr --report-identical-files"
	fi
fi

# If we are inside a desktop environment (and not TTY or SSH)
if [[ -n "${XDG_CURRENT_DESKTOP}" ]]; then

	# Alias to log out the currect user
	alias logout="sudo pkill -u ${USER}"

	# Video capture the Linux destop
	if [[ -x "$(command -v ffmpeg)" ]]; then
		alias grabvideo='ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -qscale 0'
	fi

	# If a gui diff/merge application is installed, use that instead
	for _DIFF_APP_GUI in \
		meld \
		kompare \
		kdiff3 \
		xxdiff
	do
		if [[ -x "$(command -v ${_DIFF_APP_GUI})" ]]; then
			alias diff="${_DIFF_APP_GUI}"
			export DIFFPROG="${_DIFF_APP_GUI}"
			break
		fi
	done

	# Switch over to UI starting in the current directory
	if [[ -x "$(command -v exo-open)" ]]; then
		alias ui='exo-open --launch FileManager "${PWD}" > /dev/null 2>&1 & disown'
	elif [[ -x "$(command -v kde-open)" ]]; then
		alias ui='kde-open "${PWD}" > /dev/null 2>&1 & disown'
	elif [[ -x "$(command -v gnome-open)" ]]; then
		alias ui='gnome-open "${PWD}" > /dev/null 2>&1 & disown'
	elif [[ -x "$(command -v xdg-open)" ]]; then
		alias ui='xdg-open "${PWD}" > /dev/null 2>&1 & disown'
	elif [[ -x "$(command -v krusader)" ]]; then
		alias ui='krusader "${PWD}" > /dev/null 2>&1 & disown'
	elif [[ -x "$(command -v dolphin)" ]]; then
		alias ui='dolphin "${PWD}" > /dev/null 2>&1 & disown'
	elif [[ -x "$(command -v thunar)" ]]; then
		alias ui='thunar "${PWD}" > /dev/null 2>&1 & disown'
	elif [[ -x "$(command -v pcmanfm)" ]]; then
		alias ui='pcmanfm "${PWD}" > /dev/null 2>&1 & disown'
	elif [[ -x "$(command -v nautilus)" ]]; then
		alias ui='nautilus "${PWD}" > /dev/null 2>&1 & disown'
	elif [[ -x "$(command -v nemo)" ]]; then
		alias ui='nemo "${PWD}" > /dev/null 2>&1 & disown'
	elif [[ -x "$(command -v caja)" ]]; then
		alias ui='caja "${PWD}" > /dev/null 2>&1 & disown'
	elif [[ -x "$(command -v konqueror)" ]]; then
		alias ui='konqueror "${PWD}" > /dev/null 2>&1 & disown'
	fi
fi

#######################################################
# Bash Completion
# Link: https://github.com/scop/bash-completion
#######################################################

# Use extended globbing for more advanced pattern matching
# This is necessary for programmable completion
shopt -s extglob

if [[ $_SCRIPT_BASH_COMPLETION = false ]]; then
	# Use bash-completion, if available
	if [[ -f /usr/share/bash-completion/bash_completion ]]; then
		source /usr/share/bash-completion/bash_completion
	elif [[ -f /etc/bash_completion ]]; then
		source /etc/bash_completion
	elif [[ -f "$HOME/bash_completion" ]]; then
		source "$HOME/bash_completion"
	elif [[ -f "$HOME/.local/share/bash_completion" ]]; then
		source "$HOME/.local/share/bash_completion"
	elif [[ -f "$HOME/.config/bash_completion" ]]; then
		source "$HOME/.config/bash_completion"
	fi
fi

#######################################################
# Cod is a completion daemon for bash, fish, and zsh
# Link: https://github.com/dim-an/cod
#######################################################

if [[ -x "$(command -v cod)" ]]; then
	source <(cod init $$ bash)
fi

#######################################################
# Enable the "Command not found" hook
# Link: https://github.com/falconindy/pkgfile
# NOTE: pkgfile is targetted at Arch Linux users
# Install: pacman -S pkgfile
#######################################################

if [[ -r /usr/share/doc/pkgfile/command-not-found.bash ]]; then
	source /usr/share/doc/pkgfile/command-not-found.bash
fi

#######################################################
# Better Bash Defaults
# Link: http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
#######################################################

# CRTL-q will now clear the entire line in the terminal (quit command)
bind '"\C-q":"\C-k\C-u"'

# CTRL-d will disconnect even if there is text on the line
bind '"\C-d":"\C-k\C-u\C-d"'

# Disable the bell sound but make it visible
bind 'set bell-style visible'

# Prevent overwriting an existing file with the >, >&, and <> redirection operators
# Use `>|` to force redirection to an existing file
#set -o noclobber

# Update window size after each command and, if necessary, update the values of LINES and COLUMNS
# shopt -s checkwinsize
[[ $DISPLAY ]] && shopt -s checkwinsize

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=3

# Turn on recursive globbing (enables ** to recurse all directories)
# For example, ls **/*.txt will list all text files in the current directory hierarchy
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Report the status of terminated background jobs immediately rather than before the next primary prompt
set -o notify

# Bash checks that a command found in the hash table exists before trying to execute it
shopt -s checkhash

# Bash includes filenames beginning with a "." in the results of filename expansion
shopt -s dotglob

# Turns off CTRL-D to log out
#set -o ignoreeof

# Disable coredumps
ulimit -S -c 0

# Don't let my shell warn me of incoming mail
shopt -u mailwarn
unset MAILCHECK

# Fix the HOME and END keys in PuTTY
if [[ "$COLORTERM" ]]; then # rxvt
	bind '"\e[7~": beginning-of-line'
	bind '"\e[8~": end-of-line'
else # xterm
	bind '"\e[1~": beginning-of-line'
	bind '"\e[4~": end-of-line'
fi

#######################################################
### SMARTER TAB-COMPLETION (Readline bindings)
#######################################################

# Perform file completion in a case insensitive fashion
bind 'set completion-ignore-case on'

# Treat hyphens and underscores as equivalent
bind 'set completion-map-case on'

# Display matches for ambiguous patterns at first tab press instead of bell
bind 'set show-all-if-ambiguous on'

# This line sets the completions to be listed immediately instead of ringing
# the bell when the completing word has more than one possible completion but
# no partial completion can be made
bind 'set show-all-if-unmodified on'

# Immediately add a trailing slash when autocompleting symlinks to directories
bind 'set mark-symlinked-directories on'

# Add a trailing slash when completing a directory name
bind 'set mark-directories on'

# Set autoexpansion of the '~' when TAB is pressed
bind 'set expand-tilde off'

# This line sets readline to display possible completions using different
# colors to indicate their file types. The colors are determined by the
# environmental variable LS_COLORS, which can be nicely configured
bind 'set colored-stats on'

# This lines sets completions to be appended by characters that indicate their
# file types reported by the stat system call
bind 'set visible-stats on'

#######################################################
### HISTORY DEFAULTS
#######################################################

# Turn off bash history completely
# set +o history

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Huge history. Doesn't appear to slow things down, so why not?
export HISTFILESIZE=100000
export HISTSIZE=${HISTFILESIZE}

# Avoid duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=ignoreboth:erasedups

# Append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend histverify

# Save and reload the history after each command finishes
# WARNING: Some of these mess up the history counter and is slower as history grows larger
# WARNING: It can also break some more advanced installed prompts
# This has issues with McFly so only set if it's not installed
if [[ ! -x "$(command -v mcfly)" ]]; then
	## Append new history to history file, clear internal history list, and re-read the history file
	export PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"
	## -Or- just record each line as it gets issued but new history is not in other sessions (faster)
	#export PROMPT_COMMAND="history -a; ${PROMPT_COMMAND}"
fi

# Save multi-line commands as one command
shopt -s cmdhist

# Consecutive duplicate commands, invocations of common commands like ls without parameters,
# plus calls to the bg, fg and exit built-ins will not be appended to the history list
export HISTIGNORE='&:[ ]*:ls:ll:[bf]g:history:clear:cls:exit'

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
export HISTTIMEFORMAT='%F %T '

# Allow ctrl-S for history navigation (with ctrl-R)
stty -ixon

#######################################################
### BETTER DIRECTORY NAVIGATION
#######################################################

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null

# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
shopt -s direxpand 2> /dev/null

# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH="."

# The source builtin uses the value of PATH to find the directory containing the file supplied as an argument
shopt -s sourcepath

# If Readline is being used, Bash will not attempt to search the PATH for possible completions when completion is attempted on an empty line
shopt -s no_empty_cmd_completion

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

# Examples:
# export backup="$HOME/Backup"
# export desktop="$HOME/Desktop"
# export documents="$HOME/Documents"
# export music="$HOME/Music"
# export pictures="$HOME/Pictures"
# export videos="$HOME/Videos"

#######################################################
# User Specific Aliases
# This runs towards the end of the script in order to
# have supporting aliases and features and also so
# these can be over-written or modified (see unalias)
#######################################################

if [[ -f "$HOME/.bash_aliases" ]]; then
	source "$HOME/.bash_aliases"
elif [[ -f "$HOME/.config/bashrc/aliases" ]]; then
	source "$HOME/.config/bashrc/aliases"
fi

#######################################################
# Enhancd next-generation cd command with an interactive filter
# Link: https://github.com/b4b4r07/enhancd
# Install: cd ~ && git clone https://github.com/b4b4r07/enhancd
# NOTE: Breaks/replaces Bash shell option "shopt -s cdable_vars"
#######################################################

# If enhancd is installed, initialize it
if [[ -f "$HOME/enhancd/init.sh" ]]; then
	ENHANCD_FILTER=fzy:sk:fzf:peco:percol:pick:icepick:selecta:sentaku:zf
	export ENHANCD_FILTER
	source ~/enhancd/init.sh
fi

#######################################################
# Fasd keeps track of files and directories you have
# accessed so that you can quickly reference them
# a  - any (directory or file)
# s  - show / search / select
# d  - directory
# f  - file
# sd - interactive directory selection
# sf - interactive file selection
# z  - cd, same functionality as j in autojump
# zz - cd with interactive selection
# Link: https://github.com/clvv/fasd
#######################################################

# If fasd is installed, initialize it
if [[ -x "$(command -v fasd)" ]]; then
	eval "$(fasd --init auto)"
fi

#######################################################
# Automatically source node.js and npm
#######################################################

# Load the npm configuration and bash completion
if [[ -x "$(command -v npm)" ]]; then
	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Source Node Version Manager to manage multiple active node.js versions
if [[ -f /usr/share/nvm/init-nvm.sh ]]; then
	source /usr/share/nvm/init-nvm.sh
fi

#######################################################
# Automatically source all files/links in the directory:
# ~/.config/bashrc/bashrc.d
#######################################################

# If the auto-source folder exists and has files in it...
if [[ -d $HOME/.config/bashrc/bashrc.d ]]; then

	# If the directory is not empty...
	if [[ "$(\ls -A $HOME/.config/bashrc/bashrc.d)" ]]; then

		# Loop through files (in alphabetical order) and source them
		# To specify a load order, files can be prefixed with numbers
		# (e.g. 00--filename, 50--filename, 95--filename)
		for file in $HOME/.config/bashrc/bashrc.d/*; do
			source "${file}"
		done
	fi
fi

#######################################################
# This default prompt will be used if another prompt is not installed
# Link: https://ezprompt.net/ (some modifications below)
# Git Code Reference:
# > Renamed
# * Ahead
# + New File
# ? Untracked
# x Deleted
# ! Dirty
#######################################################

# Get current branch in Git repo
function _parse_git_branch() {
	if [[ $_GIT_IS_SLOW = false ]]; then
		BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
		if [[ ! "${BRANCH}" == "" ]]; then
			STAT=`_parse_git_dirty`
			echo " [${BRANCH}${STAT}]"
		else
			echo ""
		fi
	else
		_fast_git_ps1 "${@}"
	fi
}

# Get current status of Git repo
function _parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [[ "${renamed}" == "0" ]]; then
		bits=">${bits}"
	fi
	if [[ "${ahead}" == "0" ]]; then
		bits="*${bits}"
	fi
	if [[ "${newfile}" == "0" ]]; then
		bits="+${bits}"
	fi
	if [[ "${untracked}" == "0" ]]; then
		bits="?${bits}"
	fi
	if [[ "${deleted}" == "0" ]]; then
		bits="x${bits}"
	fi
	if [[ "${dirty}" == "0" ]]; then
		bits="!${bits}"
	fi
	if [[ ! "${bits}" == "" ]]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

# Faster Git information for Git Bash and slow networks
# https://stackoverflow.com/questions/4485059/git-bash-is-extremely-slow-in-windows-7-x64/19500237#19500237
# https://stackoverflow.com/questions/4485059/git-bash-is-extremely-slow-in-windows-7-x64/13476961#13476961
# https://stackoverflow.com/questions/39518124/check-if-directory-is-git-repository-without-having-to-cd-into-it/39518382#39518382
function _fast_git_ps1 () {
	git -C . rev-parse 2>/dev/null && echo " [$((git symbolic-ref --short -q HEAD || git rev-parse -q --short HEAD) 2> /dev/null)]"
}

# Return the path for the "full path" multi-line prompt
function _pwd() {
	# Returns the full path but still shows the home directory as ~
	echo $PWD | sed 's@'${HOME}'@~@'
}

# Clear out the prompt command before we begin
# Some environments can set this and cause errors
export PROMPT_COMMAND=''

# Set the prompt
# If using Git Bash or Cygwin...
if [[ "$_KERNEL_NAME" = "MINGW" ]] || [[ "$_KERNEL_NAME" = "CYGWI" ]]; then

	# Prompt using faster and less intensive functions on Git Bash
	export PS1="\[\033[0;35m\]\u \[\033[0;34m\]\D{%b %d} \[\033[0;36m\]\A \[\033[0;33m\]\w\[\033[0;31m\]\`_fast_git_ps1\`\[\033[0m\]\n\\$ "

else # Standard default prompt

	# Prompt color changes if logged on as root
	if [[ $EUID > 0 ]]; then
		_COLOR_USER="\033[0;32m"
	else
		_COLOR_USER="\033[1;31m"
	fi

	# Date formats can be found here (man strftime):
	# https://manpages.ubuntu.com/manpages/xenial/man3/strftime.3.html
	# https://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/

	# Only if connected SSH, show the host
	if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
		if [[ $_PROMPT_BUILTIN_FULL_PATH = false ]]; then
			# Remote SSH with short path (1 line)
			export PS1="\[\033[0;35m\]\u@\[\033[1;35m\]\h \[\033[0;34m\]\D{%b %-d} \[\033[0;36m\]\D{%-H:%M} \[\033[0;33m\]\w\[\033[0;31m\]\`_parse_git_branch\` \[${_COLOR_USER}\]>\[\033[0m\] "
		else
			# Remote SSH with full path (2 lines)
			export PS1="\[\033[0;35m\]\u@\[\033[1;35m\]\h \[\033[0;34m\]\D{%b %-d} \[\033[0;36m\]\D{%-H:%M:%S} \[\033[0;33m\]\$(_pwd)\[\033[0;31m\]\`_parse_git_branch\`\[\033[0m\]\n\[${_COLOR_USER}\]>\[\033[0m\] "
		fi
	else # Otherwise, only show the name
		if [[ $_PROMPT_BUILTIN_FULL_PATH = false ]]; then
			# Local with short path (1 line)
			export PS1="\[\033[0;35m\]\u \[\033[0;34m\]\D{%b %-d} \[\033[0;36m\]\D{%-H:%M} \[\033[0;33m\]\w\[\033[0;31m\]\`_parse_git_branch\` \[${_COLOR_USER}\]>\[\033[0m\] "
		else
			# Local with full path (2 lines)
			export PS1="\[\033[0;35m\]\u \[\033[0;34m\]\D{%b %-d} \[\033[0;36m\]\D{%-H:%M:%S} \[\033[0;33m\]\$(_pwd)\[\033[0;31m\]\`_parse_git_branch\`\[\033[0m\]\n\[${_COLOR_USER}\]>\[\033[0m\] "
		fi
	fi
fi

#######################################################
# Attempt to find and load some of the top installed prompts
# Only set and replace the custom prompt script if installed
# Otherwise, the standard prompt in a section above is already set
#######################################################

# The original older Extreme Ultimate .bashrc File prompt with added Git support
if [[ -f "$HOME/.bashrc_prompt" ]] && [[ $_SKIP_PROMPT_ORIGINAL = false ]]; then
	source "$HOME/.bashrc_prompt"
elif [[ -f "$HOME/.config/bashrc/prompt" ]] && [[ $_SKIP_PROMPT_ORIGINAL = false ]]; then
	source "$HOME/.config/bashrc/prompt"

# Trueline Bash (true 24-bit color and glyph support)
# This is the preferred prompt since it looks amazing,
# has so many features, is easily extended using functions,
# and is a single Bash script file that is easy to install.
# NOTE: You can place trueline.sh in the ~/.config/bashrc directory to keep it out of home
# Link: https://github.com/petobens/trueline
# Install: wget https://raw.githubusercontent.com/petobens/trueline/master/trueline.sh -P ~/
# Fonts: https://github.com/powerline/fonts
elif [[ -x "$(command -v trueline)" ]] && [[ $_SKIP_PROMPT_TRUELINE = false ]]; then
	source "$(which trueline)"
elif [[ -f /usr/bin/trueline ]] && [[ $_SKIP_PROMPT_TRUELINE = false ]]; then
	source /usr/bin/trueline
elif [[ -f "$HOME/.config/bashrc/trueline.sh" ]] && [[ $_SKIP_PROMPT_TRUELINE = false ]]; then
	source "$HOME/.config/bashrc/trueline.sh"
elif [[ -f "$HOME/trueline/trueline.sh" ]] && [[ $_SKIP_PROMPT_TRUELINE = false ]]; then
	source "$HOME/trueline/trueline.sh"
elif [[ -f "$HOME/trueline.sh" ]] && [[ $_SKIP_PROMPT_TRUELINE = false ]]; then
	source "$HOME/trueline.sh"

# Powerline-Go Global Install (this prompt uses no special glyphs)
# Link: https://github.com/justjanne/powerline-go
elif [[ -f "/usr/bin/powerline-go" ]] && [[ $_SKIP_PROMPT_POWERLINE_GO = false ]]; then

	# Prompt Configuration for Powerline-Go
	function _powerline_go_update_ps1() {
		PS1="$(/usr/bin/powerline-go -error $? -jobs $(jobs -p | wc -l))"

		# Automatically clear errors after showing them once (can cause problems)
		#set "?"
	}
	PROMPT_COMMAND="_powerline_go_update_ps1; $PROMPT_COMMAND"
# Powerline-Go Home Folder Install (this prompt uses no special glyphs)
elif [[ -f "$GOPATH/bin/powerline-go" ]] && [[ $_SKIP_PROMPT_POWERLINE_GO = false ]]; then

	# Prompt Configuration for Powerline-Go
	function _powerline_go_update_ps1() {
		PS1="$($GOPATH/bin/powerline-go -error $? -jobs $(jobs -p | wc -l))"

		# Automatically clear errors after showing them once (can cause problems)
		#set "?"
	}
	PROMPT_COMMAND="_powerline_go_update_ps1; $PROMPT_COMMAND"

# Powerline-Shell (details about git/svn/hg/fossil branch and Python virtualenv environment)
# Link: https://github.com/b-ryan/powerline-shell
elif [[ -x "$(command -v powerline-shell)" ]] && [[ $_SKIP_PROMPT_POWERLINE_SHELL = false ]]; then

	# Prompt Configuration for Powerline-Shell
	function _powerline_shell_update_ps1() {
		PS1=$(powerline-shell $?)
	}
	PROMPT_COMMAND="_powerline_shell_update_ps1; $PROMPT_COMMAND"

# Pureline (256 color written in bash script)
# Link: https://github.com/chris-marsh/pureline
# Install:
# git clone https://github.com/chris-marsh/pureline.git
# cp pureline/configs/powerline_full_256col.conf ~/.pureline.conf
elif [[ -f "$HOME/pureline/pureline" ]] && [[ $_SKIP_PROMPT_PURELINE = false ]]; then
	source "$HOME/pureline/pureline $HOME/.pureline.conf"

# Starship Cross Shell Prompt (focus on compatibility and written in Rust)
# Link: https://starship.rs
# Install: sh -c "$(curl -fsSL https://starship.rs/install.sh)"
elif [[ -x "$(command -v starship)" ]] && [[ $_SKIP_PROMPT_STARSHIP = false ]]; then
	eval "$(starship init bash)"

# Oh-My-Git (only used for Git but has huge support for it, requires font)
# Link: https://github.com/arialdomartini/oh-my-git
# Install: git clone https://github.com/arialdomartini/oh-my-git.git ~/.oh-my-git
elif [[ -f "$HOME/.oh-my-git/prompt.sh" ]] && [[ $_SKIP_PROMPT_OH_MY_GIT = false ]]; then
	source "$HOME/.oh-my-git/prompt.sh"

# Bash Git Prompt (shows git repository, branch name, difference with remote branch, number of files staged, changed, etc)
# Link: https://github.com/magicmonty/bash-git-prompt
# Install: git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
elif [[ -f /usr/lib/bash-git-prompt/gitprompt.sh ]] && [[ $_SKIP_PROMPT_BASH_GIT_PROMPT = false ]]; then
	# To only show the git prompt in or under a repository directory
	GIT_PROMPT_ONLY_IN_REPO=1
	# To use upstream's default theme
	# GIT_PROMPT_THEME=Default
	# To use upstream's default theme, modified by arch maintainer
	GIT_PROMPT_THEME=Default_Arch
	source /usr/lib/bash-git-prompt/gitprompt.sh
elif [[ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]] && [[ $_SKIP_PROMPT_BASH_GIT_PROMPT = false ]]; then
	# To only show the git prompt in or under a repository directory
	GIT_PROMPT_ONLY_IN_REPO=1
	# To use upstream's default theme
	# GIT_PROMPT_THEME=Default
	# To use upstream's default theme, modified by arch maintainer
	GIT_PROMPT_THEME=Default_Arch
	source "$HOME/.bash-git-prompt/gitprompt.sh"

# Bash Powerline (no need for patched fonts, supports git, previous command execution status, platform-dependent prompt symbols)
# Link: https://github.com/riobard/bash-powerline
# Install: curl https://raw.githubusercontent.com/riobard/bash-powerline/master/bash-powerline.sh > ~/.bash-powerline.sh
elif [[ -f "$HOME/.bash-powerline.sh" ]] && [[ $_SKIP_PROMPT_BASH_POWERLINE = false ]]; then
	source "$HOME/.bash-powerline.sh"

# Sexy Bash Prompt (supports git, 256 color)
# Link: https://github.com/twolfson/sexy-bash-prompt
# Install: (cd /tmp && ([[ -d sexy-bash-prompt ]] || git clone --depth 1 --config core.autocrlf=false https://github.com/twolfson/sexy-bash-prompt) && cd sexy-bash-prompt && make install)
elif [[ -f "$HOME/.bash_prompt" ]] && [[ $_SKIP_PROMPT_SEXY_BASH_PROMPT = false ]]; then
	source "$HOME/.bash_prompt"

# Liquid Prompt (adaptive prompt with low color and no glyphs)
# Link: https://github.com/nojhan/liquidprompt
# Install: git clone --branch stable https://github.com/nojhan/liquidprompt.git ~/liquidprompt
elif [[ -f "$HOME/liquidprompt/liquidprompt" ]] && [[ $_SKIP_PROMPT_LIQUIDPROMPT = false ]]; then
	source "$HOME/liquidprompt/liquidprompt"

# Original Powerline Status Line for Vim Bash Zsh fish tmux IPython Awesome i3 Qtile
# Link: https://github.com/powerline/powerline
# Install: https://medium.com/earlybyte/powerline-for-bash-6d3dd004f6fc
# NOTE: Requires Python and can be used with Trueline in Bash
# WARNING: This path may change or break in the future with new Python versions
elif [[ -f /usr/lib/python3.9/site-packages/powerline/bindings/bash/powerline.sh ]] && [[ $_SKIP_PROMPT_POWERLINE = false ]]; then
	source /usr/lib/python3.9/site-packages/powerline/bindings/bash/powerline.sh
fi

#######################################################
# Play nice with Midnight Commander subshell
# Link: https://midnight-commander.org/
# Link: https://superuser.com/questions/526201/how-to-change-the-prompt-of-mcs-subshell
#######################################################

if [[ -n "$(ps $PPID | grep -w [m]c)" ]]; then
	# The Midnight Commander subshell doesn't like aliases for pwd
	unalias pwd >/dev/null 2>/dev/null

	# Exit here
	return
fi

#######################################################
# Blesh: Bash Line Editor replaces default GNU Readline (Do this step last)
# Link: https://github.com/akinomyoga/ble.sh
# Link for configuration: https://github.com/akinomyoga/ble.sh/blob/master/blerc
# WARNING: Can be buggy with certain prompts (like Trueline)
# To Install:
# git clone --recursive https://github.com/akinomyoga/ble.sh.git
# make -C ble.sh
# To Update (in a ble.sh session):
# ble-update
#######################################################

# If Blesh is installed, either activate or create an alias
if [[ $_SKIP_BLESH = false ]]; then
	if [[ -f "$HOME/ble.sh/out/ble.sh" ]]; then
		source "$HOME/ble.sh/out/ble.sh"
		ble-bind -x 'C-d' 'exit' # CTRL-d to exit
		bleopt prompt_eol_mark='⏎'
		_ble_loaded=true
	elif [[ -f "$HOME/.local/share/blesh/ble.sh" ]]; then
		source "$HOME/.local/share/blesh/ble.sh"
		ble-bind -x 'C-d' 'exit'
		bleopt prompt_eol_mark='⏎'
		_ble_loaded=true
	elif [[ -f /usr/share/blesh/ble.sh ]]; then
		source /usr/share/blesh/ble.sh
		ble-bind -x 'C-d' 'exit'
		bleopt prompt_eol_mark='⏎'
		_ble_loaded=true
	fi
fi

# Only if Blesh is not loaded (causes a conflict with Blesh)...
if [[ ! $_ble_loaded = true ]]; then

	# Enable incremental history search with up/down arrows and other Readline features
	# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
	bind '"\e[A": history-search-backward'
	bind '"\e[B": history-search-forward'
	bind '"\e[C": forward-char'
	bind '"\e[D": backward-char'
fi

#######################################################
# Terminology is a graphical EFL terminal emulator that can run in TTY sessions
# To split the window horizontally press Ctrl+Shift+PgUp
# To split the window vertically press Ctrl+Shift+PgDn
# To create Tabs press Ctrl+Shift+T and cycle through using Ctrl+1-9
# Link: https://github.com/borisfaure/terminology
# Link: https://linoxide.com/terminology-terminal/
#######################################################

if [[ $_SKIP_TERMINOLOGY_TTY = false ]] && command -v terminology>/dev/null; then
	# If we are in a TTY window , not in TMUX, and not logged in via SSH...
	if [[ "$(tty)" =~ /dev/tty ]] && [[ ! "$TERM" =~ screen ]] && [[ -z "$SSH_CLIENT" ]] && [[ -z "$SSH_TTY" ]]; then

		# If TMUX is installed and set to load at TTY
		if [[ $_TMUX_LOAD_TTY = true ]] && command -v tmux>/dev/null; then

			# Get the default session name
			if [[ -z "${_TMUX_LOAD_SESSION_NAME}" ]]; then
				if [[ "$(tmux list-sessions 2> /dev/null | wc -l)" -gt 0 ]]; then
					_TMUX_LOAD_SESSION_NAME=""
				else
					_TMUX_LOAD_SESSION_NAME="$(whoami)"
				fi
			fi

			# Create the TMUX session if it doesn't exist
			TMUX='' tmux -u new-session -d -s "${_TMUX_LOAD_SESSION_NAME}" 2> /dev/null
			terminology --fullscreen --borderless --256color --exec "tmux attach -t ${_TMUX_LOAD_SESSION_NAME}"

		# No TMUX
		else
			terminology --fullscreen --borderless --256color && exit
		fi

	fi

#######################################################
# Automatically launch TMUX if this is a TTY Console or SSH session
# Most terminals can launch TMUX and automatically exit when TMUX is detached:
# konsole -e 'tmux new-session -A -s main'
# xfce4-terminal -e 'tmux new-session -A -s main'
# gnome-terminal -e 'tmux new-session -A -s main'
# kitty sh -c "tmux new-session -A -s main"
# terminology --exec "tmux new-session -A -s main"
# guake -e tmux
# Yakuake Profile -> Command -> /bin/bash -c "tmux new-session -A -s main"
# Alacritty: https://github.com/alacritty/alacritty/issues/2956
# ssh user@server -t tmux new-session -A -s main
#######################################################

# If TMUX is installed...
elif command -v tmux>/dev/null; then

	# We're in a TTY terminal...
	if [[ "$(tty)" =~ /dev/tty ]] && [[ ! "$TERM" =~ screen ]]; then
		[[ $_TMUX_LOAD_TTY = true ]] && tm

	# We're logged in via SSH...
	elif [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
		[[ $_TMUX_LOAD_SSH = true ]] && tm

	# We are local and not using SSH or TTY...
	else
		[[ $_TMUX_LOAD_LOCAL = true ]] && tm
	fi
fi

#######################################################
# Tilix VTE Configuration
# Link: https://gnunn1.github.io/tilix-web/manual/vteconfig/
#######################################################

if [[ $TILIX_ID ]] || [[ $VTE_VERSION ]]; then
	if [[ -f /etc/profile.d/vte.sh ]]; then
		source /etc/profile.d/vte.sh
	fi
fi

alias opendl='/opt/karaf-0.8.4/bin/karaf'
alias python='/usr/bin/python3'