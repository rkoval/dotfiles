return {
    parse('for/else', [[
  for ${1:target_list} in ${2:expression_list}:
  ${3:pass}
else:
  ${4:pass}
  ]]),
  }