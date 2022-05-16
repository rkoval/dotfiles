return {
  parse(
    'foreach',
    [[for ${1:key},${2:value} in pairs(${3:table}) do
    ${0:-- do something}
end]]
  ),
}
