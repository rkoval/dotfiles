return {
    parse('tryef', [[
  try:
  ${1:pass}
except${2: ${3:Exception} as ${4:e}}:
  ${5:raise}
else:
  ${6:pass}
finally:
  ${7:pass}$0
  ]]),
  }