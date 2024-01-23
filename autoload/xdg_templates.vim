" Use XDG templates for new files in Vim
" Last Change:	2024-01-23
" Maintainer:	Friedrich Kischkel <friedrich.kischkel@gmail.com>

function xdg_templates#get_templates_dir()
    " Let user override the dir we search templates in.
    " Useful for non-XDG operating systems.
    if exists('g:xdg_templates_lookup_dir') && ! empty('g:xdg_templates_lookup_dir')
        return g:xdg_templates_lookup_dir
    endif

    " Use whatever XDG uses
    if executable('xdg-user-dir')
        return trim(system('xdg-user-dir TEMPLATES'))
    endif

    " Just take what's the default
    return expand('~/Templates')
endfunction

function s:find_template(filename)
    silent let l:template_dir = g:xdg_templates#get_templates_dir()
    for l:template in glob(l:template_dir .. '/*.*', 0, 1)
        if fnamemodify(l:template, ':e') == fnamemodify(a:filename, ':e')
            return l:template
        endif
    endfor
    return ''
endfunction

function s:apply_execute_hook(template)
    silent let l:file = fnamemodify(a:template, ':t')
    if exists('g:xdg_templates_file_execute')
                \&& has_key(g:xdg_templates_file_execute, l:file)
        execute g:xdg_templates_file_execute[l:file]
    elseif exists('g:xdg_templates_all_execute')
        execute g:xdg_templates_all_execute
    else
        $
    endif
endfunction

function xdg_templates#prefix_template(filename)
    silent let l:template = <SID>find_template(a:filename)
    if ! empty(l:template)
        silent let l:was_empty = line('$') == 1
        silent execute '0read' l:template
        if l:was_empty
            call <SID>apply_execute_hook(l:template)
            setlocal nomodified
        endif
    endif
endfunction
