" lsp.vim
 
filetype plugin on
syntax on
 
function! LspSmartScroll(amount) abort
  if lsp#scroll(a:amount)
    " scrolling worked inside popup
    return ''
  endif
    " fallback: use default CTRL-D/CTRL-U behavior
  if a:amount < 0
    return "<C-d>"
  else
    return "<C-u>"
  endif
endfunction
 
 
" copied (almost) directly from the vim-lsp docs:
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gI <plug>(lsp-implementation)
    " nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    " nnoremap <buffer> <expr><c-u> LspSmartScroll(1)
    " nnoremap <buffer> <expr><c-d> LspSmartScroll(-1)
    nnoremap <buffer> <expr><c-s-k> lsp#scroll(-1)
    nnoremap <buffer> <expr><c-s-j> lsp#scroll(1)
 
 
    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre .rs,.go call execute('LspDocumentFormatSync')
 
    " refer to doc to add more commands
endfunction
 
augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

