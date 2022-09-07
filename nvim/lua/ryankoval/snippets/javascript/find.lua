return {
  parse(
    'find',
    [[find((${1:item}) => {
  $0
  return ${2:trueOrFalse}
});]]
  ),
}
