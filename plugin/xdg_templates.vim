" Use XDG templates for new files in Vim
" Last Change:	2023-11-13
" Maintainer:	Friedrich Kischkel <friedrich.kischkel@gmail.com>
"
" Any file within the ~/Templates directory is offered for quick file
" creation in graphical file managers. This plugin makes Vim use the same
" files whenever a new file with the respective extension is created.
"
" Note that this works purely on extension, not filetype. Consider
" creating synonymous files through symlinks:
"
"     ln -s header_file.h header_file.hpp
"
" The lookup directory can be overridden by setting
" `g:xdg_templates_lookup_dir`:
"
"     let g:xdg_templates_lookup_dir = expand('~/.vim/templates')
"
" Missing features:
"
" * Add a function that allows to add templates to existing files.
" * Consider filetypes, not just extensions.
" * Don't always jump to the bottom of the template, to allow e.g. for
"   modelines at the bottom of the templates.
"
" Known bugs:
"
" * Python files are shown as modified
"
" Licensed under the same terms as Vim.

if exists('g:loaded_xdg_templates')
    finish
endif
let g:loaded_xdg_templates=1

" Let user override the dir we search templates in
" Useful for non-XDG operating systems
if ! exists('g:xdg_templates_lookup_dir')
    if executable('xdg-user-dir')
        " Use whatever XDG uses
        silent let g:xdg_templates_lookup_dir = trim(system('xdg-user-dir TEMPLATES'))
    else
        " Just take what's the default
        silent let g:xdg_templates_lookup_dir = expand('~/Templates')
    endif
endif

augroup xdg_templates
    autocmd!
    for s:template in glob(g:xdg_templates_lookup_dir .. '/*.*', 0, 1)
        execute 'autocmd BufNewFile *.' .. fnamemodify(s:template, ':e') .. ' 0read ' .. s:template.' | $ | setlocal nomodified'
    endfor 
augroup END
