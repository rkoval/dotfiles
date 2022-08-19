return {
  parse('nc', [[
class ${1:name} {
  constructor (${2:arguments}) {
    ${0}
  }
}

module.exports = ${1:name}

]]),
}