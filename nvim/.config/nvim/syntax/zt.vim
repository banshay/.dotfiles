" zt: Zig with HTML inside `templ` bodies.
" Layers: zig at top level -> html inside templ blocks -> zig inside {expr},
" @Component(...) calls and for/if control lines.

if exists('b:current_syntax')
  finish
endif

runtime! syntax/zig.vim
unlet! b:current_syntax

syn include @ztZig syntax/zig.vim
unlet! b:current_syntax
syn include @ztHtml syntax/html.vim
unlet! b:current_syntax

syn cluster ztTemplCluster contains=@ztHtml,ztZigExpr,ztComponent,ztControlLine

" {expr} interpolation, also inside quoted attribute values via htmlPreproc
syn region ztZigExpr matchgroup=ztZigDelim start=/\v\{/ end=/\v\}/ contained contains=@ztZig
syn cluster htmlPreproc add=ztZigExpr

" @Component(args) calls
syn region ztComponent matchgroup=ztComponentName start=/\v^\s*\zs[@]\w+/ end=/\v\ze\)/ contained contains=@ztZig

" for/if control blocks inside templ bodies
syn region ztControlLine matchgroup=Keyword start=/\v^\s*(for|if)\s+\ze/ end=/\v\ze\{/ contained keepend contains=@ztZig nextgroup=ztControlBody
syn region ztControlBody matchgroup=Delimiter start=/\v\{\ze/ end=/\v^\s*\}/ contained contains=@ztTemplCluster,ztControlBody

" templ blocks: zig signature, html body
syn region ztTemplSig matchgroup=Keyword start=/\<templ\ze\s/ end=/\ze{/ keepend contains=@ztZig nextgroup=ztTemplBody
syn region ztTemplBody matchgroup=Delimiter start=/\v\{/ end=/\v^\s*\}/ contained contains=@ztTemplCluster

hi def link ztZigDelim Delimiter
hi def link ztComponentName Function

let b:current_syntax = 'zt'
