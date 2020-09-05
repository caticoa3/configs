dotfile_vc:
	echo ".myconfig" >> .gitignore
	mkdir .myconfig
	git clone --bare https://github.com/caticoa3/configs.git
	alias config='/usr/bin/git --git-dir=$HOME/.myconfig/ --work-tree=$HOME'
	config checkout

set_zsh:
	chsh -s $(which zsh)

vim_to_nvim:
	rm ~/.config/nvim/init.vim
	cp ~/.vimrc ~/.config/nvim/init.vim 
	git config --global core.editor "nvim"

neovim_linux:
	sudo add-apt-repository ppa:neovim-ppa/unstable  
	sudo apt install neovim

pimp_zsh_linux:
	rm -r $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
	mkdir ~/.local/share/fonts
	cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
	# then select Droid Sans ... from in the terminal profile settings GUI


