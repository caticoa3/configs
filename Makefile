dotfile_vc:
	# do this after installing ohmyzsh
	echo ".myconfig" >> .gitignore
	mkdir .myconfig
	git clone --bare https://github.com/caticoa3/configs.git $HOME/.myconfig/
	alias config='/usr/bin/git --git-dir=$HOME/.myconfig/ --work-tree=$HOME'
	config checkout
	config config --local status.showUntrackedFiles no

set_zsh:
	chsh -s $(which zsh)

vim_to_nvim:
	rm -rf ~/.config/nvim/
	mkdir ~/.config/nvim/
	ln -s ~/.vimrc ~/.config/nvim/init.vim
	# cp ~/.vimrc ~/.config/nvim/init.vim 
	mv ~/.gitconfig ~/.gitconfig_original
	cp ~/.gitconfig_template ~/.gitconfig
	git config --global core.editor "nvim"

neovim_linux: ## Complete Neovim setup with all dependencies on Ubuntu/Debian
	@echo "Installing Neovim and dependencies..."
	
	# Add Neovim stable PPA and install
	sudo add-apt-repository ppa:neovim-ppa/stable -y
	sudo apt update
	sudo apt install -y neovim
	
	# Install build tools and core dependencies
	sudo apt install -y build-essential unzip
	
	# Install search and file finding tools
	sudo apt install -y ripgrep fd-find
	sudo ln -sf $$(which fdfind) /usr/local/bin/fd
	
	# Install Python dependencies
	sudo apt install -y python3-pip python3-venv python3.12-venv
	pip3 install --upgrade pynvim
	
	# Install Node.js via nvm (if not already installed)
	@if [ ! -d "$$HOME/.config/nvm" ]; then \
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash; \
		export NVM_DIR="$$HOME/.config/nvm"; \
		[ -s "$$NVM_DIR/nvm.sh" ] && \. "$$NVM_DIR/nvm.sh"; \
		nvm install --lts; \
		nvm use --lts; \
		nvm alias default node; \
	fi
	
	# Install neovim npm package (requires terminal restart if nvm was just installed)
	@if command -v npm >/dev/null 2>&1; then \
		npm install -g neovim; \
	else \
		echo "Node.js/npm not found in PATH. Restart terminal and run: npm install -g neovim"; \
	fi
	
	# Install fzf (latest version)
	@if [ ! -d "$$HOME/.fzf" ]; then \
		git clone --depth 1 https://github.com/junegunn/fzf.git $$HOME/.fzf; \
		$$HOME/.fzf/install --all; \
	fi
	
	@echo ""
	@echo "Neovim setup complete!"
	@echo "Next steps:"
	@echo "  1. Restart your terminal (for nvm/fzf to load)"
	@echo "  2. If nvm was just installed, run: npm install -g neovim"
	@echo "  3. Run 'nvim' and let plugins install via lazy.nvim"
	@echo "  4. Run ':checkhealth' in nvim to verify everything"

pimp_jupyter:
	conda install -c conda-forge jupyter_contrib_nbextensions
	conda install -c conda-forge jupyterthemes

pimp_zsh_linux:
	rm -rf $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
	mkdir -f ~/.local/share/fonts
	cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
	fc-cache -f -v
	# exit and restart terminal to update fonts
	# might need to select Droid Sans ... in the terminal profile settings GUI

pimp_zsh_osx:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

setup_conda_linux:
	wget -c https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh
	bash Anaconda3-2020.07-Linux-x86_64.sh 

# TODO: Setup conda on OSX and install rich library
# TODO: brew installs: yarn, node, pandoc, xelatex, precommit, delta, etc
#https://medium.com/macoclock/how-to-setup-pandoc-and-latex-on-macos-mojave-8e18fa71e816
conda_mac:
	curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
	./Miniconda3-latest-MacOSX-x86_64.sh
	# conda install rich

# Setting up jupyter lab with vim
vim_in_jupter_lab:
	conda install jupyterlab_vim
	# for jlab 3+, not available for 4+
	# pip install jupyterlab-vimrc

# Modern JupyterLab setup with LSP and language servers
jupyter_lsp_setup:
	conda install jupyterlab-lsp
	conda install jupyter-ruff -c conda-forge
	npm install --save-dev pyright sql-language-server dockerfile-language-server-nodejs

# jupyter themes -vim option removes jupyter notebook customizations  
# workaround is to save custom.js to a temp file then restore
jupyter_light:
	echo 'did you "conda activate" first?'
	mv ~/.jupyter/custom/custom.js ~/.jupyter/custom/temp_custom.js
	jt -t grade3 -fs 95 -altp -tfs 11 -nfs 115 -cellw 88% -T -vim -N
	mv ~/.jupyter/custom/temp_custom.js ~/.jupyter/custom/custom.js
	echo 'switched Jupyter to light theme'

jupyter_dark:
	echo 'did you "conda activate" first?'
	mv ~/.jupyter/custom/custom.js ~/.jupyter/custom/temp_custom.js
	jt -t onedork -fs 95 -altp -tfs 11 -nfs 115 -cellw 88% -T -vim
	mv ~/.jupyter/custom/temp_custom.js ~/.jupyter/custom/custom.js
	echo 'switched Jupyter to dark theme'

# after installing tmux with brew
tmux_setup:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	# then run prefix + I (capital i) to install plugins

clean_git_repo:
	# delete all local branches that have been merged to master 
	git branch --merged | egrep -v "(^\*|master|main|dev)" | xargs git branch -d
	# delete local versions of remote branches...remote/origin/branchname
	git fetch --prune
