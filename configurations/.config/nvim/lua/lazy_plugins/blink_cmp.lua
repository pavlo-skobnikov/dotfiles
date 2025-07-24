return {
    'saghen/blink.cmp',
    lazy = false,
    version = '1.*',
    ---@type blink.cmp.Config
    opts = {
        appearance = { nerd_font_variant = 'mono' },
        completion = {
            accept = { auto_brackets = { enabled = false } },
            documentation = {
                auto_show = true,
                window = { border = 'rounded' },
            },
        },
        sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
        fuzzy = { implementation = 'prefer_rust_with_warning' },
        signature = {
            enabled = true,
            window = { border = 'rounded' },
        },
        keymap = {
            preset = 'none',
            ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
            ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<C-y>'] = { 'select_and_accept' },
            ['<C-e>'] = {
                -- If in an active snippet, stop the snippet and do not run any further actions.
                function(cmp)
                    if cmp.snippet_active() then
                        vim.snippet.stop()
                        return true
                    end
                end,
                'cancel',
                'fallback',
            },
            ['<C-d>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-u>'] = { 'scroll_documentation_down', 'fallback' },
            ['<C-l>'] = { 'snippet_forward', 'fallback' },
            ['<C-h>'] = { 'snippet_backward', 'fallback' },
            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
    },
    opts_extend = { 'sources.default' },
}
