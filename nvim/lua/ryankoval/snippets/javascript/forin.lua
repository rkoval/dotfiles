return {
  parse('forin', [[
for (const ${1:key} in ${2:object}) {
  if (${2:object}.hasOwnProperty(${1:key})) {
    const ${3:element} = ${2:object}[${1:key}];
    $0
  }
}
]]),
}