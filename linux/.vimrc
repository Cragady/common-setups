" UsrAdd : Commands in /etc/vim/vimrc

"" :set number relativenumber

"" :augroup numbertoggle
"" :  autocmd!
"" :  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"" :  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
"" :augroup END

"" :set laststatus=2
"" :set statusline=%f%m%r%h%w\ [%Y]\ [0x%02.2B]%<\ %F%=%4v,%4l\ %3p%%\ of\ %L

"" :set tabstop=4
"" :set shiftwidth=4
"" :set expandtab

syntax on
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
:augroup END

:set laststatus=2
:set statusline=%f%m%r%h%w\ [%Y]\ [0x%02.2B]%<\ %F=%4v,%4l\ %3p%%\ of\ %L


:set hlsearch
:set tabstop=4
:set shiftwidth=4
:set expandtab
