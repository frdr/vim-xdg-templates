" Use XDG templates for new files in Vim
" Last Change:	2024-01-04
" Maintainer:	Friedrich Kischkel <friedrich.kischkel@gmail.com>


function xdg_templates#find_template(filename)
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

    for s:template in glob(g:xdg_templates_lookup_dir .. '/*.*', 0, 1)
        if fnamemodify(s:template, ':e') == fnamemodify(a:filename, ':e')
            return s:template
        endif
    endfor 
    return ''
endfunction

function xdg_templates#prefix_template(filename)
    let s:template = g:xdg_templates#find_template(a:filename)
    if ! empty(s:template)
        execute '0read' s:template
        $
        setlocal nomodified
    endif
endfunction
