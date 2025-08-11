-- Diagnostics configuration.
vim.diagnostic.config {
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
        local function map(m, lhs, rhs, desc) vim.keymap.set(m, lhs, rhs, { buffer = true, desc = desc }) end

        map({ 'n', 'v' }, '<Leader>a', vim.lsp.buf.code_action, 'Code action')

        map({ 'n', 'v' }, '<Leader>r', vim.lsp.buf.rename, 'Rename symbol')
        map({ 'n', 'v' }, '<Leader>h', vim.lsp.buf.document_highlight, 'Highlight symbol')
        map({ 'n', 'v' }, '<Leader>H', vim.lsp.buf.clear_references, 'Clear symbol highlights')

        --- @param item 'sub' | 'super'
        local function typehierarchy(item)
            return function() vim.lsp.buf.typehierarchy(item .. 'types') end
        end

        map({ 'n', 'v' }, '<Leader>T', typehierarchy 'super', 'Go to parent type')
        map({ 'n', 'v' }, '<Leader>t', typehierarchy 'sub', 'Go to child type')

        map({ 'n', 'x' }, 'K', vim.lsp.buf.hover, 'Hover')
        map('i', '<C-s>', vim.lsp.buf.signature_help, 'Signature help')
    end,
    desc = 'Set buffer-local Neovim-native language-server mappings',
})
