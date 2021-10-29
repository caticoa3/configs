dotfile_vc:
	# do this after installing ohmyzsh
	echo ".myconfig" >> .gitignore
	mkdir .myconfig
	jupyter_themegit clone --bare https://github.com/caticoa3/configs.git $HOME/.myconfig/
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

neovim_linux:
	sudo add-apt-repository ppa:neovim-ppa/unstable  
	sudo apt install neovim

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
conda_mac:
	curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
	./Miniconda3-latest-MacOSX-x86_64.sh
	# conda install rich

# Setting up jupyter lab with vim
vim_in_jupter_lab:
	pip install jupyterlab_vim
	# for jlab 3+
	pip install jupyterlab-vimrc

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
