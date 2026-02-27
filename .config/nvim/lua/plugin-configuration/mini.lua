-- [ Text changes 📒 ]
local gen_ai_spec = require('mini.extra').gen_ai_spec

require('mini.ai').setup {
  custom_textobjects = {
    d = gen_ai_spec.diagnostic(),
    i = gen_ai_spec.indent(),
    L = gen_ai_spec.line(),
    D = gen_ai_spec.number(),
  },
}

require('mini.align').setup {}

-- go => [o]rganize alphabetically.
require('mini.operators').setup { sort = { prefix = 'go' } }

require('mini.splitjoin').setup {}

require('mini.surround').setup {
  mappings = {
    add = 'gsa',
    delete = 'gsd',
    find = 'gsf',
    find_left = 'gsF',
    highlight = 'gsh',
    replace = 'gsr',
    suffix_last = 'l',
    suffix_next = 'n',
  },
}

-- [ Git gutter 🌊 ]
local diff = require 'mini.diff'

diff.setup {
  mappings = {
    goto_first = '[G',
    goto_prev = '[g',
    goto_next = ']g',
    goto_last = ']G',
  },
}

---@diagnostic disable-next-line: missing-parameter
vim.api.nvim_create_user_command('DiffToggleHunkOverlay', function() diff.toggle_overlay() end, {
  desc = 'Toggle hunk ovelays in the current buffer',
})

-- [ Key hints💡 ]
local clue = require 'mini.clue'

clue.setup {
  window = {
    -- Delay before showing clue window
    delay = 0,

    -- Keys to scroll inside the clue window
    scroll_down = '<C-j>',
    scroll_up = '<C-k>',
  },

  triggers = {
    { mode = { 'n', 'x' }, keys = '<Leader>' },
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },
    { mode = 'i', keys = '<C-x>' },
    { mode = { 'n', 'x' }, keys = 'g' },
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },
    { mode = 'n', keys = '<C-w>' },
    { mode = { 'n', 'x' }, keys = 'z' },
  },

  clues = {
    clue.gen_clues.square_brackets(),
    clue.gen_clues.builtin_completion(),
    clue.gen_clues.g(),
    clue.gen_clues.marks(),
    clue.gen_clues.registers(),
    clue.gen_clues.windows(),
    clue.gen_clues.z(),

    -- Leader key definitions.
    { mode = { 'n', 'x' }, keys = '<Leader>a', desc = '+Actions' },
    { mode = { 'n', 'x' }, keys = '<Leader>f', desc = '+Files' },
    { mode = { 'n', 'x' }, keys = '<Leader>g', desc = '+Git' },
    { mode = { 'n', 'x' }, keys = '<Leader>l', desc = '+Loclist' },
    { mode = { 'n', 'x' }, keys = '<Leader>m', desc = '+Marks' },
    { mode = { 'n', 'x' }, keys = '<Leader>q', desc = '+Qflist' },
    { mode = { 'n', 'x' }, keys = '<Leader>s', desc = '+Symbols' },
    { mode = { 'n', 'x' }, keys = '<Leader>t', desc = '+Tools' },
  },
}

-- [ Icons 🖼️ ]
local icons = require 'mini.icons'

icons.setup {}

icons.mock_nvim_web_devicons()

-- [ Fuzzy picker 🦙 ]
local pick = require 'mini.pick'

pick.setup {
  -- Take up the full width of the editor.
  -- NOTE: You really need this for those Java applications 😭
  window = { config = function() return { width = vim.opt.columns:get() } end },
  -- Keys for performing actions. See `:h MiniPick-actions`.
  mappings = {
    caret_left = '<C-b>',
    caret_right = '<C-f>',

    mark = '<C-y>',
    choose_marked = '<C-q>',

    refine = '<C-Space>',
    refine_marked = '',

    scroll_down = '<C-j>',
    scroll_up = '<C-k>',

    toggle_info = '<C-o>',
    toggle_preview = '<C-i>',
  },
}

-- Remove unused pickers.
pick.registry.explorer = nil
pick.registry.git_files = nil
pick.registry.visit_labels = nil
pick.registry.visit_paths = nil

---Creates a picker "action" for the currently selected item via the processing
---function. After processing, the picker will not be closed.
local function get_selection_processing_function(func)
  return function()
    -- Retrieve the matched items.
    local matches = pick.get_picker_matches()
    if matches == nil then return true end

    -- Process the current selection.
    func(matches.current)

    -- Remove it from the picker entries.
    table.remove(matches.all, matches.current_ind)
    pick.set_picker_items(matches.all)

    return false
  end
end

-- Wrap the existing `buffers` picker with the `delete_buf` action.
pick.registry.buffers = function(local_opts, opts)
  opts = opts or {}
  opts.mappings = opts.mappings or {}
  opts.mappings.delete_buf = {
    char = '<C-d>',
    func = get_selection_processing_function(
      function(current) vim.api.nvim_buf_delete(current.bufnr, { force = true }) end
    ),
  }

  pick.builtin.buffers(local_opts, opts)
end

-- Custom pickers 📦
pick.registry.directories = function()
  MiniPick.start {
    source = {
      items = vim.fn.systemlist 'fd --type=directory',
      name = 'Direcories',
    },
  }
end

pick.registry.arguments = function()
  MiniPick.start {
    mappings = {
      -- Delete the selected argument, refresh the items, and continue.
      delete_arg = {
        char = '<C-d>',
        func = get_selection_processing_function(function(current) vim.cmd.argdelete(current) end),
      },
    },
    source = {
      items = vim.fn.argv,
      name = 'Arguments',
    },
  }
end

-- [ Extra stuff 🎉 ]
require('mini.extra').setup {}
