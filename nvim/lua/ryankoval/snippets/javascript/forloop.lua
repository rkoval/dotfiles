return {
  parse(
    'forloop',
    [[
for (let ${1:i} = 0; ${1:i} < ${2:element}s.length; ${1:i}++) {
  const ${2:element} = ${2:element}s[${1:i}];
  $0
}
]]
  ),
}
