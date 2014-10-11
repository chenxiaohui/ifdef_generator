"{{{ some common setting
nmap <Enter> <cr>
nmap <C-J> i<cr><esc>
nmap <leader>sm :set mouse = <cr>
command! -nargs=1 Silent
            \ | execute ':silent !'.<q-args>
            \ | execute ':redraw!'
let g:user_name = $USER
"let g:project_base_dir = '$prj_dir $HOME/src'
let g:server_ip = $server_ip
"}}}

"{{{ plugin: pathogen
"let g:disabled_pathogen=['omnicppcomplete']
call pathogen#runtime_append_all_bundles()
"}}}

" {{{ plugin-freya配色方案
if g:hasgui
    set background=dark
    colorscheme freya
    "colorscheme solarized
endif
" }}}


"{{{ plugin- scope
nmap <leader>v :noh<CR>
nnoremap gl /<C-R>=ScopeSearch('[[', 1)<CR><CR>N
vnoremap gl / <Esc>/<C-R>=ScopeSearch('[[', 2)<CR><CR>N
"}}}

"{{{ plugin-create-implement.vim
nmap <leader>de :CopyDefinition<CR>
nmap <leader>im :ImplementDefinition<CR>
"}}}

"{{{ plugin-ccimpl.vim
"nmap <leader>ci :Implement<cr>
"}}}

"{{{
"in bundle/protodef/plugin/protodef.vim
"nmap <buffer> <silent> <leader>ci :set paste<cr>i<c-r>=protodef#ReturnSkeletonsFromPrototypesForCurrentBuffer({})<cr><esc>='[:set nopaste<cr>
"}}}

" {{{ plugin-配置文件路径
set fileformats=unix,dos,mac
if g:system=='win'
    let $VIMFILES = $VIM."/vimfiles"
    nmap <leader>e :e $VIMFILES/vimrc<cr>
    nmap <leader>r :source $VIMFILES/vimrc<cr>
else
    let $VIMFILES = $HOME."/.vim"
    nmap <leader>e :e $HOME/.vimrc<cr>
    nmap <leader>r :source $HOME/.vimrc<cr>
endif
nmap <leader>ex :e $VIMFILES/vimrc.ex<cr>

"if g:system=='unix'
"set fileformats=unix,dos,mac
"else
"set fileformats=dos,unix,mac
"endif

" helpdoc path
let helptags=$VIMFILES."/doc"
set helplang=cn
"set nobomb
" }}}

" {{{ plugin-编码字体设置
set ambiwidth=double
if g:system=='win'
    set guifont=YaHei\ Consolas\ Hybrid:h12
    set guifontwide=YaHei\ Consolas\ Hybrid:h12
else
    if has("gui_macvim")
        " MacVim 下的字体配置
        set guifont=Menlo:h12
        set guifontwide=Hei:h12
        " 半透明和窗口大小
        set transparency=2
        set lines=40 columns=110

        " 使用MacVim原生的全屏幕功能
        let s:lines=&lines
        let s:columns=&columns

        func! FullScreenEnter()
            set lines=999 columns=999
            set fu
        endf

        func! FullScreenLeave()
            let &lines=s:lines
            let &columns=s:columns
            set nofu
        endf

        func! FullScreenToggle()
            if &fullscreen
                call FullScreenLeave()
            else
                call FullScreenEnter()
            endif
        endf

        " Mac 下，按 \\ 切换全屏
        "nmap <Leader><Leader>  :call FullScreenToggle()<cr>

        " Set input method off
        set imdisable

        " Set QuickTemplatePath
        let guickTemplatePath = $HOME.'/.vim/templates/'
        " 如果为空文件，则自动设置当前目录为桌面
        lcd ~/Desktop/
        " 自动切换到文件当前目录
        set autochdir
        " Set QuickTemplatePath
        let guickTemplatePath = $HOME.'/.vim/templates/'
        "colorscheme molokai
    else
        set guifont=DejaVu\ Sans\ Mono\ 12
        set guifontwide=FZXingKai\-S04\ 12
    endif
endif
" }}}

" {{{ plugin-全文搜索选中的文字
"vnoremap <silent> <leader>f y/<c-r>=escape(@", "\\/.*$^~[]")<cr><cr>
"vnoremap <silent> <leader>F y?<c-r>=escape(@", "\\/.*$^~[]")<cr><cr>
" }}}


"{{{ plugin-snipMate.vim 提供snippets补全
"处理Tex类型
augroup FileTypeGroup
    autocmd!
    autocmd BufRead,BufNewFile *.tex :set filetype=tex
    au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
    au BufRead,BufNewFile *.go set filetype=go
    au BufRead,BufNewFile *.js set syntax=jquery
    autocmd FileType * set tabstop=4 shiftwidth=4  expandtab
    autocmd FileType cpp set tabstop=2 shiftwidth=2  expandtab
    autocmd FileType make set noet
    " PHP Twig 模板引擎语法
    "au BufRead,BufNewFile *.twig set syntax=twig
augroup END
let g:snips_author='ChenXiaohui'
let g:snips_email='sdqxcxh@gmail.com'
"}}}

"{{{ plugin-snipMate.vim 提供snippets补全
let g:ifndef_prefix="OCEANBASE_"
"let g:ifndef_strip="OB_"
let g:ifndef_namespace_outer="oceanbase"
let g:ifndef_namespace_inner="updateserver"
nmap <leader>df :call InsertHeadDefN()<cr>
"}}}

