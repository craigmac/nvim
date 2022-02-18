-- pretty-print a Lua table, rather than just printing 'table x0283409234'
-- if you just use :lua print({key: 'value'}) you get 'table 0x92398734'
-- if you use :lua P({key: 'value'}) you'll get:
-- {
--  key: "value"
-- }
-- To see what a module loaded you can do:
-- lua P(package.loaded["stackmap"]) to get something like:
-- {
--  pop = <function_1>,
--  push = <function_2>,
-- }
P = function(val)
  print(vim.inspect(val))
  return val
end

-- to reload a module, using plenary to clear the module cache
RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

-- A wrapper for above, so we can use :lua R("module-name") to unload
-- the module and then re-require it, returning it's contents. Lua's
-- require() basically caches the returned module as: (function() <CODE> end)()
-- and checks a modules table on each require() so it can skip reparsing. This is
-- great for speed, but for developing plugins we need to clear the module's cache
-- everytime we want to 'export' the file again, e.g., we changed/added something.
-- Otherwise require() will just load the saved cache and your new functions/values/whatever
-- will not be visible.
R = function(name)
  RELOAD(name)
  return require(name)
end
