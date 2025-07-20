return {
    'mason-org/mason.nvim',
    event = 'VeryLazy',
    -- Make the UI match lazy.nvim.
    opts = { ui = { width = 0.85, height = 0.85 } },
    config = function(_, opts)
        require('mason').setup(opts)

        local ensure_installed = {
            -- Lua.
            'lua-language-server',
            'stylua',
            -- Bash.
            'bash-language-server',
            'shfmt',
        }

        local registry = require 'mason-registry'

        for _, package_name in ipairs(ensure_installed) do
            if registry.is_installed(package_name) then goto continue end

            vim.notify('[mason.nvim]: Missing [' .. package_name .. '] package. Installing...')

            registry.get_package(package_name):install()

            ::continue::
        end
    end,
}
