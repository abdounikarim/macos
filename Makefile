# Install your environment

.PHONY: boot-macos

boot-macos:
						## Install Docker
						brew install docker

						## Install Docker-Compose
						brew install docker-compose

						## Install Docker Desktop app
						brew install --cask docker

						## Install PHPStorm
						brew install --cask phpstorm

						## Install Slack
						brew install --cask slack
            
						## Install iTerm2
            brew install --cask iterm2

						## Install Starship
            brew install starship

						## Install Symfony CLI
						brew install symfony-cli/tap/symfony-cli

						## Move Symfony CLI
						mv /Users/$(USER)/.symfony/bin/symfony /usr/local/bin/symfony

# Help
.PHONY: help

help:					## Display help
						@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.DEFAULT_GOAL := 	help
