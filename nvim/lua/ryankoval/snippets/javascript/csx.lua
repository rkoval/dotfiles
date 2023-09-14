return {
  parse('csx', [[
class ${1:name} extends ${2:base} {
  constructor (${3:arguments}) {
    super(${3:arguments})
    ${0}
  }
}
]]),
}