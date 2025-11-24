-- https://github.com/mason-org/mason.nvim

local ok, mason = pcall(require, 'mason')
if not ok then
  return
end

mason.setup({
  ui = {
    backdrop = 0, -- no transparency
    width = 0.9, -- default is 0.8
    height = 0.9, -- default is 0.8
  },
})
