return {
    parse('rd', [[
  http.Redirect(${1:w}, ${2:r}, "${3:/}", ${4:http.StatusFound})
  ]]),
  }