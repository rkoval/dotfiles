return {
    parse('ir', [[
  if err != nil {
  ${1:return ${2:nil, }${3:err}}
}
  ]]),
  }