return {
    parse('for', [[
  for ${1:i}=${2:1},${3:10} do
  $0
end
  ]]),
  }