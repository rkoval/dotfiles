import * as vscode from 'vscode';
import * as path from 'path';
import {withSelectionOrWord} from './helpers/selection';

export default async function openFileFromCursor() {
  await withSelectionOrWord(async (word, selection, document, editBuilder) => {
    await vscode.commands.executeCommand('workbench.action.quickOpen', word);
  });
}
