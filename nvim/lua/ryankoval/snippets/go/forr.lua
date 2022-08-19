return {
    parse('forr', [[
  for ${1:_, }${2:v} := range ${3:v} {
  $0
}
  ]]),
  }