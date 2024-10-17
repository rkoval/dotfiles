import {registerCommands} from './commands/registerCommands';

import * as vscode from 'vscode';

export function activate(context: vscode.ExtensionContext) {
  console.log('Congratulations, your extension "rkoval" is now active!');

  const disposable = vscode.commands.registerCommand('rkoval.helloWorld', () => {
    vscode.window.showInformationMessage('Hello World from rkoval!!!!!!!!!!!!!!');
  });

  context.subscriptions.push(disposable);
  // registerCommands(context);
}

export function deactivate() {}
