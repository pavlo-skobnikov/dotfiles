local function get_text_object_lines()
  local start_line_number = vim.fn.getpos("'[")[2]
  local end_line_number = vim.fn.getpos("']")[2]

  return start_line_number, end_line_number
end

_G.NormalOperatorFunction = function()
  local start_line_number, end_line_number = get_text_object_lines()

  vim.fn.feedkeys(string.format(':%d,%d normal ', start_line_number, end_line_number))
end

_G.SubstituteOperatorFunction = function()
  local start_line_number, end_line_number = get_text_object_lines()

  vim.fn.feedkeys(string.format(':%d,%d substitute/', start_line_number, end_line_number))
end
