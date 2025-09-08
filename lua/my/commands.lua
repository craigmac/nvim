-- Ex commands
vim.api.nvim_create_user_command('Cd', 'tcd %:h', {})
vim.api.nvim_create_user_command('Todo', 'grep TODO | copen', {})
vim.api.nvim_create_user_command('TitleCaseLine', [[ :s/\v<(.)(\w*)/\u\1\L\2/g ]] , {})