"{{{ 字典
augroup DictGroup
    autocmd!
    " 设置字典 ~/.vim/dict/文件的路径
    "autocmd filetype javascript :set dictionary=$VIMFILES/dict/javascript.dict
    "autocmd filetype css :set dictionary=$VIMFILES/dict/css.dict
    "autocmd filetype php :set dictionary=$VIMFILES/dict/php.dict
    autocmd BufEnter *.* :exec "set dict=".$VIMFILES."/dict/".&ft.".dict"
augroup END
"}}}

" {{{ plugin-设置剪贴和光标
if (g:system=='unix' && !g:hasgui)
    "clip
    vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
    nmap <leader>p :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
    vmap <leader>p d:call setreg("\"",system("xclip -o -selection clipboard"))<CR>P
    "nmap <leader>P :silent! execute ":r scp://xiaohui.cpc@10.232.31.8/bin/clipboard"<CR>
    function! PasteClip(server_ip)
        :silent! execute 'r scp://xiaohui.cpc@'.a:server_ip.'/bin/clipboard'
    endf
    nmap <leader>P :call PasteClip($server_ip)<cr>
    nmap <leader>P0 :call PasteClip($test_ip0)<cr>
    nmap <leader>P2 :call PasteClip($test_ip2)<cr>
    "光标
    if($USER!="root")
        augroup CursorShape
            autocmd!
            au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
            au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
            au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
        augroup END
    endif
endif
" }}}

" {{{ plugin - renamer.vim 文件重命名
" :Renamer 将当前文件所在文件夹下的内容显示在一个新窗口
" :Ren 开始重命名
"}}}

" {{{ plugin - visualmark.vim 设置标记（标签）
" <c-f2> 设置标记    <f2> 向下跳转标记   <s-f2> 向上跳转标记
"}}}

" {{{ plugin - matchit.vim 对%命令进行扩展使得能在嵌套标签和语句之间跳转
" % 正向匹配      g% 反向匹配
" [% 定位块首     ]% 定位块尾
"}}}


" {{{ plugin – ZenCoding.vim 很酷的插件，HTML代码生成
" 插件最新版：http://github.com/mattn/zencoding-vim
" 常用命令可看：http://nootn.com/blog/Tool/23/
let g:user_zen_settings = {
            \    'lang': "zh-cn"
            \}
" }}}


" {{{ plugin -ocotpress  写octopress博客的插件
function! RakePreview()
    execute "w"
    silent! execute "!rake isolate['".expand("%<")."']"
    silent! execute "!rake generate"
    silent! execute "!rake preview"
endf

nmap <leader>rp :call RakePreview()<cr>
" }}}

" {{{ plugin –vimpress  写wordpress博客的插件
"let VIMPRESS = [{'username':'sdqxcxh',
"\'password':'justfe3lit.x',
"\'blog_url':'http://www.roybit.com/xmlrpc.php'
"\}]
"nmap <leader>bl :BlogList <cr>
"nmap <leader>bn :BlogNew <cr>
"nmap <leader>bs :BlogSave <cr>
"nmap <leader>bp :BlogPreview <cr>
" }}}

" {{{ plugin - checksyntax.vim 语法检查
let g:checksyntax_auto=0
"一些不错的映射转换语法（如果在一个文件中混合了不同语言时有用）
nnoremap <leader>1 :set filetype=xhtml<cr>
nnoremap <leader>2 :set filetype=css<cr>
nnoremap <leader>3 :set filetype=javascript<cr>
nnoremap <leader>4 :set filetype=php<cr>
nnoremap <leader>5 :call DjangoType()<cr>

function! DjangoType()
    let ext=expand("%:e")
    if ext=='py'
        set ft=python.django
        echo 'set ft=python.django '
    elseif ext=='html' || ext=='htm'
        set ft=htmldjango.html
        echo 'set ft=htmldjango.html'
    endif
endf
" }}}

" {{{ plugin - auto_mkdir.vim 自动创建目录
" }}}


" {{{ plugin - mru.vim 记录最近打开的文件
let MRU_File = $HOME."/.vimtemp/_vim_mru_files"
let MRU_Max_Entries = 1000
let MRU_Add_Menu = 0
nmap <c-f> :MRU<cr>
" }}}

" {{{ plugin -ctags 对tag的操作
"let g:ctags_path=$VIMFILES.'/ctags.exe'
"let g:ctags_statusline=1
"let g:ctags_args=1
"set tags=tags
"let  tagpath=split(globpath($VIMFILES."/tags/".&ft,"**"))
"let tagcmd="set tags+="
"for path in tagpath
"let tagcmd.=path.","
"endfor
"autocmd! FileType * exec tagcmd
set tags=tags
augroup TagGroup
    autocmd!
    "autocmd BufEnter *.* :exec 'set tags=tags,'.$VIMFILES.'/tags/'.&ft.'/tags'
    autocmd BufEnter * :call AutoLoadCTagsAndCScope()
    "autocmd BufWritePost *.cpp,*.c,*.h :silent! execute "!ctags -R  -c++-kinds=+p --fields=+iaS --extra=+q ."
augroup END
"}}}



" {{{ plugin - taglist.vim 代码导航
"if g:system=='win'
    "let g:Tlist_Ctags_Cmd = 'ctags.exe'
"else
    "let g:Tlist_Ctags_Cmd = 'ctags'
"endif
"" 不同时显示多个文件的tag，只显示当前文件的
"let Tlist_Show_One_File = 1
"" 如果taglist窗口是最后一个窗口，则退出vim
"let Tlist_Exit_OnlyWindow = 1
"" 在右侧窗口中显示taglist窗口
"let Tlist_Use_Right_Window = 1

