"#####display setting#####
colorscheme desert "change colorscheme
syntax enable "add color for syntax
set number "show line numbers
hi LineNr term=NONE cterm=NONE ctermfg=gray ctermbg=NONE "set the color of line number
set tabstop=2 "width of tab as shown
set softtabstop=2 "width of tab input by tab key
set shiftwidth=2 "widhth of automatic indent
set autoindent "keep previous indent
set smartindent "for more smart indent?
set nowrap "prohibit wrapping
set cursorline "show cursor line
hi clear CursorLine "clear cursor line
hi CursorLineNr term=underline cterm=NONE ctermfg=yellow ctermbg=NONE "set the color of cursor number

"#####search setting#####
set ignorecase "search regardless of upper or lower case
set hlsearch "highlight search word
set wrapscan "return back from the end of search to the top			

"#####omni completion#####
set omnifunc=syntaxcomplete#Complete

"#####auto command#####
"show complement HTML closing tag
augroup close_html_tag
	autocmd!
	autocmd Filetype xml inoremap <buffer> </ </<C-x><C-p><C-n>
	autocmd Filetype html inoremap <buffer> </ </<C-x><C-p><C-n>
	autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-p><C-n>
augroup END
