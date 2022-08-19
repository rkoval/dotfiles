return {
    parse('case', [[
  case "\$${1:VAR}" in
  ${2:1}) echo 1
  ;;
  ${3:2|3}) echo 2 or 3
  ;;
  *) echo default
  ;;
esac

  ]]),
  }