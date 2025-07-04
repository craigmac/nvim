-- skip if user code explicitly disables
if vim.g.news_check == false then return end

-- skip when nvim is not a prerelease build
if vim.version().prerelease ~= 'dev' then return end

-- skip in embedded situations where the UI client is 'firenvim', 'vscode-neovim', etc.
if vim.api.nvim_get_chan_info(vim.api.nvim_list_uis()[1].chan).client.name ~= 'nvim-tui' then return end

-- skip if nvim was started clean, which by default loads builtin plugins
if vim.list_contains(vim.v.argv, '--clean') then return end

-- skip if nvim was started as a Lua interpreter
if vim.list_contains(vim.v.argv, '-l') then return end

-- skip if we can't read/write the shada file, for example it is
-- set to 'NONE' by `--clean` or `-i NONE` command line flags
if vim.o.shadafile == 'NONE' then return end

-- skip if missing ability to store/read global vars in shada file
if not vim.o.shada:match('!') then return end

vim.g.news_check = {}

vim.api.nvim_create_user_command('News', function()
  local news_path = vim.fs.normalize('$VIMRUNTIME/doc/news.txt')
  local cache_path = vim.fs.normalize(vim.fn.stdpath('state') .. '/news.txt')
  vim.cmd.tabedit(news_path)
  vim.cmd.diffsplit(cache_path)
  vim.cmd.wincmd('J')
end, {
  desc = 'Show a diff of changes to the runtime news.txt file.',
})

local augroup = vim.api.nvim_create_augroup('news', {})

vim.api.nvim_create_autocmd('CursorHold', {
  group = augroup,
  desc = 'Notifies user of changes to the news.txt file.',
  once = true,
  callback = function() require('news').check_for_news_changes() end,
})
