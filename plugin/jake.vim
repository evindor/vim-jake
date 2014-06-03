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
  " Get user input
  " http://vim.wikia.com/wiki/User_input_from_a_script
  let curline = getline('.')
  call inputsave()
  let port = input('Port: ', '5000')
  call inputrestore()
  call setline('.', curline . ' ' . name)
  let s:sock = vimproc#socket_open('localhost', port)
endfunction

function! jake#disconnect()
  call s:sock.close()
endfunction

function! jake#eval(cmd)
  call s:sock.write(a:cmd . "\n")
  sleep 5m
  let res = s:sock.read_lines()
  return join(res, "\n")
endfunction

function! jake#eval_line()
  return jake#eval(getline("."))
endfunction

function! jake#eval_range()
  return jake#eval(jake#get_visual_selection())
endfunction

function! jake#load_file(file)
  return jake#eval(".load " . a:file . "\n")
endfunction

function! s:setup()
  command! -buffer JakeConnect call jake#connect()
  command! -buffer JakeDisconnect call jake#disconnect()
  command! -buffer JakeEvalLine echo jake#eval_line()
  command! -buffer -range JakeEvalRange echo jake#eval_range()
  command! -buffer JakeLoadFile call jake#load_file(expand("%:p"))

  nmap <buffer> cpp :JakeEvalLine<CR>
  nmap <buffer> cpl :JakeLoadFile<CR>
  vmap <buffer> cpp :JakeEvalRange<CR>
endfunction

augroup jake_start
  autocmd!
  autocmd FileType javascript call s:setup()
augroup END
