import * as vscode from "vscode";
import * as path from "path";

export async function openFileFromCursor() {
  const editor = vscode.window.activeTextEditor;

  if (!editor) {
    vscode.window.showErrorMessage("No active editor found.");
    return;
  }

  const document = editor.document;
  const position = editor.selection.active;
  const wordRange = document.getWordRangeAtPosition(position);

  if (!wordRange) {
    vscode.window.showErrorMessage("No text found under cursor.");
    return;
  }

  const word = document.getText(wordRange);

  const workspaceFolders = vscode.workspace.workspaceFolders;

  if (!workspaceFolders) {
    vscode.window.showErrorMessage("No workspace folder open.");
    return;
  }

  const defaultUri = vscode.Uri.file(
    path.join(workspaceFolders[0].uri.fsPath, word)
  );

  const options: vscode.OpenDialogOptions = {
    canSelectMany: false,
    defaultUri: defaultUri,
    openLabel: "Open",
    filters: {
      "All Files": ["*"],
    },
  };

  const fileUri = await vscode.window.showOpenDialog(options);

  if (fileUri && fileUri[0]) {
    const doc = await vscode.workspace.openTextDocument(fileUri[0]);
    await vscode.window.showTextDocument(doc);
  }
}
