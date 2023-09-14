return {
    parse('hf', [[
  ${1:http}.HandleFunc("${2:/}", ${3:handler})
  ]]),
  }