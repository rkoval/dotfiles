return {
    parse('ife', [[
  if ${1:condition} {
  $2
} else {
  $0
}
  ]]),
  }