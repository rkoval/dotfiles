return {
  parse(
    'usecallback',
    [[const ${1:fn} = useCallback(function ${1:fn}(${2:args}) {
  $0
}, []);]]
  ),
}
