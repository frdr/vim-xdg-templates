" Use XDG templates for new files in Vim
" Last Change:	2024-01-23
" Maintainer:	Friedrich Kischkel <friedrich.kischkel@gmail.com>
"
" Any file within the XDG TEMPLATES directory is offered for quick file
" creation in graphical file managers. This plugin makes Vim use the same
" files whenever a new file with the respective extension is created.

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
