return {
    parse('foreach', [[
  for i, ${1:x} in pairs(${2:table}) do
  $0
end
  ]]),
  }