"let Tlist_Auto_Highlight_Tag = 1
"let Tlist_Auto_Open = 0
"let Tlist_Auto_Update = 1
"let Tlist_Close_On_Select = 1
"let Tlist_Compact_Format = 1
"let Tlist_Display_Prototype = 0
"let Tlist_Display_Tag_Scope = 1
"let Tlist_Enable_Fold_Column = 0
"let Tlist_File_Fold_Auto_Close = 1
"let Tlist_GainFocus_On_ToggleOpen = 1
"let Tlist_Hightlight_Tag_On_BufEnter = 1
"let Tlist_Inc_Winwidth = 0
"let Tlist_Max_Submenu_Items = 1
"let Tlist_Max_Tag_Length = 30
"let Tlist_Process_File_Always = 1
"let Tlist_Show_Menu =0
"let Tlist_Sort_Type = "order"
"let Tlist_Use_Horiz_Window = 0
"let Tlist_WinHeight = 7
"let Tlist_WinWidth = 31
"let tlist_php_settings ='php;c:class;i:interfaces;d:constant;f:function'
"map <silent> <S-F8> :TlistToggle<cr>
" }}}

"{{{ multi_cursor
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
"}}}

"{{{ tagbar taglist replcement
nmap <silent><S-f8> :TagbarToggle<CR>
if g:system=='win'
    let g:tagbar_ctags_bin = 'ctags.exe'
else
    let g:tagbar_ctags_bin = 'ctags'
endif
let g:tagbar_autoclose = 1
let g:tagbar_width = 30
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_autofocus = 1
"}}}


"{{{ plugin - cscopemaps.vim里面定义了键盘映射
let g:base_dir_mark = 'tags'
map <silent><F7> :call AutoLoadCTagsAndCScope()<CR>
map <silent><C-F7> :call Do_CsTag()<CR>
"map <F3> <C-]>
map <F3> :execute(":tj ".expand("<cword>"))<cr>
map <m-left> <C-o>
map <m-right> <c-i>

"map <silent><S-F4><Esc>:!ctags -R *<CR>
"map <silent><C-F4><Esc>:silent! execute "!ctags -R -c++-kinds=+p --fields=+iaS --extra=+q ."<CR>
"查找调用这个定义
"nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"查找调用这个c符号的地方
nmap <leader>cf :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>ck :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>cg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>ct :cs find t <C-R>=expand("<cword>")<CR><CR>

"查找调用这个函数的地方
"nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"}}}

" {{{ plugin-insert if define
nnoremap <leader>df :call InsertHeadDefN()<CR>

nnoremap <leader>g :Grep 
nnoremap <leader>G :vimgrep // **/*.*<left><left><left><left><left><left><left><left>
vnoremap <leader>g y<ESC>:Grep <c-r>" <CR>
"vnoremap <Leader>g :execute 'Grep ' . expand('<cword>')
" }}}

" {{{ plugin-rename variable
" For local replace

