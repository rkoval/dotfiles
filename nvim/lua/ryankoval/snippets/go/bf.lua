return {
    parse('bf', [[
  func Benchmark$1(b *testing.B) {
  for ${2:i} := 0; ${2:i} < b.N; ${2:i}++ {
    $0
  }
}
  ]]),
  }