return {
  parse('keymap', "vim.api.nvim_set_keymap('${1:n}', '${2:<leader>}', ${3:something}, {})"),
}