vnoremap <leader>rn y<esc>:%s/<c-r>=escape(@", "\\/.*$^~[]")<cr>/<C-R>=input("new name: ",'<c-r>"')<CR>/gc<left><left><left>
nnoremap <leader>rn :%s/\<<C-R>=expand("<cword>")<CR>\>/<C-R>=input("new name: ",expand("<cword>"))<CR>/gc<left><left><left>
nnoremap <leader>rl :call ScopeSubstitude('[[',1)<CR>
vnoremap <leader>rl :call ScopeSubstitude('[[',2)<CR>
" }}}

" {{{ plugin - NERD_commenter.vim 注释代码用的，以下映射已写在插件中
" <leader>ca 在可选的注释方式之间切换，比如C/C++ 的块注释/* */和行注释//
" <leader>cc 注释当前行
" <leader>cs 以”性感”的方式注释
" <leader>cA 在当前行尾添加注释符，并进入Insert模式
" <leader>cu 取消注释
" <leader>cm 添加块注释
" }}}


" {{{ plugin - NERD_tree.vim 文件管理器
" 让Tree把自己给装饰得多姿多彩漂亮点
let NERDChristmasTree=1
" 控制当光标移动超过一定距离时，是否自动将焦点调整到屏中心
let NERDTreeAutoCenter=1
" 指定书签文件
let NERDTreeBookmarksFile=$HOME.'/.vimtemp/NERDTree_bookmarks'
" 指定鼠标模式(1.双击打开 2.单目录双文件 3.单击打开)
let NERDTreeMouseMode=2
" 是否默认显示书签列表
let NERDTreeShowBookmarks=1
" 是否默认显示文件
let NERDTreeShowFiles=1
" 是否默认显示隐藏文件
let NERDTreeShowHidden=1
" 是否默认显示行号
let NERDTreeShowLineNumbers=0
" 窗口位置（'left' or 'right'）
let NERDTreeWinPos='left'
" 窗口宽度
let NERDTreeWinSize=31
" fiter
let NERDTreeIgnore = ['\.pyc$', '\.swp$']
let NERDTreeQuitOnOpen = 1
":noremap <silent> <F9> :NERDTreeToggle<cr>
map <F8> :NERDTreeToggle<cr>
"augroup NerdTreeGroup
"autocmd!
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p
"augroup END
"}}}


""{{{ plugin-OmniCppComplete
""OmniCppComplete
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_MayCompleteDot = 1
"let OmniCpp_DisplayMode = 1
"let OmniCpp_MayCompleteArrow = 1
"let OmniCpp_MayCompleteDot = 1
"let OmniCpp_ShowScopeInAbbr = 0
"let OmniCpp_SelectFirstItem =2
"let OmniCpp_ShowPrototypeInAbbr = 0
"let OmniCpp_MayCompleteScope = 1
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
""automatically open and close the popup menu / preview window
"augroup OmniGroup
"autocmd!
"autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"augroup END
"set completeopt=menuone,menu,longest
""}}}

" {{{ plugin - NeoComplCache.vim 自动提示插件
" Disable AutoComplPop. Comment out this line if AutoComplPop is not installed.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
"禁用自动完成
"let g:NeoComplCache_Disable_Auto_complete = 1
"启用自动代码提示
nnoremap <Leader>en :NeoComplCacheEnable<CR>
"禁用自动代码提示
nnoremap <Leader>di :NeoComplCacheDisable<CR>

" Define dictionary.
"let g:neocomplcache_dictionary_filetype_lists = {
"\ 'default' : '',
"\ 'css' : $VIMFILES.'/dict/css.dict',
"\ 'php' : $VIMFILES.'/dict/php.dict',
"\ 'javascript' : $VIMFILES.'/dict/javascript.dict'
"\ }
"let g:neocomplcache_filename_include_exts.cpp =
"\ ['', 'h', 'hpp', 'hxx']
let g:neocomplcache_snippets_dir=$VIMFILES."/snippets"
let g:snippets_dir=$VIMFILES."/snippets"
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 4
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" set the max list in the popup menu. increase the speed
let g:neocomplcache_max_list=20
" ignore letter case
let g:neocomplcache_enable_ignore_case=1

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
"imap <a-k>     <Plug>(neocomplcache_snippets_expand)
"smap <a-k>     <Plug>(neocomplcache_snippets_expand)
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
"inoremap <expr><space>  pumvisible() ? neocomplcache#close_popup() . "\<SPACE>" : "\<SPACE>"

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><c-y>  neocomplcache#close_popup()
"inoremap <expr><c-e>  neocomplcache#cancel_popup()
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1
" Shell like behavior(not recommended).
"set completeopt+=longest
set completeopt-=preview
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1

" Enable omni completion.
"augroup OmnifuncGroup
"autocmd!
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
"autocmd FileType java :setlocal omnifunc=javacomplete#Complete
""autocmd FileType php :setlocal omnifunc=phpcomplete#Complete
"if has("autocmd") && exists("+omnifunc")
"autocmd Filetype *
"\ if &omnifunc == "" |
"\   :setlocal omnifunc=syntaxcomplete#Complete |
"\ endif
"endif
"augroup END

" Enable heavy omni completion.
"if !exists('g:neocomplcache_omni_patterns')
"let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
"let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

"if has('conceal')
"set conceallevel=2 concealcursor=i
"endif
" }}}


"{{{ plugin-autocomplpop
"Disable AutoComplPop.
let g:acp_enableAtStartup = 0

let g:AutoComplPop_MappingDriven = 0
let g:acp_ignorecaseOption = 1
let g:acp_completeOption = '.,w,b,k'

let g:AutoComplPop_Behavior = {
            \ 'c': [ {'command' : "\<C-x>\<C-o>",
            \ 'pattern' : ".",
            \ 'repeat' : 0}
            \ ]
            \}

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
"}}}

"{{{ plugin-Pydiction  python补全
"let g:pydiction_location = $VIMFILES."/ftplugin/complete-dict"
" }}}

" {{{ plugin - DoxygenToolkit.vim 自动生成各种注释
let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_blockHeader="----------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="ChenXiaohui,sdqxcxh@gmail.com"
let s:licenseTag = "Copyright(C)\<enter>"
let s:licenseTag = s:licenseTag . "For Free\<enter>"
let s:licenseTag = s:licenseTag . "All right reserved\<enter>"
let g:DoxygenToolkit_licenseTag = s:licenseTag
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1
nnoremap <leader>da :DoxAuthor<cr>
nnoremap <leader>dx :Dox<cr>
nnoremap <leader>dl :DoxLic<cr>
" }}}

"" {{{ plugin - mark.vim 给各种tags标记不同的颜色，便于观看调式的插件。
"" 这样，当我输入“,hl”时，就会把光标下的单词高亮，在此单词上按“,hh”会清除该单词的高亮。如果在高亮单词外输入“,hh”，会清除所有的高亮。
"" 你也可以使用virsual模式选中一段文本，然后按“,hl”，会高亮你所选中的文本；或者你可以用“,hr”来输入一个正则表达式，这会高亮所有符合这个正则表达式的文本。
"nmap <silent> <leader>m <plug>MarkSet
"vmap <silent> <leader>m <plug>MarkSet
"" 你可以在高亮文本上使用“,#”或“,*”来上下搜索高亮文本。在使用了“,#”或“,*”后，就可以直接输入“#”或“*”来继续查找该高亮文本，直到你又用“#”或“*”查找了其它文本。
"" <silent>* 当前MarkWord的下一个     <silent># 当前MarkWord的上一个
"" <silent>/ 所有MarkWords的下一个    <silent>? 所有MarkWords的上一个
""- default highlightings ------------------------------------------------------
""highlight def MarkWord1  ctermbg=Cyan     ctermfg=Black  guibg=#8CCBEA    guifg=Black
""highlight def MarkWord2  ctermbg=Green    ctermfg=Black  guibg=#A4E57E    guifg=Black
""highlight def MarkWord3  ctermbg=Yellow   ctermfg=Black  guibg=#FFDB72    guifg=Black
""highlight def MarkWord4  ctermbg=Red      ctermfg=Black  guibg=#FF7272    guifg=Black
""highlight def MarkWord5  ctermbg=Magenta  ctermfg=Black  guibg=#FFB3FF    guifg=Black
""highlight def MarkWord6  ctermbg=Blue     ctermfg=Black  guibg=#9999FF    guifg=Black
""}}}


" {{{ plugin - Calendar.vim 日历插件
"let g:calendar_diary="D:\Asins_data\vimwiki\diary"
let g:calendar_smnd = 1
let g:calendar_monday = 1                   " week start with monday.
let g:calendar_weeknm = 1                   " don't work with g:calendar_diary
let g:calendar_mark = 'left-fit'            " let plus(+) near the date, like +8.
"let g:calendar_mruler = '一月,二月,三月,四月,五月,六月,七月,八月,九月,十月,十一月,十二月'
"let g:calendar_wruler = '日 一 二 三 四 五 六'
"let g:calendar_navi_label = '上月,本月,下月'
" }}}


" {{{ plugin - Session.vim 会话记录
"自动载入会话
"let g:session_autoload = 1
"自动保存会话
"let g:session_autosave = 1
set shellquote=
set shellslash
set shellxquote=
set shellpipe=2>&1\|tee
set shellredir=>%s\ 2>&1
let g:session_autosave='no'
let g:session_autoload='no'
let g:session_directory=$HOME."/.vimtemp"
" }}}


" {{{ plugin - OpenUrl.vim 打开网址
"map <F8> :OpenUrl<CR>
" }}}


" {{{ plugin-Win平台下窗口全屏组件 gvimfullscreen.dll
" f11 全屏切换
" Shift + t 降低窗口透明度
" Shift + u 加大窗口透明度
" Shift + r 切换Vim是否总在最前面显示
"function! MaximizeWindow()
"silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
"endfunction
if has('gui_win32') && has('libcall')
    let g:MyVimLib = 'gvimfullscreen.dll'
    function! ToogleFullScreen()
        let g:IsFullScreen = libcallnr("gvimfullscreen.dll", 'ToggleFullScreen', 0)
        "let s:IsFullScreen = libcallnr("gvimfullscreen.dll", 'ToggleFullScreen', 27 + 29*256 + 30*256*256)
        "call libcall(g:MyVimLib, 'ToggleFullScreen', 27 + 29*256 + 30*256*256)
    endfunction

    "映射 <F11>切换全屏vim
    map  <F11> :call libcallnr("gvimfullscreen.dll", 'ToggleFullScreen', 0)<cr>
    nmap <c-f11> :vert sbn<CR>
    nmap <s-f11> :sbn<CR>

    let g:VimAlpha = 250
    function! SetAlpha(alpha)
        let g:VimAlpha = g:VimAlpha + a:alpha
        if g:VimAlpha < 180
            let g:VimAlpha = 180
        endif
        if g:VimAlpha > 255
            let g:VimAlpha = 255
        endif
        call libcall(g:MyVimLib, 'SetAlpha', g:VimAlpha)
    endfunction

    "增加Vim窗体的不透明度
    nmap <s-u> <esc>:call SetAlpha(10)<cr>
    "增加Vim窗体的透明度
    nmap <s-t> <esc>:call SetAlpha(-10)<cr>

    let g:VimTopMost = 0
    function! SwitchVimTopMostMode()
        if g:VimTopMost == 0
            let g:VimTopMost = 1
        else
            let g:VimTopMost = 0
        endif
        call libcall(g:MyVimLib, 'EnableTopMost', g:VimTopMost)
    endfunction
    "切换Vim是否在最前面显示
    nmap <s-e> <esc>:call SwitchVimTopMostMode()<cr>

    augroup TransGroup
        autocmd!
        autocmd GUIEnter * :call libcall(g:MyVimLib, 'SetAlpha', g:VimAlpha)
    augroup END
endif
" }}}


" {{{ plugin-Win窗口管理组件 winmanager及其附带的buf管理插件BufExplorer
"设置界面分割
"let g:winManagerWindowLayout = "BufExplorer"
"let g:winManagerWindowLayout = "NERDTree"
"设置winmanager的宽度，默认为25
"let g:winManagerWidth = 30
"定义打开关闭winmanager按键
"nnoremap <silent> <F8> :WMToggle<cr>
"默认打开winmanager
"let g:AutoOpenWinManager = 1
"minibufexpl 在上面显示打开的buffer的插件
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1
"let g:miniBufExplorerMoreThanOne=0
" }}}



" {{{ plugin-文件夹比较DirDiff 及原始比较diff
"String used for the English equivalent "Files "
let g:DirDiffTextFiles = "文件 "
"String used for the English equivalent " and "
let g:DirDiffTextAnd = " 和 "
"String used for the English equivalent " differ")
let g:DirDiffTextDiffer = " 不同"
"String used for the English equivalent "Only in ")
let g:DirDiffTextOnlyIn = "只在 "
"Only in separator
let g:DirDiffTextOnlyInCenter = " 存在："
"nnoremap <silent><f3>  ]c
"nnoremap <silent><s-f3>  [c
map <F9> :vert sbn<cr>:diffthis<cr><c-w>l:diffthis<cr>
" }}}


"" {{{ plugin-git插件 git.vim
"map <leader>gs :GitStatus<cr>
"map <leader>gc :GitCommit<cr>
"map <leader>ga :GitAdd<cr>
"map <leader>gp :GitPush<cr>
"map <leader>gl :GitPull<cr>
""}}}

"{{{
"nmap <leader>re :call PostReview()<cr>
"}}}


" {{{ plugin-buf管理插件 buf_it
"nnoremap <Leader>wq :w<CR><Esc>:call BufClose(0)<CR>
nnoremap <Leader>q  :call BufClose(0)<CR>
nnoremap <Leader>w  :w<CR>
nnoremap <Leader>x  :call BufClose(1)<CR>
"}}}


" {{{ plugin-yankring.vim 寄存器管理
nnoremap <leader>yr :YRShow<cr>
nnoremap <leader>yc :YRClear<CR>
nnoremap <leader>rg :reg<CR>
let g:yankring_history_dir = $HOME."/.vimtemp"
" }}}

" {{{ plugin-切换头文件和实现文件，插件A
nnoremap <leader>a :A<CR>
" }}}

" {{{ plugin-sketch画图模式

" }}}

"" {{{ plugin-快速符号定位插件 fuzzyfinder.vim
"function! GetAllCommands()
"redir => commands
"silent command
"redir END
"return map((split(commands, "\n")[3:]),
"\      '":" . matchstr(v:val, ''^....\zs\S*'')')
"endfunction

"" 自定义命令行
"let g:fuf_com_list=[':FufBuffer',':FufFile',':FufCoverageFile',':FufDir',
"\':FufMruFile',':FufMruCmd',':FufBookmarkFile',
"\':FufBookmarkDir',':FufTag',':FufBufferTag',
"\':FufTaggedFile',':FufJumpList',':FufChangeList',
"\':FufQuickfix',':FufLine',':FufHelp',
"\":FufFile \<C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]\<CR>",
"\":FufDir \<C-r>=expand('%:p:~')[:-1-len(expand('%:p:~:t'))]\<CR>",
"\]
"nnoremap <silent> <Leader>g :call fuf#givencmd#launch('', 0, '选择命令>', GetAllCommands())<CR>
"nnoremap <silent> <Leader>v :call fuf#givencmd#launch('', 0, '选择命令>', g:fuf_com_list)<CR>
"map <silent><leader>t :FufTag<cr>
"map <silent><leader>f :FufFile<cr>
"" }}}


" {{{ plugin-快速文件定位插件 CtrlP.vim
let g:ctrlp_map = '<leader>f'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_height = 15
let g:ctrlp_mruf_max = 500
let g:ctrlp_root_markers = ['cscope.out']
let g:ctrlp_open_multiple_files = 'v'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.(git|hg|svn)',
            \ 'file': '.*\.(exe|so|dll|svn|o).*',
            \ }
