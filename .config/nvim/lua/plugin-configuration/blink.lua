local function get_mini_icons_function(information_kind)
  return function(ctx)
    local kind_icon, hl, _ = require('mini.icons').get('lsp', ctx.kind)

    if information_kind == 'kind_icon' then
      return kind_icon
    elseif information_kind == 'highlight' then
      return hl
    end

    error('Unknown information kind: ' .. information_kind)
  end
end

require('blink-cmp').setup {
  keymap = {
    preset = 'none',

    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<C-y>'] = { 'select_and_accept', 'fallback' },

    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

    ['<C-j>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-k>'] = { 'scroll_documentation_down', 'fallback' },

    ['<C-h>'] = { 'snippet_backward', 'fallback' },
    ['<C-l>'] = { 'snippet_forward', 'fallback' },
  },

  completion = {
    -- Auto-show the documentation popup.
    documentation = { auto_show = true },
    -- Preselect the completion item without inserting it before accepting.
    list = { selection = { preselect = true, auto_insert = false } },
    -- Use `mini.icons`.
    menu = {
      draw = {
        components = {
          kind_icon = { text = get_mini_icons_function 'kind_icon', highlight = get_mini_icons_function 'highlight' },
          kind = { highlight = get_mini_icons_function 'highlight' },
        },
      },
    },
  },

  -- List of enabled completion providers.
  sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },

  cmdline = {
    completion = {
      -- Auto-show the completion menu in the cmdline.
      menu = { auto_show = true },
      -- Do not preselect any completions.
      list = { selection = { preselect = false } },
    },
    keymap = {
      preset = 'none',

      ['<Tab>'] = { 'show_and_insert_or_accept_single', 'select_next' },
      ['<S-Tab>'] = { 'show_and_insert_or_accept_single', 'select_prev' },

      ['<C-space>'] = { 'show', 'fallback' },
      ['<C-e>'] = { 'cancel', 'fallback' },
      ['<C-y>'] = { 'select_and_accept', 'fallback' },

      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },
    },
  },

  -- Ensure Rust binary is used for fuzzy matching.
  fuzzy = { implementation = 'prefer_rust_with_warning' },
}
