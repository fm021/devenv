function! s:PhpStylist()
    execute "w"
    normal ggdG
    execute "0r!~/bin/phpStylist %"
    normal Gdd
endfunction
command! Cf call <SID>PhpStylist()
