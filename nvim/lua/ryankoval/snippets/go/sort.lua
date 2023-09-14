return {
    parse('sort', [[
  type ${1:SortBy} []${2:Type}

func (a $1) Len() int           { return len(a) }
func (a $1) Swap(i, j int)      { a[i], a[j] = a[j], a[i] }
func (a $1) Less(i, j int) bool { ${3:return a[i] < a[j]} }
  ]]),
  }