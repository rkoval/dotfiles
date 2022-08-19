return {
  parse(
    'forline',
    [[
  f = io.open(${1:"${2:filename}"}, "${3:r}")

while true do
  line = f:read()
  if line == nil then break end

  ${0:-- code}
end
  ]]
  ),
}
