local ok, treesitter = pcall(require, 'nvim-treesitter')
if not ok then return end

-- :TSUpdate will async install these if they aren't already installed
-- vim.cmd({ cmd = 'TSInstall', args = { 'stable' } })
