-- neovim 0.6+ configuration

-- General
-- require 'my.utils'
require "my.options"
require "my.plugins"
require "my.keymaps"
require "my.autocommand"
require "my.colorscheme"

-- Plugins
require "my.treesitter"
require "my.cmp"
require "my.fugitive"
require "my.comment"
-- require "my.gitsigns"
require "my.lsp"
-- require "my.lualine"
require "my.telescope"
-- require "my.toggleterm"

-- TODO 
-- * all keymaps from old config
-- * telescope use dropdown theme for most things

-- command! Api :help list-functions<CR>
-- command! Cd :cd %:h
-- command! TodoLocal :botright lvimgrep /\v\CTODO|FIXME|HACK|DEV/ %<CR>
-- command! Todo :botright silent! vimgrep /\v\CTODO|FIXME|HACK|DEV/ *<CR>
-- autocmd QuickFixCmdPost [^l]* cwindow
-- autocmd QuickFixCmdPost  l* lwindow

--
-- " Tabline
-- function! MyTabLine()
--   " Loop over pages and define labels for them, then get label for each tab
--   " page use MyTabLabel(). See :h 'statusline' for formatting, e.g., T, %, #, etc.
--   let s = ''
--   for i in range(tabpagenr('$'))
--     if i + 1 == tabpagenr()
--       " use hl-TabLineSel for current tabpage
--       let s .= '%#TabLineSel#'
--     else
--       let s .= '%#TabLine#'
--     endif
--
--     " set the tab page number, for mouse clicks
--     let s .= '%' . (i + 1) . 'T'
--
--     " call MyTabLabel() to make the label
--     let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
--   endfor
--
--   " After last tab fill with hl-TabLineFill and reset tab page nr with %T
--   let s .= '%#TabLineFill#%T'
--
--   " Right-align (%=) hl-TabLine (%#TabLine#) style and use %999X for a close
--   " current tab mark, with 'X' as the character
--   if tabpagenr('$') > 1
--     let s .= '%=%#TabLine#%999XX'
--   endif
--
--   return s
-- endfunction

-- function! MyTabLabel(n)
--   Give tabpage number n create a string to display on tabline
--   let buflist = tabpagebuflist(a:n)
--   let winnr = tabpagewinnr(a:n)
--   return getcwd(winnr, a:n)
-- endfunction
