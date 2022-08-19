return {
    parse('property', [[
  @property
def ${1:foo}(self):
    """${2:The $1 property.}"""
    ${3:return self._$1}
@${4:$1}.setter
def ${5:$1}(self, value):
    ${6:self._$1} = value
  ]]),
  }