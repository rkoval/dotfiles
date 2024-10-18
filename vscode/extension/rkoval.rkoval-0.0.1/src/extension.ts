import {registerCommands} from './commands/registerCommands';

import * as vscode from 'vscode';

export function activate(context: vscode.ExtensionContext) {
  console.log('rkoval extension activated');
  registerCommands(context);
}

export function deactivate() {}
