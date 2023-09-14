return {
  parse(
    'forin',
    [[for (const ${1:property} in ${2:object}) {
  const item = ${2:object}[${1:property}];
}
]]
  ),
}
