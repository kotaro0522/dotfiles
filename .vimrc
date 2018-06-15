"#####display setting#####
autocmd Colorscheme * highlight FullWidthSpace ctermbg=red "emphasize full-width space
autocmd VimEnter * match FullWidthSpace /　/ "emphasize full-width space
colorscheme ron "change colorscheme
syntax enable "add color for syntax
set number "show line numbers
hi LineNr term=NONE cterm=NONE ctermfg=gray ctermbg=NONE "set the color of line number
set expandtab "replace tab with spaces
set tabstop=8 "width of tab as shown
set softtabstop=2 "width of spaces input by tab key
set shiftwidth=2 "widhth of automatic indent
set autoindent "keep previous indent
set smartindent "for more smart indent?
set nowrap "prohibit wrapping
set cursorline "show cursor line
hi clear CursorLine "clear cursor line
hi CursorLineNr term=underline cterm=NONE ctermfg=yellow ctermbg=NONE "set the color of cursor number
hi Comment ctermfg=243 "set the color of comment
hi ErrorMsg ctermfg=white ctermbg=124 "change the color of error message
"###diff color###
hi DiffAdd ctermbg=2
hi DiffChange ctermbg=6
hi DiffDelete ctermfg=black ctermbg=1
hi DiffText ctermbg=4


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