"let g:ctrlp_use_caching = 0
"let g:ctrlp_custom_ignore = '.DS_Store|\.git|\.svn|\.svn-base'
"if g:system=='win'
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
"let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows
"else
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.svn,*.git,*.o   " MacOSX/Linux
""let g:ctrlp_user_command = "find %s -type f ! -path '*/.svn/*' -a ! -path '*/.git/*'"
"let g:ctrlp_user_command = 'find %s -type f'
"endif

nnoremap <silent><leader>t :CtrlPTag<cr>
nnoremap <silent><leader>b :CtrlPBuffer<cr>
nnoremap <silent><leader>bt :CtrlPBufTag<cr>
nnoremap <silent><leader>c :CtrlPCurFile<cr>
" }}}

" {{{ plugin-快速函数定位插件 CtrlPFunk.vim
let g:ctrlp_extensions = ['funky']
nnoremap <Leader>h :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
vnoremap <Leader>h :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
" }}}

"{{{ plugin-locate files
nnoremap <leader>l :call LocateFile(input("Locate File: "))<cr>
nnoremap <leader>L :call LocateFile(expand("<cfile>"))<cr>
function! LocateFile(token_name)
    let sub_tokens = split(a:token_name, ' ')
    if len(sub_tokens) >= 2
        silent! execute "!locate -i -r ".sub_tokens[0].".*".sub_tokens[1]." >/tmp/files.tmp"
        silent! execute "!locate -i -r ".sub_tokens[1].".*".sub_tokens[0]." >>/tmp/files.tmp"
    elseif len(sub_tokens) == 1
        silent! execute "!locate -i -r ".sub_tokens[0]." >/tmp/files.tmp"
    endif
    e /tmp/files.tmp
