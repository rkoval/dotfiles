return {
  parse(
    'eslint-disable-next-line',
    [[// ${1:please explain why you're doing this}
// eslint-disable-next-line ${2:eslint-rule-name}
]]
  ),
}
