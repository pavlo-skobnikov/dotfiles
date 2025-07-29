return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    opts = {
        ensure_installed = {
            'c',
            'lua',
            'vim',
            'vimdoc',
            'query',
            'markdown',
            'markdown_inline',
            'bash',
        },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            -- Disable Treesitter for large files.
            disable = function(_, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                ---@diagnostic disable-next-line: undefined-field
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then return true end
            end,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<C-k>',
                node_incremental = '<C-k>',
                scope_incremental = false,
                node_decremental = '<C-j>',
            },
        },
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ['aa'] = {
                        query = '@parameter.outer',
                        desc = 'argument/parameter',
                    },
                    ['ia'] = {
                        query = '@parameter.inner',
                        desc = 'inner argument/parameter region',
                    },
                    ['am'] = {
                        query = '@function.outer',
                        desc = 'function',
                    },
                    ['im'] = {
                        query = '@function.inner',
                        desc = 'inner function region',
                    },
                    ['aT'] = {
                        query = '@class.outer',
                        desc = 'type',
                    },
                    ['iT'] = {
                        query = '@class.inner',
                        desc = 'inner type region',
                    },
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    [']xa'] = {
                        query = '@parameter.inner',
                        desc = 'Next argument/parameter',
                    },
                },
                swap_previous = {
                    ['[xa'] = {
                        query = '@parameter.inner',
                        desc = 'Previous argument/parameter',
                    },
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    [']m'] = {
                        query = '@function.outer',
                        desc = 'Next function start',
                    },
                    [']]'] = {
                        query = '@class.outer',
                        desc = 'Next type start',
                    },
                },
                goto_next_end = {
                    [']M'] = {
                        query = '@function.outer',
                        desc = 'Next function end',
                    },
                    [']['] = {
                        query = '@class.outer',
                        desc = 'Next type end',
                    },
                },
                goto_previous_start = {
                    ['[m'] = {
                        query = '@function.outer',
                        desc = 'Previous function start',
                    },
                    ['[['] = {
                        query = '@class.outer',
                        desc = 'Previous type start',
                    },
                },
                goto_previous_end = {
                    ['[M'] = {
                        query = '@function.outer',
                        desc = 'Previous function end',
                    },
                    ['[]'] = {
                        query = '@class.outer',
                        desc = 'Previous type end',
                    },
                },
            },
            lsp_interop = {
                enable = true,
                border = 'rounded',
                peek_definition_code = {
                    ['<leader>kk'] = {
                        query = '@function.outer',
                        desc = 'Peek function definition',
                    },
                    ['<leader>kK'] = {
                        query = '@class.outer',
                        desc = 'Peek type definition',
                    },
                },
            },
        },
    },
    config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end,
}
