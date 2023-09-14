return {
  parse(
    'class',
    [[
  ${1:className} = {}

$1.${2:new} = function($3)
  local ${4:varName} = ${5:{}}

  ${6: --code}

  return $4
end
  ]]
  ),
}
