return {
    parse('classi', [[
  class ${1:ClassName}(${2:object}):
  """${3:docstring for $1.}"""
  def __init__(self, ${4:arg}):
    ${5:super($1, self).__init__()}
    self.arg = arg
    $0
  ]]),
  }