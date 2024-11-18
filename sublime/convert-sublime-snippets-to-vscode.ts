#!/usr/bin/env bun
import { $ } from "bun";
import { readdir } from "node:fs/promises";
import fs from "node:fs/promises";
import assert from "node:assert";
import path from "node:path";
import xml2js from "xml2js";

const sublimeScopeToVsCodeScope = {
  "source.js": "javascript",
  "source.jsx": "javascriptreact",
  "source.ts": "typescript",
  "source.tsx": "typescriptreact",
  "source.sql": "sql",
  "source.shell": "shellscript",
  "source.css": "css",
  "source.scss": "scss",
  "source.html": "html",
  "source.python": "python",
};

await $`bun install`;
const snippetsDir = `${process.env.GIT_ROOT}/sublime/snippets`;
const outDir = `${process.env.GIT_ROOT}/vscode/snippets`;
for (const file of await readdir(snippetsDir, { recursive: true })) {
  if (!file.endsWith(".sublime-snippet")) {
    continue;
  }
  console.log(`reading ${snippetsDir}/${file} ...`);
  const rawXml = await fs.readFile(`${snippetsDir}/${file}`, "utf8");
  const xmlJson = await xml2js.parseStringPromise(rawXml);
  const prefix = xmlJson.snippet.tabTrigger[0];
  const scope = xmlJson.snippet.scope?.[0]
    .split(",")
    .map((scope: string) => {
      const mapped = sublimeScopeToVsCodeScope[scope.trim()];
      assert(mapped, `mapped is required`);
      return mapped;
    })
    .join(",");
  const description = xmlJson.snippet.description?.[0];
  let body = xmlJson.snippet.content[0].split("\n");
  body = body.slice(
    body[0] === "" ? 1 : 0,
    body[body.length - 1] === "" ? -1 : undefined
  ); // trim leading and trailing newlines if they are not needed
  body = body.map((line: string) => {
    // sublime's filename syntax is different from vscode's
    return line
      .replaceAll("${TM_FILENAME/(.+)..+|.*/$1/:name}", "${TM_FILENAME_BASE}")
      .replaceAll(
        "${TM_FILENAME/(.+)\\..+|.*/$1/:name}",
        "${TM_FILENAME_BASE}"
      );
  });
  const snippet: any = {
    [prefix]: {
      prefix,
      body,
    },
  };

  let filePrefix = "global";
  if (scope) {
    snippet[prefix].scope = scope;
    filePrefix = scope.split(",")[0];
  }

  if (description) {
    snippet[prefix].description = description;
  }

  const snippetFile = `${outDir}/${filePrefix}-${prefix}.code-snippets`;
  console.log(`writing ${snippetFile} ...`);
  await fs.writeFile(snippetFile, JSON.stringify(snippet, null, 2));
}
console.log(`running prettier on ${outDir} ...`);
await $`prettier --write "${outDir}"`;
