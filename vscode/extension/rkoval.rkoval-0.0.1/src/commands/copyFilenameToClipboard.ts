import * as vscode from 'vscode';
import * as path from 'path';
import {withSelectionOrWord} from './helpers/selection';

export default async function copyFilenameToClipboard(options: {appendWordUnderCursor: boolean}) {
  const editor = vscode.window.activeTextEditor;
  if (!editor) {
    return;
  }

  const fileName = editor.document.fileName;
  const ext = path.extname(fileName);
  const fileBaseName = path.basename(fileName, ext);

  const {appendWordUnderCursor} = options;
  let clipboardContent = fileBaseName;
  if (appendWordUnderCursor) {
    await withSelectionOrWord(async (word, selection, document, editBuilder) => {
      if (word) {
        clipboardContent += `.${word}`;
      }

      await vscode.env.clipboard.writeText(clipboardContent);
    });
  } else {
    await vscode.env.clipboard.writeText(clipboardContent);
  }
}
