" Use XDG templates for new files in Vim
" Last Change:	2024-01-04
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

if ! (exists('g:xdg_templates_no_autocmd') && g:xdg_templates_no_autocmd)
    augroup xdg_templates
        autocmd!
        autocmd BufNewFile * eval g:xdg_templates#prefix_template(expand('<afile>'))
    augroup END
endif

if ! (exists('g:xdg_templates_no_command') && g:xdg_templates_no_command)
    command PrefixXdgTemplate eval g:xdg_templates#prefix_template(expand('%'))
endif
