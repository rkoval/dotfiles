return {
    parse('if', [[
  if [[ ${1:condition} ]]; then
  ${0}
fi
  ]]),
  }