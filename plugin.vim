function! g:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  "let lines[-1] = lines[-1][: col2 - 1]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, '')
endfunction

function! g:connect_js()
  let g:sock = vimproc#socket_open('localhost', 5000)
endfunction

function! g:disconnect_js()
  call g:sock.close()
endfunction

function! g:opsock(cmd)
    call g:sock.write(a:cmd . "\n")
    sleep 5m
    let res = g:sock.read_lines()
    return join(res, '\n')
endfunction

vmap <silent> <Leader>o <esc>:echo g:opsock(g:get_visual_selection())<CR>
