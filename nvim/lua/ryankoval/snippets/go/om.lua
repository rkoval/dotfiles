return {
    parse('om', [[
  if ${1:value}, ok := ${2:map}[${3:key}]; ok == true {
  $4
}
  ]]),
  }