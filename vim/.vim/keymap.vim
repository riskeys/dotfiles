" keymap.vim
 
" nnoremap <leader>fjp ggVG:!jq<CR>
" nnoremap <leader>fju ggVG:!jq fromjson<CR>
" nnoremap <leader>fjs ggVG:!jq tojson<CR>
 
" --- copy to new buffer and format with jq
nnoremap <leader>aa yy:vnew<CR>:read !<C-r>"<CR>
nnoremap <leader>ab GV:!jq<CR>
 
" --- tab navigation
nnoremap <C-n> gt
nnoremap <C-p> gT
 
" terminal
" tnoremap <Esc> <C-><C-n>
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
 
" --- Vim Config file things
nnoremap <leader>ev :tabnew $MYVIMRC<CR>
nnoremap <leader>eg :tabnew $MYGVIMRC<CR>
 
nnoremap <leader>ov :e $MYVIMRC<CR>
nnoremap <leader>og :e $MYGVIMRC<CR>
 
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>sg :source $MYVIMRC<CR>
 
" --- buffer things
nnoremap <BS> :bn<CR>
nnoremap \ :bp<CR>
nnoremap <C-b><C-x> :bd<CR>
nnoremap <C-b><C-f> :buffers<CR>
 
" --- search register
nnoremap <leader>/ :let @/=""<CR>

" --- nerdtree
nnoremap <leader>e :NERDTreeToggle<CR>

" --- fzf
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fr :Rg<CR>
nnoremap <leader>fR :RgHidden<CR>
nnoremap <leader>fc :Commands<CR>
" nnoremap <leader>fC :Colors<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>fM :Maps<CR>
nnoremap <leader>fk :Keymaps<CR>
nnoremap <leader>ft :Tags<CR>

