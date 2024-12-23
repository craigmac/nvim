local rocks_config = {
  rocks_path = vim.fs.joinpath(vim.fn.stdpath('data'), "rocks"),
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

local luarocks_path = {
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = {
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
    -- for macOS
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dylib"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dylib"),
}
package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

vim.opt.runtimepath:append(vim.fs.joinpath(
  rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "*", "*"))


