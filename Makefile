# Install your environment
.PHONY: install update

CASK_PACKAGES = brave-browser bitwarden docker iterm2 notion phpstorm postman rectangle slack sublime-text the-unarchiver
CLI_PACKAGES = git docker mutagen-io/mutagen/mutagen-compose marp-cli starship php composer symfony-cli/tap/symfony-cli blackfire yarn ansible topgrade

install:				## Install dependencies
install: install-brew blackfire-repository install-cask-packages install-cli-packages \
authorize-rectangle open-rectangle install-blackfire-probe install-xdebug create-gitignore-file \
install-oh-my-zsh install-zsh-auto add-zsh-autosuggestion install-zsh-vi-mode add-zsh-vi-mode \
install-zsh-fast-syntax add-zsh-fast-syntax change-zsh-theme install-nerd-font add-starship-config \
add-starship-file add-iterm-file activate-hidden-files

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

authorize-rectangle:	## Authorize rectangle application
						xattr -r -d com.apple.quarantine /Applications/Rectangle.app

open-rectangle:			## Open rectangle
						open -a rectangle

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

install-zsh-auto:		## Install ZSH extensions
						brew install zsh-autosuggestions

add-zsh-autosuggestion:	## Add zsh autosuggestion configuration in .zshrc file
						echo 'source $$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc

install-zsh-vi-mode:	## Install ZSH Vi mode
						brew install zsh-vi-mode

add-zsh-vi-mode:		## Add zsh vi mode configuration in .zshrc file
						echo 'source $$(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh' >> ~/.zshrc

install-zsh-fast-syntax:## Install ZSH fast syntax highlighting
						brew install zsh-fast-syntax-highlighting

add-zsh-fast-syntax:	## Add zsh fast syntax highlighting configuration in .zshrc file
						echo 'source $$(brew --prefix)/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh' >> ~/.zshrc

change-zsh-theme:		## Change ZSH default theme to cloud
						sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="cloud"/' ~/.zshrc

install-nerd-font:		## Install Nerd Font (required for starship)
						brew tap homebrew/cask-fonts && brew install --cask font-hack-nerd-font

add-starship-config:	## Add starship configuration in .zshrc
						echo 'eval "$$(starship init zsh)"' >> ~/.zshrc

add-starship-file:		## Add starship.toml configuration file
						mkdir -p ~/.config && cp templates/starship.toml ~/.config/starship.toml

add-iterm-file:			## Add iTerm customize configuration file
						cp templates/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

activate-hidden-files:	## Show hidden files and relaunch Finder
						defaults write com.apple.finder AppleShowAllFiles TRUE
						killall Finder

# Update
update:					## Update everything
						topgrade

# Remove
remove:
remove:					remove-xdebug delete-xdebug-config delete-gitignore-file delete-nerd-font delete-starship-file delete-iterm-file remove-cask-packages remove-cli-packages remove-oh-my-zsh remove-brew

remove-xdebug:			## Install xdebug
						pecl uninstall xdebug

delete-xdebug-config:	## Delete xdebug config
						sed -i '' '/zend_extension="xdebug.so"/d' /usr/local/etc/php/8.1/php.ini

delete-gitignore-file:	## Create global gitignore file and exclude it from git
						rm -f ~/.gitignore

delete-nerd-font:		## Delete Nerd Font
						rm -f ~/Library/Fonts/Hack*

delete-starship-file:	## Delete starship.toml configuration file
						rm -f ~/.config/starship.toml

delete-iterm-file:		## Delete iTerm customize configuration file
						rm -f ~/Library/Preferences/com.googlecode.iterm2.plist

remove-cask-packages:	## Remove Cask Packages
						@for v in $(CASK_PACKAGES) ; do \
							brew uninstall --cask $$v;\
						done

remove-cli-packages:	## Remove Cli Packages
						@for v in $(CLI_PACKAGES) ; do \
							brew uninstall $$v;\
						done

remove-oh-my-zsh:		## Remove Oh My ZSH
						chmod a+x ~/.oh-my-zsh/tools/uninstall.sh
						~/.oh-my-zsh/tools/uninstall.sh

remove-brew:			## Remove Brew
						sudo true
						curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh | sudo -u $$USER bash

# Help
.PHONY: help

help:					## Display help
						@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.DEFAULT_GOAL := 	help
