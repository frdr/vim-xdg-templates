# vim-xdg-templates
Use XDG templates for new files in Vim

Any file within the `~/Templates` directory is offered for quick file
creation in graphical file managers. This plugin makes Vim use the same
files whenever a new file with the respective extension is created.

Note that this works purely on extension, not filetype. Consider
creating synonymous files through symlinks:

    ln -s header_file.h header_file.hpp

The lookup directory can be overridden by setting
`g:xdg_templates_lookup_dir`:

    let g:xdg_templates_lookup_dir = expand('~/.vim/templates')

## Missing features:

* Add a function that allows to add templates to existing files.
* Consider filetypes, not just extensions.
* Don't always jump to the bottom of the template, to allow e.g. for
  modelines at the bottom of the templates.

## Known bugs:

* Python files are shown as modified

## License

Licensed under the same terms as Vim itself.
