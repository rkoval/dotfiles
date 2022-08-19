return {
  parse('forloop', [[
for (let ${1:index} = 0; ${1:index} < ${2:array}.length; ${1:index}++) {
  const ${3:element} = ${2:array}[${1:index}];
  $0
}
]]),
}