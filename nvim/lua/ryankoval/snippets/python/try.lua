return {
    parse('try', [[
  try:
  ${1:pass}
except ${2:Exception} as ${3:e}:
  ${4:raise $3}$0
  ]]),
  }