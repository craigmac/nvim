local autocmd = function(...) vim.api.nvim_create_autocmd(...) end
local my_augroup = vim.api.nvim_create_augroup("MyAugroup", {})

autocmd("TextYankPost", {
  group = my_augroup,
  callback = function(_) vim.highlight.on_yank() end
})

autocmd("BufReadPost", {
  group = my_augroup,
  once = true,
  nested = true,
  callback = function(args)
    local ln = vim.fn.line("'\"")
    local lastln = vim.fn.line("$")

    if ln > 1 and ln <= lastln then
        vim.cmd[[execute "normal! g`\""]]
    end
  end
})

autocmd("TermOpen", {
  group = my_augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd.startinsert()
  end,
})

-- Try starting treesitter for all filetypes, ignoring errors
autocmd("FileType", {
  group = my_augroup,
  callback = function() pcall(vim.treesitter.start) end,
  once = true,
  nested = true,
})

autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
  group = my_augroup,
  command = "setlocal cursorline"
})

autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
  group = my_augroup,
  command = "setlocal nocursorline"
})

