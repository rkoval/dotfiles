import * as vscode from 'vscode';
import {openFileFromCursor} from './openFileFromCursor';

export function registerCommands(context: vscode.ExtensionContext) {
  context.subscriptions.push(
    vscode.commands.registerCommand('extension.openFileFromCursor', openFileFromCursor),
    // Register additional commands here
  );
}
