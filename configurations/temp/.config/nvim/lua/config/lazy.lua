-- This file sets up the lazy.nvim plugin manager.
-- https://lazy.folke.io/

-- Bootstrap lazy.nvim.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- Add lazy-managed plugin sources to Neovim's runtimepath.
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim.
require("lazy").setup({
  spec = {
    -- Directory with plugin definitions.
    { import = "plugins" },
  },
  -- Don't automatically check for plugin updates.
  checker = { enabled = false },
  -- Don't show notification when modifying plugin definitions.
  change_detection = { notify = false },
})
