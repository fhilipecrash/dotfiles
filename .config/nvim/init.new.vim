" VimPlug START
call plug#begin('~/.vim/plugged')


"Conquer of Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Linting with ALE
Plug 'w0rp/ale'

" Enable multiple selection with <C-n>
Plug 'terryma/vim-multiple-cursors'

" Auto close tags and etc
Plug 'jiangmiao/auto-pairs'

" Match tags
Plug 'gregsexton/MatchTag'

" Auto close HTML tags
Plug 'alvan/vim-closetag'

" Pretty start screen
Plug 'https://github.com/mhinz/vim-startify'

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Nice icons
Plug 'ryanoasis/vim-devicons'

" NERDTree syntax highlighting
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Status bar
Plug 'itchyny/lightline.vim'

" Theme
"Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'joshdick/onedark.vim', { 'as': 'onedark' }


" VimPlug END
call plug#end()


"##############################################################################################################
" Some vim configuration
"##############################################################################################################


"#######################################################
" Closetag configuration
"#######################################################
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'


"#######################################################
" Deoplete configuration
"#######################################################
let g:deoplete#enable_at_startup = 1


"#######################################################
" NERDTree settings
"#######################################################

"    Autostart NERDTree
autocmd vimenter * NERDTree

"    Autostart in edit area
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" Determines what char to use as identation guide
let g:indentLine_char = '|'

"    Open NERDTree binding
map <C-k> :NERDTreeToggle<CR>

"    Open _my-sources folder
map <F10> :NERDTree /home/fhilipe/www/


"#######################################################
" Lightline settings
"#######################################################

set laststatus=2

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'filename' ], [ 'bufferline' ] ],
      \ },
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \'bufferline': '%{bufferline#refresh_status()}%{g:bufferline_status_info.before . g:bufferline_status_info.current . g:bufferline_status_info.after}',
      \ },
      \ 'separator':    { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
\ }
