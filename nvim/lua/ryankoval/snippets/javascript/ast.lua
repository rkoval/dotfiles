return {
  parse('ast', [[
await new Promise((r) => setTimeout(r, ${0}))
]]),
}