# vim-xdg-templates

**Use files from XDG TEMPLATES for new buffers in Vim**

Any file within the `~/Templates` directory is offered for quick file
creation in graphical file managers. This plugin makes Vim use the same
files whenever a new file with the respective extension is created.

Note that this works purely on extension, not filetype. Consider
creating synonymous files through symlinks:

    ln -s header_file.h header_file.hpp

The lookup directory can be overridden by setting
`g:xdg_templates_lookup_dir`:

    let g:xdg_templates_lookup_dir = expand('~/.vim/templates')

Offsets for can be defined per template to allow e.g. for modelines:

    let g:xdg_templates_file_offset['myheader.h'] = '$-2'

## Missing features

* Consider filetypes, not just extensions.
* Allow for extension aliases (e.g. C++ has cpp, C, cc, cxx, etc.)

## Known bugs

* Python files are shown as modified because of `fileencoding=utf-8` in modeline.

## License

Licensed under the same terms as Vim itself.
