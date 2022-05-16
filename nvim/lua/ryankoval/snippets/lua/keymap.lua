return {
  parse('keymap', "vim.keymap.set('${1:n}', '${2:<leader>}', ${3:something}, { noremap = true, silent = true })"),
}
