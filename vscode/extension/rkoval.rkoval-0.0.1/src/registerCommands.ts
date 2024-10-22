import * as vscode from 'vscode';
import fs from 'node:fs/promises';
import path from 'node:path';

export async function registerCommands(context: vscode.ExtensionContext) {
  const currentDir = path.dirname(__filename);
  const commandsDir = path.join(currentDir, 'commands');
  const commandFiles = await fs.readdir(commandsDir);
  for (const commandFile of commandFiles) {
    if (!commandFile.endsWith('.ts') && !commandFile.endsWith('.js')) {
      continue;
    }

    const commandName = commandFile.replace(/.(ts|js)/, '');
    const module = await import(`${commandsDir}/${commandFile}`);
    const fullyQualifiedCommandName = `rkoval.${commandName}`;
    context.subscriptions.push(
      vscode.commands.registerCommand(fullyQualifiedCommandName, module.default),
    );
  }
}
