"markdown image paste settings
"====================================
autocmd FileType markdown nmap <buffer><silent> <leader>ip :call mdip#MarkdownClipboardImage()<CR><esc>f)i<Space>=500x<Esc>F5

let cwd = $PWD . '/img'
let g:mdip_imgdir_absolute = cwd
let g:mdip_imgdir_intext = cwd

"default intext name and directory where images are saved
let g:mdip_imgdir_absolute = 'img'
let g:mdip_imgdir_intext = 'img'
let g:mdip_imgname = 'image'


