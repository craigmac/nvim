---Borrowed from:
--- https://github.com/boltlessengineer/NativeVim/blob/9679f7804637ee3a45e9ef92deb4a7906ed92362/lua/core/snippet.lua
---
---@param trigger string trigger string for snippet
---@param body string snippet text that will be expanded
---@param opts? vim.keymap.set.Opts
---
--- Refer to <https://microsoft.github.io/language-server-protocol/specification/#snippet_syntax>
--- for the specification of valid body.
function vim.snippet.add(trigger, body, opts)
  vim.keymap.set("ia", trigger, function()
    -- If abbrev is expanded with keys like "(", ")", "<cr>", "<space>",
    -- don't expand the snippet. Only accept "<c-]>" as trigger key.
    local c = vim.fn.nr2char(vim.fn.getchar(0))
    if c ~= "" then
      vim.api.nvim_feedkeys(trigger .. c, "i", true)
      return
    end
    vim.snippet.expand(body)
    end, opts)
end

-- see after/ftplugin/lua.lua for examples
