local command = function(l, r, o) vim.api.nvim_create_user_command(l, r, o or {}) end

command('Cd', 'tcd %:h')
command('Todo', 'grep TODO | copen')
