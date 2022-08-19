return {
    parse('elseif', [[
  elif [[ ${1:condition} ]]; then
  ${0}
  ]]),
  }