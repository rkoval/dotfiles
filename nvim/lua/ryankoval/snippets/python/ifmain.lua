return {
    parse('ifmain', [[
  if __name__ == "__main__":
  ${1:main()}$0
  ]]),
  }