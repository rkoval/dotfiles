return {
  parse(
    'eafunc',
    [[
export async function ${1:name}(${2:arguments}) {
  ${0}
}
]]
  ),
}
