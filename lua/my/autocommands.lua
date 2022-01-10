-- TODO: move this to commands.lua file instead
vim.cmd([[
  command! JekyllOpen call utils#JekyllOpenLive()
  nnoremap <Leader>@ :JekyllOpen<CR>
  command! Api :help list-functions<CR>
  command! TodoLocal :botright lvimgrep /\v\CTODO|FIXME|HACK|DEV/ %<CR>
  command! Todo :botright silent! vimgrep /\v\CTODO|FIXME|HACK|DEV/ *<CR>
]])

vim.cmd([[
augroup my_autocommands
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost  l* lwindow
  autocmd BufWritePost ~/.config/nvim/init.lua source ~/.config/nvim/init.lua
  autocmd FileType fugitiveblame call feedkeys('A')
  autocmd FileType gitcommit call feedkeys('i')
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END
]])
