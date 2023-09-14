return {
  parse(
    'arrayfrom',
    [[
Array.from({ length: ${1:length} }, (_, i) => {
  return $0
})
]]
  ),
}
