# Install your environment

.PHONY: boot-macos

boot-macos:
						## Install Brew
						sudo true
						curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sudo -u $$USER bash

						## Install Git
						brew install git

						## Install PHPStorm
						brew install --cask phpstorm

						## Install Slack
						brew install --cask slack

						## Install iTerm2
						brew install --cask iterm2

						## Install Docker Desktop app
						brew install --cask docker

						## Install Docker
						brew install docker

						## Install Starship
						brew install starship

						## Install Symfony CLI
						brew install symfony-cli/tap/symfony-cli

						## Install Mutagen Compose
						brew install mutagen-io/mutagen/mutagen-compose-beta

						## Install Oh My ZSH
						curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sudo -u $$USER bash

# Help
.PHONY: help

help:					## Display help
						@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.DEFAULT_GOAL := 	help
