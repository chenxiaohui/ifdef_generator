"**
"* (C) 2010-2012 Alibaba Group Holding Limited.
"**
"* This program is free software; you can redistribute it and/or
"* modify it under the terms of the GNU General Public License
"* version 2 as published by the Free Software Foundation.
"**
"* ifdef.vim is for insert ifndef in vim
"**
"* Authors:
"*   yuzhang <xiaohui.cpc@alibaba-inc.com>

"*

if !exists("g:ifndef_prefix")
	let g:ifndef_prefix=''
	"let g:ifndef_strip=''
endif

if !exists("g:ifndef_namespace_outer")
	let g:ifndef_namespace_outer='oceanbase'
endif

if !exists("g:ifndef_namespace_inner")
	let g:ifndef_namespace_inner='common'
endif


function InsertHeadDef(firstLine, lastLine)
    if a:firstLine <1 || a:lastLine> line('$')
        echoerr 'InsertHeadDef : Range overflow !(FirstLine:'.a:firstLine.';LastLine:'.a:lastLine.';ValidRange:1~'.line('$').')'
        return ''
    endif
    let sourcefilename=expand("%:t")
    let definename=substitute(sourcefilename,' ','','g')
    let definename=substitute(definename,'\.','_','g')
    let definename=substitute(definename,'/','_','g')
    let definename = toupper(definename)
    "let definename =substitute(definename,g:ifndef_strip,'','g')

    let final_macro_name = g:ifndef_prefix.definename


    exe 'normal '.a:firstLine.'GO'
    call setline('.', '#ifndef '.final_macro_name."_")
    normal ==o
    call setline('.', '#define '.final_macro_name."_")
    normal ==o
    call setline('.', 'namespace '.g:ifndef_namespace_outer)
    normal ==o
    call setline('.', '{')
    normal ==o
    call setline('.', 'namespace '.g:ifndef_namespace_inner)
    normal ==o
    call setline('.', '{')


    exe 'normal =='.(a:lastLine-a:firstLine+1).'jo'
    call setline('.', '}//'.g:ifndef_namespace_inner)
    normal ==o
    call setline('.', '}//'.g:ifndef_namespace_outer)
    normal ==o
    call setline('.', '#endif //'.final_macro_name."_")
    exe 'normal gg=G'
endfunction

function InsertHeadDefN()
    let firstLine = 1
    let lastLine = line('$')
    let n=1
    while n < 20
        let line = getline(n)
        if n==1
            if line =~ '^\/\*.*$'
                let n = n + 1
                continue
            else
                break
            endif
        endif
        if line =~ '^.*\*\/$'
            let firstLine = n+1
            break
        endif
        let n = n + 1
    endwhile
    call InsertHeadDef(firstLine, lastLine)
endfunction

