vim_to_nvim:
	rm ~/.config/nvim/init.vim
	cp ~/.vimrc ~/.config/nvim/init.vim 

neovim_linux:
	sudo add-apt-repository ppa:neovim-ppa/unstable  
	sudo apt install neovim

