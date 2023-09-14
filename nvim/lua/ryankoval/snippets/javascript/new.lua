return {
  parse('new', [[
const ${1:name} = new ${2:type}(${3:arguments});$0
]]),
}