endf
"}}}


"""{{{ plugin-surround.vim 包围
"visual  模式下
"s 输入包围
"S 输入包围并且添加新行
"""}}}


"""{{{ plugin-quickfix编码
function! QfMakeConv()
    let qflist = getqflist()
    for i in qflist
        let i.text = iconv(i.text, "cp936", "utf-8")
    endfor
    call setqflist(qflist)
endfunction

if g:system=='win'
    aug QuickFixGroup
        au!
        au QuickfixCmdPost make :call QfMakeConv()
    aug END
endif

aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        copen 10
        let g:qfix_win = bufnr("$")
    endif
endfunction
nnoremap <leader>n :QFix<CR>
map <F4>  :cn<cr>
map <s-F4> :cp<cr>
"""}}}

"""{{{ plugin-字符统计
function! CalCharCount()
    exe '%s/\S/&/gn'
endfunction
"映射命令模式下调用字符统计
nmap <leader>cn :call CalCharCount()<cr>
"""}}}

"""{{{ plugin-保存备份文件
function! SaveBackup ()
    let b:backup_count = exists('b:backup_count') ? b:backup_count+1 : 1
    if 0 == writefile(getline(1,'$'), bufname('%') . '_' . b:backup_count)
        echo "Save backup successfully."
    endif
endfunction
nmap <silent>  <C-S-B>  :call SaveBackup()<CR>
"}}}


"""{{{  plugin-格式化代码
" 删除所有行未尾空格
nnoremap <C-f12> :%s/[ \t\r]\+$//g<cr>''
"显示空格
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
augroup ExtraWhitespaceGroup
    autocmd!
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
augroup END
"格式化
noremap <f12> gg=G''
"对齐等号
nmap <silent>  <S-f12>  :call AlignAssignments()<CR>
function! AlignAssignments ()
    "Patterns needed to locate assignment operators...
    let ASSIGN_OP   = '[-+*/%|&]\?=\@<!=[=~]\@!'
    let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)'

    "Locate block of code to be considered (same indentation, no blanks)
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif

    "Find the column at which the operators should be aligned...
    let max_align_col = 0
    let max_op_width  = 0
    for linetext in getline(firstline, lastline)
        "Does this line have an assignment in it?
        let left_width = match(linetext, '\s*' . ASSIGN_OP)

        "If so, track the maximal assignment column and operator width...
        if left_width >= 0
            let max_align_col = max([max_align_col, left_width])

            let op_width      = strlen(matchstr(linetext, ASSIGN_OP))
            let max_op_width  = max([max_op_width, op_width+1])
        endif
    endfor

    "Code needed to reformat lines so as to align operators...
    let FORMATTER = '\=printf("%-*s%*s", max_align_col, submatch(1),
                \                                    max_op_width,  submatch(2))'

    " Reformat lines with operators aligned in the appropriate column...
    for linenum in range(firstline, lastline)
        let oldline = getline(linenum)
        let newline = substitute(oldline, ASSIGN_LINE, FORMATTER, "")
        call setline(linenum, newline)
    endfor
endfunction
"}}}

" {{{ plugin - authorinfo.vim 更新作者信息
let g:vimrc_author='ChenXiaohui'
let g:vimrc_email='sdqxcxh@gmail.com'
let g:vimrc_homepage='http://www.cxh.me'
nmap <leader>za :AuthorInfoDetectAli<cr>
nmap <leader>zm :AuthorInfoDetect<cr>
" }}}

" {{{ plugin - jsbeautify.vim 优化js代码，并不是简单的缩进，而是整个优化
augroup JSBeauty
    autocmd!
    autocmd BufEnter *.js :exec "nmap <silent><buffer> <f12> :call g:Jsbeautify()<cr>''"
augroup end
" }}}


"{{{ plugin -  txtBrowser
let tlist_txt_settings = 'txt;c:content;f:figures;t:tables'
au BufRead,BufNewFile *.txt setlocal ft=txt
"}}}


"{{{ plugin-无条件创建不存在的目录
augroup AutoMkdir
    autocmd!
    autocmd  BufNewFile  *  :call EnsureDirExists()
augroup END

function! EnsureDirExists ()
    let required_dir = expand("%:h")
    if !isdirectory(required_dir)
        call AskQuit("Directory '" . required_dir . "' doesn't exist.", "&Create it?")

        try
            call mkdir( required_dir, 'p' )
        catch
            call AskQuit("Can't create '" . required_dir . "'", "&Continue anyway?")
        endtry
    endif
endfunction

function! AskQuit (msg, proposed_action)
    if confirm(a:msg, "&Quit?\n" . a:proposed_action) == 1
        exit
    endif
endfunction
"}}}

"{{{ plugin-voom.vim
"map <silent><leader>vo :Voom<cr>
"}}}

"{{{ plugin-进入shell
nnoremap <silent><leader>sh :shell<cr>
"}}}

"{{{ plugin-项目管理
map <silent><C-F8> <Plug>ToggleProject
"}}}

"{{{ plugin-写一个线程的log到单独文件
function! ThreadLog()
    let file = readfile(expand("%:p"))
    let pattern = expand('<cword>')
    let matches = []
    for line in file
        let match = matchstr(line, pattern)
        if(!empty(match))
           call add(matches, line)
        endif
    endfor
    let s:filename= pattern . '.log'
    call writefile(matches, s:filename )
endf

function! ThreadExceptLog()
    let file = readfile(expand("%:p"))
    let pattern = expand('<cword>')
    let matches = []
    for line in file
        let match = matchstr(line, pattern)
        if(empty(match))
           call add(matches, line)
        endif
    endfor
    let s:filename= 'no-'.pattern . '.log'
    call writefile(matches, s:filename )
endf
nmap <leader>th :call ThreadLog()<cr>
nmap <leader>tn :call ThreadExceptLog()<cr>
"}}}

"{{{
"let g:clang_complete_copen=0
"let g:clang_periodic_quickfix=1
"let g:clang_snippets=1
"let g:clang_close_preview=1
"let g:clang_use_library=1
"let g:clang_user_options='-stdlib=libc++ -std=c++11 -IIncludePath'
"let g:clang_user_options="-I. -I/home/yongle.xh/deps/tb-common-utils/tbnet/src/ -I/home/yongle.xh/deps/tb-common-utils/tbsys/src -I/home/yongle.xh/ob_install_dir/include/easy/ -I/usr/lib    /gcc/x86_64-redhat-linux/4.4.6/include -I/usr/include/c++/4.4.6/ -I/usr/include/c++/4.4.6/x86_64-redhat-linux -Wno-deprecated"
"}}

"{{{ plugin- deal with filelist
noremap <leader>co :call OpenFileWithDefApp()<cr>
noremap <leader>rm :call DelFile()<cr>
noremap <leader>cd :call ChDir()<cr>
noremap <leader>to :call CopyFile()<cr>
let g:applist={
            \'pdf':'evince',
            \'png,gif,jpg':'eog',
            \'rmvb,mkv,flv,avi,mp4,m4v':'mplayer',
            \'mp3,wma,fla':'!mocp -a %',
            \'rar':'!unrar l %',
            \'epub':'!calibre %',
            \'zip':'!unzip -O CP936 -l %',
            \'pwd':'nautilus',
            \'docx,xlsx,pptx,ppt':'libreoffice',
            \'default':':e %'
            \}
"}}}


"{{{ plugin- compiler.vim 编译选项配置
"==========================================================================
"option     default     suboption           meaning
"           value
"==========================================================================
"compile    'make'      win,unix..          the default compile command
"ucompile   'make'      win,unix..          compile command when file encoding is utf8
"clean      'make'      win,unix..          the clean command
"out        ''          win,unix..          the output file type eg:png,pdf,this is
"                                               needed if symbol %> is used
"efm        ''          win,unix..          errorformat string
"inshell    0           win,unix..          whether the command is run in shell or via makeprg
"before     ''          win,unix..          command before compile
"run        ''          win,unix..          command run after compile
"arg        ''          compile,run,debug   the parameters for run or compile
"==========================================================================
map <F5> :call Do_OneFileMake()<CR>
map <c-f5> :call Do_Execute()<CR>
map <F6> :call Do_Make()<CR>
map <c-F6> :call Do_Clean()<CR>
map <silent> <S-F6> :call Do_Debug()<cr>
map<S-f5> :call writefile([],$HOME.'/.his')<cr>:run macros/gdb_mappings.vim<CR>
"map<S-f6> :bel 30vsplit gdb-variables<CR>
nnoremap <leader>db :call GenerateGdb()<CR>:e ~/.gdbinit<CR>
nnoremap <leader>bk :call AddBreak()<CR>
noremap <leader>sp :call StripSVN()<CR>
noremap <leader>sf :call SVNCommand("diff", 0 ,1)<cr>
noremap <leader>sr :call SVNCommand("revert", 1 ,0)<cr>
noremap <leader>sl :call SVNCommand("log", 0 ,0)<cr>
noremap <leader>sb :call SVNCommand("blame", 0 ,0)<cr>
noremap <leader>sa :call SVNCommand("add", 0 ,1)<cr>
noremap <leader>sd :call SVNCommand("delete", 1 ,0)<cr>
map <leader>ss :call LogSession()<cr>
map <leader>st :call LogTrace()<cr>
map <leader>rf :call OpenDifferentRepoFile()<cr>
map :lg :%s/\(^\[.\{-}\]\)\\|\(\[\d\+\]\)\\|\(0x\w\+\)\\|\(tid=\d\+\)\\|\(version=\d\+\)//g<cr>
map :du :g/^\(.*\)$\n\1$/d<cr>
nnoremap <leader>dg :e ~/.his<cr>
nnoremap <leader>ip :call GetImportFile()<cr>
let g:types={
            \'c':{'compile':'gcc -w  -o %<%> %','arg':{'compile':'-g'},'out':{'win':'.exe','unix':''},
                \'run':{'win':'%<','unix':'./%<%>'},'clean':'rm %<%>'},
            \'cpp':{'compile':'g++ -w -o %<%> %','arg':{'compile':'-g'},'out':{'win':'.exe','unix':''},
                \'run':{'win':'%<','unix':'./%<%>'},'clean':'rm %<%>'},
            \'tex':{'compile':'xelatex %','inshell':1, 'clean':'rm *.aux *.log *.out *.snm','out':'.pdf','run':{'win':'%<%>'}},
            \'cs':{'compile':'csc /nologo /out:%<%> %','efm':'%A%f(%l\\,%c):%m','out':'.exe'},
            \'python':{'compile':'python %','inshell':1,'debug':'python -m pdb %','arg':''},
            \'lua':{'compile':'lua %','inshell':1,'arg':''},
            \'dot':{'compile':{'win':'dotit.bat %< %>','unix':'dot -T%> % -o %<.%>'},'out':'png',
                \'run':{'unix':'nohup eog %<.%> >/dev/null 2>&1 &'},'inshell':1},
            \'php':{'compile':'php %','inshell':1},
            \'java':{'compile':{'win':'javait.bat %<'},'inshell':1},
            \'dosbatch':{'compile':'%','inshell':1},
            \'vb':{'compile':'%','inshell':1},
            \'ruby':{'compile':'ruby %','inshell':1},
            \'perl':{'compile':'perl %','inshell':1},
            \'sh':{'compile':'./%','inshell':1},
            \'xhtml':{'compile':{'win':'%','unix':"google-chrome %"},'inshell':1},
            \'html':{'compile':{'win':'%','unix':"google-chrome %"},'inshell':1},
            \'make':{'compile':'make','inshell':1},
            \'apache':{'compile':'apache.bat','inshell':1},
            \'go':{'compile':'go run %','inshell':1},
            \'txt':{'compile':'pandoc -N  --toc --variable version=1.3 --template=default.latex --latex-engine=xelatex % -o %<%>','out':'.pdf','run':{'unix':'evince %<%>','win':'%<%>'},'inshell':1},
            \'mkd':{'compile':"pandoc % -o %<%>", "out":".html", "run":"vi %<%>", "inshell":1}
            \}
"}}}
            "\'txt':{'compile':'pandoc -N -t beamer --toc --variable version=1.3 --template=default.beamer --latex-engine=xelatex % -o %<%>','out':'.pdf','run':{'unix':'evince %<%>','win':'%<%>'},'inshell':1},
