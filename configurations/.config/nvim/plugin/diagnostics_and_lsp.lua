-- Diagnostics configuration.
vim.diagnostic.config {
    -- Make diagnostics pop-up similar to other pop-ups.
    float = { border = 'rounded' },
    -- Open the diagnostics float when jumping to a diagnostic.
    jump = { float = true },
}

-- Enable inlay hints by default.
vim.lsp.inlay_hint.enable(true)

-- A convenience command for inlay hints.
vim.api.nvim_create_user_command(
    'ToggleLanguageServerInlayHints',
    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
    { desc = 'Toggles on/off inlay hints provided by the language server' }
)

-- Maps.
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('AddBaseLspMaps', { clear = true }),
    pattern = '*',
    callback = function()
        local function map(m, lhs, rhs, desc)
            vim.keymap.set(m, lhs, rhs, { buffer = true, desc = desc })
        end

        map({ 'n', 'x' }, 'gd', vim.lsp.buf.declaration, 'Go to declaration')

        map({ 'n', 'x' }, '<Leader>ka', vim.lsp.buf.code_action, 'Perform contextual action')
        map('n', '<Leader>kr', vim.lsp.buf.rename, 'Rename symbol')
        map('n', '<Leader>kh', vim.lsp.buf.document_highlight, 'Highlight symbol')
        map('n', '<Leader>kl', vim.lsp.buf.clear_references, 'Clear symbol highlights')

        --- @param item 'sub' | 'super'
        local function typehierarchy(item)
            return function() vim.lsp.buf.typehierarchy(item .. 'types') end
        end

        map('n', '<Leader>kp', typehierarchy 'super', 'Go to parent type')
        map('n', '<Leader>kc', typehierarchy 'sub', 'Go to child type')

        -- Pass an option to a language-server function to add rounded borders to the
        -- function's related floating window pop-up.
        local function add_rounded_borders(fn)
            return function() fn { border = 'rounded' } end
        end

        map({ 'n', 'x' }, 'K', add_rounded_borders(vim.lsp.buf.hover), 'Hover')
        map('i', '<C-s>', add_rounded_borders(vim.lsp.buf.signature_help), 'Signature help')
    end,
    desc = 'Set buffer-local Neovim-native language-server mappings',
})
