local Path = require('plenary.path')

local Files = {}

Files.get_filename_without_extension = function(absolute_path)
  local split_path = vim.split(absolute_path, Path.path.sep, true)
  local filename_with_extension = split_path[#split_path]
  local filename = vim.split(filename_with_extension, '.', true)[1]
  return filename
end

Files.glob_path = function(directory, glob)
  local text = vim.fn.globpath(directory, glob)
  return vim.fn.split(text, '\n')
end

-- taken from https://github.com/neovim/neovim/pull/13896/files
function vim.get_marked_region(mark1, mark2, options)
  local bufnr = 0
  local adjust = options.adjust or function(pos1, pos2)
    return pos1, pos2
  end
  local regtype = options.regtype or vim.fn.visualmode()
  local selection = options.selection or (vim.o.selection ~= 'exclusive')

  local pos1 = vim.fn.getpos(mark1)
  local pos2 = vim.fn.getpos(mark2)
  pos1, pos2 = adjust(pos1, pos2)

  local start = { pos1[2] - 1, pos1[3] - 1 + pos1[4] }
  local finish = { pos2[2] - 1, pos2[3] - 1 + pos2[4] }

  -- Return if start or finish are invalid
  if start[2] < 0 or finish[1] < start[1] then
    return
  end

  local region = vim.region(bufnr, start, finish, regtype, selection)
  return region, start, finish
end

Files.get_visual_selection = function()
  local bufnr = 0
  local visual_modes = {
    v = true,
    V = true,
    -- [t'<C-v>'] = true, -- Visual block does not seem to be supported by vim.region
  }

  -- Return if not in visual mode
  if visual_modes[vim.api.nvim_get_mode().mode] == nil then
    return
  end

  local options = {}
  options.adjust = function(pos1, pos2)
    if vim.fn.visualmode() == 'V' then
      pos1[3] = 1
      pos2[3] = 2 ^ 31 - 1
    end

    if pos1[2] > pos2[2] then
      pos2[3], pos1[3] = pos1[3], pos2[3]
      return pos2, pos1
    elseif pos1[2] == pos2[2] and pos1[3] > pos2[3] then
      return pos2, pos1
    else
      return pos1, pos2
    end
  end

  local region, start, finish = vim.get_marked_region('v', '.', options)

  -- Compute the number of chars to get from the first line,
  -- because vim.region returns -1 as the ending col if the
  -- end of the line is included in the selection
  local lines = vim.api.nvim_buf_get_lines(bufnr, start[1], finish[1] + 1, false)
  local line1_end
  if region[start[1]][2] - region[start[1]][1] < 0 then
    line1_end = #lines[1] - region[start[1]][1]
  else
    line1_end = region[start[1]][2] - region[start[1]][1]
  end

  lines[1] = vim.fn.strpart(lines[1], region[start[1]][1], line1_end, true)
  if start[1] ~= finish[1] then
    lines[#lines] = vim.fn.strpart(lines[#lines], region[finish[1]][1], region[finish[1]][2] - region[finish[1]][1])
  end
  return table.concat(lines)
end

Files.get_current_filename_without_extension = function()
  local filename = Files.get_filename_without_extension(vim.api.nvim_buf_get_name(0))
  return filename
end

Files.get_selection = function()
  local selection = Files.get_visual_selection() or vim.fn.expand('<cword>')
  return selection
end

return Files
