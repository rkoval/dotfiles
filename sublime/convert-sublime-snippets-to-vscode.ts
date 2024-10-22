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
  console.log(xmlJson);
  const prefix = xmlJson.snippet.tabTrigger[0];
  const scope = xmlJson.snippet.scope?.[0]
    .split(",")
    .map((scope: string) => {
      console.log("scope", scope);
      const mapped = sublimeScopeToVsCodeScope[scope.trim()];
      console.log(mapped);
      assert(mapped, `mapped is required`);
      return mapped;
    })
    .join(",");
  const description = xmlJson.snippet.description?.[0];
  const snippet: any = {
    [prefix]: {
      prefix,
      body: xmlJson.snippet.content[0].split("\n").slice(1, -1), // trim leading and trailing newlines because they are not needed
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
