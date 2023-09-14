return {
  parse(
    'main',
    [[(async function main() {
  $0
})().catch(error => {
  process.exitCode = 1;
  console.error(error);
});]]
  ),
}
