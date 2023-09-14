return {
  parse('settimeout', [[
setTimeout(() => {
  $0
}, ${1:timeout});
]]),
}