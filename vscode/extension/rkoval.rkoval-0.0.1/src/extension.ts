import {registerCommands} from './registerCommands';

import * as vscode from 'vscode';

export async function activate(context: vscode.ExtensionContext) {
  console.log('rkoval extension activated');
  await registerCommands(context);
}

export function deactivate() {}
