-- Bootstrap lazy.nvim.
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        lazyrepo,
        lazypath,
    }

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

-- Add lazy plugins to Neovim's runtimepath.
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim.
require('lazy').setup {
    -- Directory with plugin definitions.
    spec = { { import = 'lazy_plugins' } },
    -- Do not load plugins by default.
    defaults = { lazy = true },
    -- Colorscheme that will be used when installing plugins.
    install = { colorscheme = { 'habamax' } },
    -- Don't show notificaitons when updating lazy plugin definitions.
    change_detection = { notify = false },
    -- Make the UI larger.
    ui = { size = { width = 0.85, height = 0.85 } },
}
