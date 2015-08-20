" PHP Manual
"autocmd FileType php :let g:ref_phpmanual_path = "/home/fumitaka/src/php-chunked-xhtml"
"autocmd FileType php :set dictionary=dict/php.dictionary
"autocmd FileType php :set omnifunc=phpcomplete#CompletePHP

" 括弧の補完
"imap { {}<LEFT>
"imap [ []<LEFT>
"imap ( ()<LEFT>

" for Neobundle {{{
set nocompatible
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle 'Shougo/neosnippet.vim'
    NeoBundle 'majutsushi/tagbar'
    NeoBundle 'Shougo/vimfiler'
    NeoBundle 'Shougo/vimproc'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/unite-outline'
    NeoBundle 'dgryski/vim-godef'
    NeoBundle 'vim-jp/vim-go-extra'
    call neobundle#end()
endif

filetype plugin indent on
syntax on
NeoBundleCheck
" }}}


" for golang {{{
set path+=$GOPATH/src/**
let g:gofmt_command = 'goimports'
au BufWritePre *.go Fmt
au BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4 completeopt=menu,preview
au FileType go compiler go
" }}}

" VimFilerTree {{{
command! VimFilerTree call VimFilerTree(<f-args>)
function VimFilerTree(...)
    let l:h = expand(a:0 > 0 ? a:1 : '%:p:h')
    let l:path = isdirectory(l:h) ? l:h : ''
    exec ':VimFiler -buffer-name=explorer -split -simple -winwidth=45 -toggle -no-quit ' . l:path
    wincmd t
    setl winfixwidth
endfunction
autocmd! FileType vimfiler call g:my_vimfiler_settings()
function! g:my_vimfiler_settings()
    nmap     <buffer><expr><CR> vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
    nnoremap <buffer>s          :call vimfiler#mappings#do_action('my_split')<CR>
    nnoremap <buffer>v          :call vimfiler#mappings#do_action('my_vsplit')<CR>
endfunction

let my_action = {'is_selectable' : 1}
function! my_action.func(candidates)
    wincmd p
    exec 'split '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_split', my_action)

let my_action = {'is_selectable' : 1}
function! my_action.func(candidates)
    wincmd p
    exec 'vsplit '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_vsplit', my_action)
" }}}





" コマンド補完を開始するキー
set wildchar=<tab>
" tags
set tags=./.tags;
" ステータスラインに表示する情報の指定
set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=
" ステータスラインの色
highlight StatusLine   term=NONE cterm=NONE ctermfg=black ctermbg=white

" filetype有効化
filetype plugin indent on
filetype indent on

" 現在行の下線処理
set cursorline
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" for GUI
highlight CursorLine gui=underline guifg=NONE guibg=NONE

set list
"set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

" 基本設定
set number
set numberwidth=6
set ruler
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set showmatch
set backspace=2
set ai
set laststatus=2
syntax on

" バッファ関連
map <silent>    <F2>    :bp<cr>
map <silent>    <F3>    :bn<cr>
nmap bb :ls<CR>:buf 

" ESC to ;;
:imap ;; <Esc>


" Formatter
" http://vim.wikia.com/wiki/Cleanup_your_HTML
command Thtml execute ":%!tidy -q -i -a --show-errors 0"
command Txml execute ":%!tidy -q -i -a --show-errors 0 -xml"

" XML Formatter
"map @@x !%xmllint --format --recover -
map @@x !%xmllint --format --recover

" pathogen settings
execute pathogen#infect()
syntax on
filetype plugin indent on


" 候補のポップアップ中にエンターを入力したときに、改行されるようにする。
"inoremap <expr> <CR> (pumvisible()) ? "\<C-y>\<CR>" : "\<CR>"

" 文字コードの自動認識
"if &encoding !=# 'utf-8'
"  set encoding=japan
"  set fileencoding=japan
"endif
"if has('iconv')
"  let s:enc_euc = 'euc-jp'
"  let s:enc_jis = 'iso-2022-jp'
"  " iconvがeucJP-msに対応しているかをチェック
"  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
"    let s:enc_euc = 'eucjp-ms'
"    let s:enc_jis = 'iso-2022-jp-3'
"  " iconvがJISX0213に対応しているかをチェック
"  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
"    let s:enc_euc = 'euc-jisx0213'
"    let s:enc_jis = 'iso-2022-jp-3'
"  endif
"  " fileencodingsを構築
"  if &encoding ==# 'utf-8'
"    let s:fileencodings_default = &fileencodings
"    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
"    let &fileencodings = &fileencodings .','. s:fileencodings_default
"    unlet s:fileencodings_default
"  else
"    let &fileencodings = &fileencodings .','. s:enc_jis
"    set fileencodings+=utf-8,ucs-2le,ucs-2
"    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
"      set fileencodings+=cp932
"      set fileencodings-=euc-jp
"      set fileencodings-=euc-jisx0213
"      set fileencodings-=eucjp-ms
"      let &encoding = s:enc_euc
"      let &fileencoding = s:enc_euc
"    else
"      let &fileencodings = &fileencodings .','. s:enc_euc
"    endif
"  endif
  " 定数を処分
"  unlet s:enc_euc
"  unlet s:enc_jis
"endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
"if has('autocmd')
"  function! AU_ReCheck_FENC()
"    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
"      let &fileencoding=&encoding
"    endif
"  endfunction
"  autocmd BufReadPost * call AU_ReCheck_FENC()
"endif
"" 改行コードの自動認識
"set fileformats=unix,dos,mac
"" □とか○の文字があってもカーソル位置がずれないようにする
"if exists('&ambiwidth')
"  set ambiwidth=double
"endif
