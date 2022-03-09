# Install your environment
.PHONY: install update

CASK_PACKAGES = brave-browser bitwarden docker iterm2 notion phpstorm postman rectangle slack sublime-text the-unarchiver
CLI_PACKAGES = git docker mutagen-io/mutagen/mutagen-compose-beta marp-cli starship php composer symfony-cli/tap/symfony-cli blackfire yarn ansible

install:				## Install dependencies
install: install-brew blackfire-repository install-cask-packages install-cli-packages \
install-blackfire-probe install-xdebug create-gitignore-file install-oh-my-zsh change-zsh-theme activate-hidden-files

install-brew:			## Install Brew
						sudo true
						curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sudo -u $$USER bash

blackfire-repository:	## Add Blackfire repository
						brew tap blackfireio/homebrew-blackfire

install-cask-packages:	## Install Cask Packages
						@for v in $(CASK_PACKAGES) ; do \
							if brew ls --cask --versions $$v > /dev/null; then \
								echo "\033[0;33mPackage already installed: $$v\033[m";\
							else \
								echo "\033[0;34m$$v is not installed";\
								brew install --cask $$v;\
								echo "\033[0;32mPackage installed: $$v\033[m";\
							fi \
						done

install-cli-packages:	## Install Cli Packages
						@for v in $(CLI_PACKAGES) ; do \
							if brew ls --versions $$v > /dev/null; then \
								echo "\033[0;33mPackage already installed: $$v\033[m";\
							else \
								echo "\033[0;34m$$v is not installed";\
								brew install $$v;\
								echo "\033[0;32mPackage installed: $$v\033[m";\
							fi \
						done

install-blackfire-probe:## Install Blackfire probe
						blackfire php:install

install-xdebug:			## Install xdebug
						pecl install xdebug

create-gitignore-file:	## Create global gitignore file and exclude it from git
						touch ~/.gitignore
						echo ".idea\n.DS_Store\n" >> ~/.gitignore
						git config --global core.excludeFiles ~/.gitignore

install-oh-my-zsh:		## Install Oh My ZSH
						curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sudo -u $$USER bash

change-zsh-theme:		## Change ZSH default theme to cloud
						sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="cloud"/' ~/.zshrc

activate-hidden-files:	## Show hidden files and relaunch Finder
						defaults write com.apple.finder AppleShowAllFiles TRUE
						killall Finder

# Update
update:					## Update brew and Oh My ZSH
update: update-brew upgrade-brew update-omz

update-brew:			## Update dependencies
						brew update

upgrade-brew:			## Upgrade all packaqges
						brew upgrade

update-omz:				## Update Oh My ZSH
						omz update

# Help
.PHONY: help

help:					## Display help
						@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.DEFAULT_GOAL := 	help
