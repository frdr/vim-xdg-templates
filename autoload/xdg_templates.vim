" Use XDG templates for new files in Vim
" Last Change:	2024-01-24
" Maintainer:	Friedrich Kischkel <friedrich.kischkel@gmail.com>

function xdg_templates#ext_alias_default() abort
    return [
        \ ['cpp', 'cxx', 'C', 'cc'],
        \ ['hpp', 'hxx', 'hh', 'h'],
        \ ['md', 'markdown'],
        \ ['htm', 'html'],
    \ ]
endfunction

function xdg_templates#get_templates_dir() abort
    " Let user override the dir we search templates in.
    " Useful for non-XDG operating systems.
    if exists('g:xdg_templates_lookup_dir') && ! empty(g:xdg_templates_lookup_dir)
        return g:xdg_templates_lookup_dir
    endif

    " Only call xdg-user-dir once, shouldn't be so volatile
    if ! exists('s:xdg_user_dir_cached')
        " Use whatever XDG uses
        if executable('xdg-user-dir')
            let s:xdg_user_dir_cached=trim(system('xdg-user-dir TEMPLATES'))
        endif

        " Just take what's the default
        let s:xdg_user_dir_cached=expand('~/Templates')
    endif
    return s:xdg_user_dir_cached
endfunction

function s:find_alias(extension) abort
    silent let l:result = [ a:extension ]
    silent let l:ext_alias = exists('g:xdg_templates_ext_alias')
                \ ? g:xdg_templates_ext_alias
                \ : g:xdg_templates#ext_alias_default()
    for l:peers in l:ext_alias
        if index(l:peers, a:extension) >= 0
            silent let l:result += l:peers
            " Yeah, I know now a:extension is in l:result *twice*!
            " File a bug if this bogs your Vim down.
            " I still want the original extension be in the first place.
        endif
    endfor
    return l:result
endfunction

function s:best_match(haystack, needle) abort
    if ! empty(a:haystack)
        silent let l:matches = matchfuzzy(
                    \ a:haystack,
                    \ a:needle,
                    \ {'matchseq': 1, 'limit': 1})
        if ! empty(l:matches)
            return l:matches[0]
        endif
        return a:haystack[0]
    endif
    return ''
endfunction

function s:find_template(filename) abort
    silent let l:template_dir = g:xdg_templates#get_templates_dir()
    silent let l:to_glob = <SID>find_alias(fnamemodify(a:filename, ':e'))
    silent let l:matches = []
    for l:ext in l:to_glob
        silent let l:matches += glob(l:template_dir .. '/*.' .. l:ext, 0, 1, 1)
    endfor
    if ! empty(l:matches)
        return <SID>best_match(l:matches, a:filename)
    endif
    return ''
endfunction

function s:apply_execute_hook(template) abort
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

function xdg_templates#prefix_template(filename) abort
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
