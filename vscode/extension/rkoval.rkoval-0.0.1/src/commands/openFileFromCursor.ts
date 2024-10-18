import * as vscode from 'vscode';
import * as path from 'path';

export async function openFileFromCursor() {
  const editor = vscode.window.activeTextEditor;

  if (!editor) {
    vscode.window.showErrorMessage('No active editor found.');
    return;
  }

  const document = editor.document;
  const position = editor.selection.active;
  const wordRange = document.getWordRangeAtPosition(position);

  if (!wordRange) {
    vscode.window.showErrorMessage('No text found under cursor.');
    return;
  }

  const word = document.getText(wordRange);
  await vscode.commands.executeCommand('workbench.action.quickOpen', word);
}
