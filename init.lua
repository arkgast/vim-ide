_G.__luacache_config = {
  chunks = {
    enable = true,
    path = vim.fn.stdpath('cache') .. '/luacache_chunks',
  },
  modpaths = {
    enable = true,
    path = vim.fn.stdpath('cache') .. '/luacache_modpaths',
  }
}

local ok = require("impatient")
if not ok then
  print("impatient is not installed")
end

require("settings")
require("plugins")
require("keybindings")
