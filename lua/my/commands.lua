-- Ex commands
vim.api.nvim_create_user_command('Cd', 'tcd %:h', {})
vim.api.nvim_create_user_command('Todo', 'grep TODO | copen', {})
vim.api.nvim_create_user_command('TitleCaseLine', [[ :s/\v<(.)(\w*)/\u\1\L\2/g ]] , {})

---Usage: `:Cgetprog <tool>`
---
---Create a callback function that runs external <tool> on the current buffer, integrating
---results with the vim.diagnostics modules/framework.
---
---We could call this in a FileType autocmd to set our CLI linter, and it would run immediately
---and on BufWritePost for the same buffer.
local namespace = vim.api.nvim_create_namespace("diagnostics")
vim.api.nvim_create_user_command("Cgetprog", function(args)
    local bufnr = vim.api.nvim_get_current_buf()

    local set_diagnostics = function()
        vim.cmd(string.format("cgetexpr system(expandcmd('%s'))", args.args))
        vim.diagnostic.set(namespace, bufnr, vim.diagnostic.fromqflist(vim.fn.getqflist()), {})
    end
    set_diagnostics()

    local augrp = vim.api.nvim_create_augroup("diagnostic_refresh", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost",  {
        callback = set_diagnostics,
        buffer = bufnr,
        group = augrp
    })
end, { nargs = "+" })
