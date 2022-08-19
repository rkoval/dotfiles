return {
    parse('tm', [[
  func TestMain(m *testing.M) {
  $1

  os.Exit(m.Run())
}
  ]]),
  }