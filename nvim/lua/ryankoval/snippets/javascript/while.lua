return {
  parse('while', [[
while (${1:condition}) {
  $0
}
]]),
}