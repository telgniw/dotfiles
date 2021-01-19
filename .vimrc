syntax on

set autoindent
set encoding=utf-8
set expandtab
set hlsearch
set list
set listchars=tab:»·,trail:·
set number
set ruler
set smartindent
set ts=2 sts=2 sw=2

map dl :diffget LOCAL<CR>
map db :diffget BASE<CR>
map dr :diffget REMOTE<CR>

autocmd BufRead,BufNewFile Dockerfile.* set filetype=dockerfile
