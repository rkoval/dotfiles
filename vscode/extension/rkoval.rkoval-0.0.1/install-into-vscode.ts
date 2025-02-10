#!/usr/bin/env bun
import {$} from 'bun';
import fs from 'node:fs/promises';
import path from 'node:path';
import util from 'util';
console.log(util.styleText('yellow', 'make sure you have run `link.sh` in dotfiles root!'));

const commandsDir = './src/commands';
const commandFiles = await fs.readdir(commandsDir);
const packageJsonRaw = await fs.readFile('./package.json', 'utf8');
const packageJson = JSON.parse(packageJsonRaw);
packageJson.contributes.commands = [];
for (const commandFile of commandFiles) {
  const filePath = path.join(commandsDir, commandFile);
  const stats = await fs.stat(filePath);
  if (stats.isDirectory()) {
    continue;
  }
  const commandName = commandFile.replace('.ts', '');
  packageJson.contributes.commands.push({
    command: `rkoval.${commandName}`,
    title: commandName,
    category: 'rkoval',
  });
}
await fs.writeFile('./package.json', JSON.stringify(packageJson, null, 2));
await $`bun install`;
await $`rm -rf out`;
await $`bun run compile`;
await $`vsce package`;
console.log('');
console.log(util.styleText('cyan', 'now copy/pasta this .vsix file into vscode'));
