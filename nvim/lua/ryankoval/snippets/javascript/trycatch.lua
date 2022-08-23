return {
  parse(
    'trycatch',
    [[try {
  $0
} catch (${1:error}) {
  
}]]
  ),
}
