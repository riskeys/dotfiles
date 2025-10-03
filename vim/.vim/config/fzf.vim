" command! -nargs=* Rg call fzf#vim#grep(
"       \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
"       \   fzf#vim#with_preview(), <bang>0)

" Search including hidden files
command! -nargs=* RgHidden call fzf#vim#grep(
      \ 'rg --hidden --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \ fzf#vim#with_preview(), <bang>0)
