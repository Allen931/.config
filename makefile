install: brew clean backup symlink

repos := homebrew/cask-fonts
formulas := bat coreutils exa fd fzf multitail pyenv pipenv ripgrep trash
casks := font-fira-code karabiner-elements visual-studio-code
no-update := HOMEBREW_NO_AUTO_UPDATE=1
brew:
	brew upgrade
	$(foreach r, $(repos), $(no-update) brew tap $(r); )
	$(foreach f, $(formulas), $(no-update) brew install $(f) 2> /dev/null; )
	$(foreach c, $(casks), $(no-update) brew cask install $(c) 2> /dev/null; )

code-config := ~/Library/Application\ Support/Code/User
git-config := ~/.gitconfig
p10k-config := ~/.p10k.zsh
ssh-config := ~/.ssh/config
zsh-config := ~/.zshrc
configs := $(code-config) $(git-config) $(p10k-config) $(ssh-config) $(zsh-config)

clean:
	trash -F $(foreach c, $(configs), $(wildcard $(c)~))

backup:
	$(foreach c, $(configs), mv -iv $(c) $(c)~; )

makefile-dir := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
symlink:
	ln -isv $(makefile-dir)visual-studio-code/settings.json $(code-config)
	ln -isv $(makefile-dir)git/.gitconfig $(git-config)
	ln -isv $(makefile-dir)ssh/config $(ssh-config)
	ln -isv $(makefile-dir)zsh/.p10k.zsh $(p10k-config)
	ln -isv $(makefile-dir)zsh/.zshrc $(zsh-config)
