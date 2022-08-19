return {
  parse(
    'while',
    [[
  while [[ ${1:condition} \]\]; do
  ${0}
done]]
  ),
}
