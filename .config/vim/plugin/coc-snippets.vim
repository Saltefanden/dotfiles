let g:coc_snippet_next = '<C-n>'

"inoremap <silent><expr> <C-y>
"  \ coc#pum#visible() ? coc#_select_confirm() :
"  \ coc#expandableOrJumpable() ?
"  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"  \ "\<C-y>"

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'


