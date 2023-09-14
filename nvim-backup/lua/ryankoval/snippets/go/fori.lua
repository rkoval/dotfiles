return {
    parse('fori', [[
  for ${1:i} := ${2:0}; $1 < ${3:count}; $1${4:++} {
  $0
}
  ]]),
  }