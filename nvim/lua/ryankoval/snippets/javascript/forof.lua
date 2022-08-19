return {
  parse('forof', [[
for (const ${1:iterator} of ${2:object}) {
  $0
}
]]),
}