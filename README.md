# vim-xdg-templates

**Use files from XDG TEMPLATES for new buffers in Vim**

Any file within the `~/Templates` directory is offered for quick file
creation in graphical file managers. This plugin makes Vim use the same
files whenever a new file with the respective extension is created.

Note that this works purely on extensions, not filetype.

The lookup directory can be overridden by setting
`g:xdg_templates_lookup_dir`:

    let g:xdg_templates_lookup_dir = expand('~/.vim/templates')

Commands to execute for all templates or individual files can be defined, e.g. to have offsets: 

    let g:xdg_templates_all_execute = '$-2'
    let g:xdg_templates_file_execute = {'myheader.h': '$-2'}

## Missing features

* Consider filetypes, not just extensions.
* Best-match algorithm to have templates for e.g. letter.tex and paper.tex

## Known bugs

* Python files are shown as modified because of `fileencoding=utf-8` in modeline.

## License

Licensed under the same terms as Vim itself.
