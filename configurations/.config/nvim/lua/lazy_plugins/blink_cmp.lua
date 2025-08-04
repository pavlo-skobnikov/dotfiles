return {
    'saghen/blink.cmp',
    lazy = false,
    version = '1.*',
    ---@type blink.cmp.Config
    opts = {
        appearance = { nerd_font_variant = 'mono' },
        completion = {
            accept = { auto_brackets = { enabled = false } },
            documentation = { auto_show = true, window = { border = 'single' } },
        },
        sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
        fuzzy = { implementation = 'prefer_rust_with_warning' },
        signature = { enabled = true, window = { border = 'single' } },
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
        -- Change Tab behavior in cmdline to only show the completion menu.
        cmdline = {
            keymap = {
                -- Make 'cmdline' behave like my Zsh completion setup.
                ['<Tab>'] = { 'show' },
                ['<C-n>'] = {
                    function(cmp)
                        if not cmp.is_menu_visible() then
                            cmp.show_and_insert()
                            return true
                        end
                    end,
                    'select_next',
                },
                ['<C-p>'] = {
                    function(cmp)
                        if not cmp.is_menu_visible() then
                            cmp.show_and_insert()
                            return true
                        end
                    end,
                    'select_prev',
                },
                ['<C-y>'] = {
                    'select_accept_and_enter',
                    function(cmp)
                        if not cmp.is_menu_visible() then
                            local key = vim.api.nvim_replace_termcodes('<Cr>', true, false, true)
                            vim.api.nvim_feedkeys(key, 'c', false)

                            return true
                        end
                    end,
                },
            },
        },
    },
    opts_extend = { 'sources.default' },
}
