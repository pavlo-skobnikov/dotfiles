local extra = require 'mini.extra'

-- [ Text changes 📒 ]
local gen_ai_spec = extra.gen_ai_spec

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
    mark = '<C-i>',
    choose_marked = '<C-q>',

    refine = '<C-Space>',
    refine_marked = '',

    scroll_down = '<C-j>',
    scroll_up = '<C-k>',

    toggle_info = '<C-o>',
    toggle_preview = '<C-y>',
  },
}

-- Remove unused pickers.
pick.registry.explorer = nil
pick.registry.git_files = nil
pick.registry.visit_labels = nil
pick.registry.visit_paths = nil

---Creates a picker "action" for the currently selected item or marked items via
---the processing function. After processing, the picker will not be closed.
local function get_selections_removing_function(func)
  return function()
    -- Retrieve the matched items.
    local matches = pick.get_picker_matches()
    if matches == nil then return true end

    -- If there are multiple marked items, apply the function to all of them.
    -- Otherwise, process the currently selected (highlighted) item.
    if #matches.marked > 1 then
      vim.iter(ipairs(matches.marked_inds)):each(function(ind) func(ind, matches.all[ind]) end)

      -- Remove the items from the larget indices first to avoid index issues.
      table.sort(matches.marked_inds, function(a, b) return a > b end)
      vim.iter(matches.marked_inds):each(function(item) table.remove(matches.all, item) end)
    else
      func(matches.current_ind, matches.current)
      table.remove(matches.all, matches.current_ind)
    end

    -- Set the updated item list into the picker.
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
    func = get_selections_removing_function(
      function(_, item) vim.api.nvim_buf_delete(item.bufnr, { force = true }) end
    ),
  }

  pick.builtin.buffers(local_opts, opts)
end

pick.registry.list = function(local_opts, opts)
  opts = opts or {}
  opts.mappings = opts.mappings or {}

  if local_opts.scope == 'quickfix' then
    opts.mappings.delete_qflist_entry = {
      char = '<C-d>',
      func = get_selections_removing_function(function(ind, _)
        local qflist_entries = vim.fn.getqflist()

        table.remove(qflist_entries, ind)
        vim.fn.setqflist(qflist_entries, 'r')
      end),
    }

    opts.mappings.qflist_filter = {
      char = '<C-f>',
      func = function()
        local term = vim.fn.input 'Filter quickfix for term: '

        -- Support filtering out items with a leading exclamation mark.
        if term:sub(1, 1) == '!' then
          vim.cmd('Cfilter! ' .. term:sub(2))
        elseif term:sub(1, 2) == '\\!' then
          vim.cmd('Cfilter! ' .. term:sub(2))
        else
          vim.cmd('Cfilter ' .. term)
        end

        pick.stop()
        extra.pickers.list(local_opts, opts)
      end,
    }
  end

  extra.pickers.list(local_opts, opts)
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
  local items = vim
    ---@diagnostic disable-next-line: param-type-mismatch
    .iter(ipairs(vim.fn.argv()))
    :map(function(ind, arg)
      return {
        -- Display the entries in the following format: `<INDEX>: <ARG>`
        text = ind .. ': ' .. arg,
        nr = ind,
        arg = arg,
      }
    end)
    :totable()

  pick.start {
    mappings = {
      -- Delete the selected argument, refresh the items, and continue.
      delete_arg = {
        char = '<C-d>',
        func = get_selections_removing_function(function(_, item) vim.cmd.argdelete(item.arg) end),
      },
    },
    source = {
      choose = function(item)
        -- Manually feed keys because `vim.cmd` isn't switching buffers from
        -- within this callback for some reason.
        local command = ':<C-u>argument ' .. item.nr .. '<Cr>'
        local escaped_command = vim.api.nvim_replace_termcodes(command, true, true, true)

        vim.api.nvim_feedkeys(escaped_command, 'n', false)
      end,
      name = 'Arguments',
      items = items,
    },
  }
end

pick.registry.qflist_history = function()
  -- Exit early if no quickfix history is available.
  local last_nr = vim.fn.getqflist({ nr = '$' }).nr
  if last_nr == 0 then
    vim.notify('Quickfix history is empty', vim.log.levels.INFO)
    return
  end

  -- Build the items list (in a reverse order, so the newer entries are at the top)
  local current_nr = vim.fn.getqflist({ nr = 0 }).nr
  local items = {}

  for i = last_nr, 1, -1 do
    local info = vim.fn.getqflist { nr = i, id = 0, title = 0, size = 0 }
    local indicator = (i == current_nr) and '*' or ' '
    local title = (info.title and info.title ~= '') and info.title or '[No Title]'

    table.insert(items, {
      -- Display the command that created the quickfix list and the number of entries.
      text = string.format('%s %d: %s (%d items)', indicator, i, title, info.size),
      -- Store the target number so we can access it in the `choose` callback
      nr = i,
    })
  end

  -- Start the picker.
  pick.start {
    source = {
      name = 'Quickfix History',
      items = items,
      choose = function(item)
        local target_nr = item.nr
        local current = vim.fn.getqflist({ nr = 0 }).nr

        -- Navigate back or forward in the history stack.
        if target_nr < current then
          vim.cmd((current - target_nr) .. 'colder')
        elseif target_nr > current then
          vim.cmd((target_nr - current) .. 'cnewer')
        end

        -- Open the quickfix window to show the newly selected list
        vim.cmd 'copen'
        vim.notify(string.format('Switched to Quickfix List #%d', target_nr), vim.log.levels.INFO)
      end,
    },
  }
end

-- [ Extra stuff 🎉 ]
extra.setup {}
