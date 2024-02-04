# vim-xdg-templates

**Use files from XDG TEMPLATES for new buffers in Vim**

Before we start: this plugin works for any OS but the intro below assumes a Linux box.

Ever noticed how all files in your `~/Templates` directory get offered as skeletons in your graphical file manager? Probably not, but they are.

A little known (and AFAIK undocumented) feature of [freedesktop.org's user-dirs][userdirs] is that you can quickly access template files. 

This plugin creates *synergy* between XDG and Vim. Whenever a new file is created, a matching template is looked up.
You can put repetitive stuff like shebang, your name and e-mail address, copyright notice, license etc. in the template and use it over and over again.
Great if the company you work for wants you to put lots of legalese in a file's header.

This works first and foremost by the file's extension. Secondly, a fuzzy match between file name and template name is performed.

This plugin offers some configuration options but the design goal is that it works with *zero configuration* on an XDG system and *one line of configuration* everywhere else (that's you, Windows user).

If you're looking for the exhaustive solution for file templates with a lot of features, a lot of power and a lot of complexity: this plugin is not it.
This is intended to be a simple plugin that does *one* job.

If this plugin is boring you, you may be interested in the [UltiSnips plugin][ultisnips]. Just move on, I'll be okay ... one day.

## Installation

The recommended way to install is through [vim-plug][vim-plug]. Put the following lines in your `vimrc`:

    call plug#begin()
    Plug 'frdr/vim-xdg-templates'
    call plug#end()

For manual installation, you can just copy the three files into your respective `~/.vim/{autoload,doc,plugin}` directories.

## Usage

Just fire up Vim and go - it should just work.

If you already have templates in your `~/Templates` directory, they will be used once you start editing a new file with the same extension.

To prefix an existing file with the template, you can use the `:XdgTemplatePrefix` command.

## Compatibility

This assumes at least Vim 9.x.  
It might even work with NeoVim.

To see if your system supports the templates directory, run the following command in your shell:

    xdg-user-dir TEMPLATES

The output you get is the directory that will be used. If there's no such command on your machine or it fails, the fallback of `~/Templates` will be used. You can configure to use another directory as explained below.

## Configuration

The lookup directory can be overridden by setting
`g:xdg_templates_lookup_dir`:

    let g:xdg_templates_lookup_dir = expand('~/.vim/templates')

You would need to expand any special characters yourself as in the example above. In the example, you would keep your templates in your user's `.vim` directory itself.

Commands to execute for all templates or individual files can be defined, e.g. to have offsets: 

    let g:xdg_templates_all_execute = '$-2'
    let g:xdg_templates_file_execute = {'myheader.h': '$-2'}

This will use Vim's `:execute` so any Ex command can be given.
You could do a lot of nifty stuff like replacing placeholders but then that's not the primary concern of this plugin.

## Missing and misunderstood features (known bugs):

* Python files are shown as modified because of `fileencoding=utf-8` in modeline.
* Fuzzy match for templates leaves room for improvement. Much room.
* Maybe also consider filetype, not just extensions.
* Files without extensions are not handled at all.

## License

Licensed under the same terms as Vim itself.


  [userdirs]: https://www.freedesktop.org/wiki/Software/xdg-user-dirs/
  [vim-plug]: https://github.com/junegunn/vim-plug
  [ultisnips]: https://github.com/SirVer/ultisnips
