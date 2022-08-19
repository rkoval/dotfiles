#!/usr/bin/env node
const fs = require('fs');

const [filetype] = process.argv.slice(2);
if (!filetype) {
  console.error('usage: ./convert-vscode.js [filetype]');
  process.exit(1);
}

async function init() {
  const rawSnippets = fs.readFileSync(`${filetype}.json`);
  const snippetsJson = JSON.parse(rawSnippets);
  try {
    fs.mkdirSync(filetype, {recursive: true});
  } catch (e) {
    // best effort
  }
  await Promise.all(
    Object.entries(snippetsJson).map(async ([description, config]) => {
      let name = config.prefix
      if (Array.isArray(name)) {
        name = name.join('');
      }
      name = name.replaceAll('/', '').replaceAll('\\', '');

      let body = config.body;
      if (Array.isArray(body)) {
        body = body.join('\n');
      }
      body = body.replaceAll('\t', '  ');
      const rawSnippet = `return {
    parse('${config.prefix}', [[${body.trim()}]]),
  }`;

      const file = `./${filetype}/${name}.lua`;
      console.log(`writing ${file} ...`);
      await fs.promises.writeFile(file, rawSnippet);
    })
  );
}

init().catch((e) => {
  console.error(e);
  process.exit(1);
});

