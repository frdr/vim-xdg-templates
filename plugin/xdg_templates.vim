" Use XDG templates for new files in Vim
" Last Change:	2024-01-11
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
" Offsets for can be defined per template to allow e.g. for modelines:
"
"     let g:xdg_templates_file_offset['myheader.h'] = '$-2'

if exists('g:loaded_xdg_templates')
    finish
endif
let g:loaded_xdg_templates=1

if ! exists('g:xdg_templates_file_offset')
    let g:xdg_templates_file_offset = {}
endif

if ! (exists('g:xdg_templates_no_autocmd') && g:xdg_templates_no_autocmd)
    augroup xdg_templates
        autocmd!
        autocmd BufNewFile * eval g:xdg_templates#prefix_template(expand('<afile>'))
    augroup END
endif

if ! (exists('g:xdg_templates_no_command') && g:xdg_templates_no_command)
    command PrefixXdgTemplate eval g:xdg_templates#prefix_template(expand('%'))
endif
