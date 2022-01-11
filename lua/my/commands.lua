-- TODO: pure Lua API for :command not supported yet, rewrite when it is
vim.cmd([[
  nnoremap <Leader>@ :JekyllOpen<CR>
  " Don't put <CR> at end of these or it tacks on literal ^M char which
  " will fail in some cases, like with :Cd command
  command! JekyllOpen call utils#JekyllOpenLive()
  command! Api :help list-functions
  command! TodoLocal :botright lvimgrep /\v\CTODO|FIXME|HACK|DEV/ %
  command! Todo :botright silent! vimgrep /\v\CTODO|FIXME|HACK|DEV/ *
  command! Cd :cd %:h

  " update utils.vim file and add:
  command! -nargs=1 Redir silent call utils#Redir(<f-args>)
  nnoremap <Leader>! :<C-u>Redir<space>

]])
