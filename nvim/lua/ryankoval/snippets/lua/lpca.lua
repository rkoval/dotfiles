return {
    parse('lpca', [[
  local ${1:status}, ${2:err_or_value} = pcall(${3:function})
  ]]),
  }