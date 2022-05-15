return {
  parse(
    'snippet',
    [[return {
  parse('${TM_FILENAME/(.+)\..+|.*/$1/:name}', '${1:snippet}')
}]]
  ),
}
