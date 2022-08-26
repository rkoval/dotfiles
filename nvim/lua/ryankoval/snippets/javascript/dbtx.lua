return {
  parse(
    'dbtx',
    [[const ${2:result} = await db.tx(async (transaction) => {
  return ${1:transaction.one(sql)};
});]]
  ),
}
