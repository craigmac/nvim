do
  local install_location = vim.fs.joinpath(vim.fn.stdpath("data"), "rocks")

  local rocks_config = {
    rocks_path = vim.fs.normalize(install_location),
    enable_luarocks_loader = false,
    treesitter = {
      auto_highlight = "all",
      auto_install = "prompt",
      parser_map = {},
      ---@type string[] | fun(lang: string, bufnr: integer):boolean
      disable = {},
      config_path = "rocks-treesitter.toml", -- otherwise rocks.toml will be used
    },
  }
  vim.g.rocks_nvim = rocks_config

  -- Configure the package path (so that plugin code can be found)
  local luarocks_path = {
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
  }
  package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

  local luarocks_cpath = {
    -- linux
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
    -- for macOS
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dylib"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dylib"),
    -- windows
    -- vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dll"),
    -- vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dll"),
  }
  package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

  vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1",
    "rocks.nvim", "*"))
end

-- If rocks.nvim is not installed then install it!
if not pcall(require, "rocks") then
  local rocks_location = vim.fs.joinpath(vim.fn.stdpath("cache"), "rocks.nvim")

  if not vim.uv.fs_stat(rocks_location) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/nvim-neorocks/rocks.nvim",
      rocks_location,
    })
  end

  -- If the clone was successful then source the bootstrapping script
  assert(vim.v.shell_error == 0,
    "rocks.nvim installation failed. Try exiting and re-entering Neovim!")
  vim.cmd.source(vim.fs.joinpath(rocks_location, "bootstrap.lua"))
  vim.fn.delete(rocks_location, "rf")
end

-- local rocks_config = {
--   rocks_path = vim.fs.joinpath(vim.fn.stdpath('data'), "rocks"),
--   treesitter = {
--     auto_highlight = "all",
--     auto_install = "prompt",
--     parser_map = {},
--     ---@type string[] | fun(lang: string, bufnr: integer):boolean
--     disable = {},
--     config_path = "rocks-treesitter.toml", -- otherwise rocks.toml will be used
--   },
-- }
-- vim.g.rocks_nvim = rocks_config
--
-- local luarocks_path = {
--     vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
--     vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
-- }
-- package.path = package.path .. ";" .. table.concat(luarocks_path, ";")
--
-- local luarocks_cpath = {
--     vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
--     vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
--     -- for macOS
--     vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dylib"),
--     vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dylib"),
-- }
-- package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")
--
-- vim.opt.runtimepath:append(vim.fs.joinpath(
--   rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "*", "*"))
--
--
