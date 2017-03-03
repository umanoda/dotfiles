if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
autocmd!
augroup END

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}


"タブ、空白、改行の可視化
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%

"全角スペースをハイライト表示
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta guifg=DarkMagenta
endfunction

if has('syntax')
  augroup ZenkakuSpace
  autocmd!
  autocmd ColorScheme       * call ZenkakuSpace()
  autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

" Set filetype
autocmd BufRead,BufNewFile *.slim setfiletype slim
autocmd BufRead,BufNewFile Guardfile,*.jbuilder setfiletype ruby

" Settings
set nu
set hlsearch
set noautoindent
set laststatus=2

" Fold
set foldmethod=syntax
set foldlevel=100 "Don't autofold anything

" 矢印の上下で、表示上の行移動をする
" 表示行単位で上下移動するように
nnoremap <Down> gj
nnoremap <Up>   gk

syntax enable
filetype plugin indent on
