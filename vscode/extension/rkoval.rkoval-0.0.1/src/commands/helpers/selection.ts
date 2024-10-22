import * as vscode from 'vscode';

export async function withSelectionOrWord(
  fn: (
    word: string,
    selection: vscode.Selection,
    document: vscode.TextDocument,
    editBuilder: vscode.TextEditorEdit,
  ) => void,
) {
  const editor = vscode.window.activeTextEditor;
  if (!editor) {
    return;
  }

  const document = editor.document;
  const selections = editor.selections;

  editor.edit((editBuilder) => {
    selections.forEach((selection) => {
      const word = getSelectionOrWord(document, selection);

      if (word) {
        fn(word, selection, document, editBuilder);
      } else {
        vscode.window.showInformationMessage('No word found under cursor or in selection.');
      }
    });
  });
}

export function getSelectionOrWord(document: vscode.TextDocument, selection: vscode.Selection) {
  let word: string | undefined;
  if (selection.isEmpty) {
    const cursorWordRange = document.getWordRangeAtPosition(selection.active);
    if (cursorWordRange) {
      word = document.getText(cursorWordRange);
    }
  } else {
    word = document.getText(selection);
  }
  return word;
}
