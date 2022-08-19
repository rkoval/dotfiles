return {
  parse(
    'for_i',
    [[
  for ((${1:i} = 0; ${1:i} < ${0:10}; ${1:i}++)); do
  echo "\$${1:i}"
done]]
  ),
}
