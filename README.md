ifdef_generator
===============

generate if_def automatically

### ifdef.vim

auto generate if def macro using file name (or path maybe)

#### Install:

copy to plugin directory, and add below to your vimrc.

    "{{{ plugin-snipMate.vim 提供snippets补全
        let g:ifndef_prefix="OCEANBASE_"
        "let g:ifndef_strip="OB_"
        let g:ifndef_namespace_outer="oceanbase"
        let g:ifndef_namespace_inner="updateserver"
        nmap <leader>df :call InsertHeadDefN()<cr>
        let g:base_dir = ['src', 'tests', 'unittest','tools']
    "}}}

#### Effect:

before:

    class Base
    {
      public:
        Base (){}
        virtual ~Base (){}

      private:
        /* data */
    };

after:

    #ifndef OCEANBASE_MOCK_UPS_CPP_
    #define OCEANBASE_MOCK_UPS_CPP_
        namespace oceanbase
        {
          namespace common
          {
            class Base
            {
              public:
                Base (){}
                virtual ~Base (){}

              private:
                /* data */
            };
          }
        }
    #endif //OCEANBASE_MOCK_UPS_CPP_


###author_info.vim

plugin to generate author info

####Install:

copy to plugin directory, and add below to your vimrc.

    " {{{ plugin - authorinfo.vim 更新作者信息
    let g:vimrc_author='ChenXiaohui'
    let g:vimrc_email='sdqxcxh@gmail.com'
    let g:vimrc_homepage='http://www.cxh.me'
    nmap <leader>za :AuthorInfoDetectAli<cr>
    nmap <leader>zm :AuthorInfoDetect<cr>
    " }}}

#### Effect:

    /**
    * (C) 2010-2012 Alibaba Group Holding Limited.
    *
    * This program is free software; you can redistribute it and/or
    * modify it under the terms of the GNU General Public License
    * version 2 as published by the Free Software Foundation.
    *
    * ob_mock_ups.cpp is for
    *   
    * Authors:
    *   yuzhang <xiaohui.cpc@alibaba-inc.com>
    */

