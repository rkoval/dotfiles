return {
  parse(
    'func',
    [[function ${1:name}($2)
  ${3:-- code}
end
  ]]
  ),
}
