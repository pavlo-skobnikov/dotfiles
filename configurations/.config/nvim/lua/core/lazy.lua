-- Bootstrap lazy.nvim.
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

-- Add lazy-managed directory with plugin installations to the `runtimepath`.
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim.
require('lazy').setup {
    -- Define directory.
    spec = { { import = 'lazy_plugins' } },
    -- `colorscheme` that will be used when installing plugins.
    install = { colorscheme = { 'habamax' } },
    -- Don't show any notifications when lazy-managed plugin definitions change.
    change_detection = { notify = false },
}
