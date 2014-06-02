if exists("g:loaded_jake_autoload")
  finish
endif
let g:loaded_jake_autoload = 1

function! jake#get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, '')
endfunction

function! jake#connect()
  let s:sock = vimproc#socket_open('localhost', 5000)
endfunction

function! jake#disconnect()
  call s:sock.close()
endfunction

function! jake#eval(cmd)
  call s:sock.write(a:cmd . "\n")
  sleep 5m
  let res = s:sock.read_lines()
  return join(res, '\n')
endfunction

function! jake#eval_line()
  return jake#eval(getline("."))
endfunction

function! jake#eval_range()
  return jake#eval(jake#get_visual_selection())
endfunction

function! s:setup()
  command! -buffer JakeConnect call jake#connect()
  command! -buffer JakeDisconnect call jake#disconnect()
  command! -buffer JakeEvalLine echo jake#eval_line()
  command! -buffer -range JakeEvalRange echo jake#eval_range()

  nmap <buffer> cpp :JakeEvalLine<CR>
  vmap <buffer> cpp :JakeEvalRange<CR>
endfunction

augroup jake_start
  autocmd!
  autocmd FileType javascript call s:setup()
augroup END
