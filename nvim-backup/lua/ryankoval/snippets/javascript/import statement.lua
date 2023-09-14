return {
  parse('import statement', [[
import { $0 } from "${1:module}";
]]),
}