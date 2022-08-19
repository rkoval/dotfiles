return {
    parse('switch', [[
  switch ${1:expression} {
case ${2:condition}:
  $0
}
  ]]),
  }