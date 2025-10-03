#!/bin/bash

# Directory to clone repos into (first argument)
TARGET_DIR="$1"

# Array of "user/repo" strings
REPOS=(
	# "prabirshrestha/vim-lsp"
	# "mattn/vim-lsp-settings"
	# "github/copilot.vim"
	# "iamcco/markdown-preview.nvim"
	# "rust-lang/rust.vim"
	# "prabirshrestha/asyncomplete.vim"
	# "prabirshrestha/asyncomplete-lsp.vim"
	# "tpope/vim-fugitive"
	# "tpope/vim-commentary"
	# "tpope/vim-vinegar"
	# "tpope/vim-surround"
	# "preservim/nerdtree"
	# "junegunn/fzf"
	# "junegunn/fzf.vim"
	"tribela/vim-transparent"
)

for repo in "${REPOS[@]}"; do
    repo_name="${repo##*/}"
    target_dir="$HOME/.vim/pack/plugins/start/$repo_name"
    mkdir -p "$target_dir"
    git clone "https://github.com/$repo.git" "$target_dir"
done

