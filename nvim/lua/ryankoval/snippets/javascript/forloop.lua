return {
  parse(
    'forloop',
    [[
for (let ${1:i} = 0; ${1:i} < ${2:array}.length; ${1:i}++) {
  const ${3:element} = ${2:array}[${1:i}];
  $0
}
]]
  ),
}
