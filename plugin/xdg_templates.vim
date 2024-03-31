" Use XDG templates for new files in Vim
" Last Change:  2024-03-31
" Maintainer:	Friedrich Kischkel <friedrich.kischkel@gmail.com>
"
" Any file within the XDG TEMPLATES directory is offered for quick file
" creation in graphical file managers. This plugin makes Vim use the same
" files whenever a new file with the respective extension is created.

if exists('g:loaded_xdg_templates')
    finish
endif
let g:loaded_xdg_templates=1

if get(g:, 'xdg_templates_do_autocmd', 1)
    augroup xdg_templates
        autocmd!
        autocmd BufNewFile * eval g:xdg_templates#prefix_template(expand('<afile>'))
    augroup END
endif

if get(g:, 'xdg_templates_do_command', 1)
    command XdgTemplatePrefix eval g:xdg_templates#prefix_template(expand('%'))
endif
