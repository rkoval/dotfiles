return {
  parse('cb', [[
function (err, ${1:value}) {
  if (err) throw err
  ${0}
}
]]),
}