if not pcall(require, 'cmp') then
  return
end

local ls = require('luasnip')

ls.add_snippets("javascript", {
  -- ls.parser.parse_snippet('ibb', "import Bluebird from 'bluebird';"),
  -- ls.parser.parse_snippet('ir', "import React from 'react';"),
  -- ls.parser.parse_snippet('id', "import { ${1:} } from '${0:}';"),
  -- ls.parser.parse_snippet('ii', "import ${1:} from '${0:}';"),
  -- ls.parser.parse_snippet('cl', 'console.log(${0:});'),
  ls.parser.parse_snippet('jsonstringify', 'JSON.stringify(${0:}, null, 2)'),
  ls.parser.parse_snippet('utilinspect', 'util.inspect(${1:data}, false, null, true)'),
  -- ls.parser.parse_snippet('rsa', 'Record<string, any>'),
  -- ls.parser.parse_snippet('uS', 'const [${0:}] = useState();'),
  -- ls.parser.parse_snippet('uR', 'const [${0:}, dispatch] = useReducer();'),
  -- ls.parser.parse_snippet('uE', 'useEffect(() => {\n\t${0:}\n}, []);'),
  -- ls.parser.parse_snippet('uLE', 'useLayoutEffect(() => {\n\t${0:}\n}, []);'),
  -- ls.parser.parse_snippet('uC', 'useCallback(() => {\n\t${0:}\n}, []);'),
  -- ls.parser.parse_snippet('uM', 'useMemo(() => {\n\t${0:}\n}, []);'),
  ls.parser.parse_snippet('newpromise', 'new Promise((resolve, reject) => {\n\t${0:}\n});'),
  -- ls.parser.parse_snippet('a', '(${1:}) => {\n\t${0:}\n}'),
  -- ls.parser.parse_snippet('c', 'const ${0:}'),
  -- ls.parser.parse_snippet('cn', 'className="${0:}"'),
  -- ls.parser.parse_snippet('cnn', 'className={`\n\t${0:}\n`}'),
  -- ls.parser.parse_snippet('fn', 'function ${1:}(${2:}) {\n\t${0:}\n}'),
})

ls.filetype_extend('typescript', { 'javascript' })
ls.filetype_extend('typescriptreact', { 'javascript' })