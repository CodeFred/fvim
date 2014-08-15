# About
`fvim` is a set of configurations and plug ins that I have collected over the years as a vim user.

I recently did a major long overdue upgrade, based on [this collection](https://github.com/amix/vimrc) by Amir Salihefendic, and [this blog post](http://items.sjbach.com/319/configuring-vim-right) by Stephen Bach.

# Usage
1. Clone this repo.
2. Change your `.vimrc` file to look like this:

		# Replace <FVIM_DIR> with the directory where
		# fvim is installed 
		source <FVIM_DIR>/vimrc/vimrc.vim
		
3. Initialize the submodules

		git submodule init
		git submodule update
		
4. Install the `Meslo LG S for Powerline` font (from `tools/powerline-fonts`)
5. You need to install the Exuberant Ctags for `taglist.vim` to work.

		brew tap homebrew/dupes
		brew install ctags
		echo 'export PATH=/usr/local/bin:$PATH' >> ~/.profile

6. If you need JavaScript autocomplete, be sure you have `npm` installed, and initialize `tern_for_vim`:

		brew install npm
		cd <FVIM_DIR>/sources/tern_for_vim
		npm install

7. You might want to support `vim-go`, you need to install `go`, `hg`, and set `$GOPATH`, and other annoyances. (Honestly, I'm thinking of removing it from the list of plugins because it's so whiny and needy.)

		brew install go
		brew install hg
		echo 'export GOPATH=/usr/local/opt/go' >> ~/.profile

# Screenshot

![](assets/screenshot1.png)

# Notes

The first time you boot vim after having installed `go` and `hg`, `vim-go` will take a while and create a directory `~/.vim-go`.

Please don't remove it, as it's only slow to load if such a directory does not exist. If I ever remove `vim-go` from the list of plugins, feel free to delete this folder.
