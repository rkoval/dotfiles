return {
  parse(
    'for_in',
    [[
  for ${1:VAR} in ${0:LIST}
do
  echo "\$${1:VAR}"
done]]
  ),
}
