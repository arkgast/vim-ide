-- _G.__luacache_config = {
--   chunks = {
--     enable = true,
--     path = vim.fn.stdpath("cache") .. "/luacache_chunks",
--   },
--   modpaths = {
--     enable = true,
--     path = vim.fn.stdpath("cache") .. "/luacache_modpaths",
--   },
-- }

-- local ok = require("impatient")
-- if not ok then
--  print("impatient is not installed")
-- end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("plugins")
require("settings")
require("keybindings")
