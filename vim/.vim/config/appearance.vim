" create a local variable to hold the toggle value for dark and light mode
 
hi comment ctermbg=NONE
hi Normal ctermbg=NONE
hi NonText ctermbg=NONE
hi Normal  guibg=NONE
hi NonText guibg=NONE

let g:dark_mode = 1
colorscheme slate

function! SetColorscheme()
	if g:dark_mode == 1
		colorscheme morning
		TransparentDisable
		hi comment ctermfg=Red
		let g:dark_mode = 0
	else
		colorscheme slate
		TransparentEnable
		hi comment ctermfg=Red
		let g:dark_mode = 1
	endif
endfunction

nnoremap <C-m> :call SetColorscheme()<CR>

autocmd FileType typescript hi comment ctermfg=Red
