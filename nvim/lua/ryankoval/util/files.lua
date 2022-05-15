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

return Files
