return {
    parse('until', [[
  until [[ ${1:condition} ]]; do
  ${0}
done

  ]]),
  }