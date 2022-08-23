return {
  parse(
    'newpromise',
    [[new Promise((resolve, reject) => {
	$1
});
]]
  ),
}
