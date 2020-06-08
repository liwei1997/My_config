"autocmd Filetype markdown map <leader>w yiWi[<esc>Ea](<esc>pa)
"查找下一个占位符
autocmd Filetype markdown inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
"查找上一个占位符
autocmd Filetype markdown inoremap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
autocmd Filetype markdown inoremap <buffer> ,n ---<Enter><Enter>
"Strikethrough text
autocmd Filetype markdown inoremap <buffer> ,s ~~~~ <++><Esc>F~hi
"Emphasized text
autocmd Filetype markdown inoremap <buffer> ,i ** <++><Esc>F*i
"Strong text
autocmd Filetype markdown inoremap <buffer> ,b **** <++><Esc>F*hi
"code
autocmd Filetype markdown inoremap <buffer> ,d `` <++><Esc>F`i
"code block
autocmd Filetype markdown inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
"A completed task
autocmd Filetype markdown inoremap <buffer> ,m - [x] <Enter><++><ESC>kA
"添加图片
autocmd Filetype markdown inoremap <buffer> ,p ![](<++>) <++><Esc>F[a
"添加网站
autocmd Filetype markdown inoremap <buffer> ,a [](<++>) <++><Esc>F[a
"Heading 1
autocmd Filetype markdown inoremap <buffer> ,1 #<Space><Enter><++><Esc>kA
"Heading 2
autocmd Filetype markdown inoremap <buffer> ,2 ##<Space><Enter><++><Esc>kA
"Heading 3
autocmd Filetype markdown inoremap <buffer> ,3 ###<Space><Enter><++><Esc>kA
"Heading 4
autocmd Filetype markdown inoremap <buffer> ,4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,l --------<Enter>
"key
autocmd Filetype markdown inoremap <buffer> ,k <kbd></kbd> <++><Esc>F/hi
