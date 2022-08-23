return {
  parse(
    'nc',
    [[export default class ${1:${TM_FILENAME/(.+)\..+|.*/$1/:name}} {
  constructor() {
    super();
  }}
}
]]
  ),
}
