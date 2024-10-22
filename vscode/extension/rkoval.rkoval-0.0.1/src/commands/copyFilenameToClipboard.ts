import * as vscode from 'vscode';
import * as path from 'path';
import {withSelectionOrWord} from './helpers/selection';

export default async function copyFilenameToClipboard(options: {appendWordUnderCursor: boolean}) {
  const {appendWordUnderCursor} = options;

  await withSelectionOrWord(async (word, selection, document, editBuilder) => {
    const fileName = document.fileName;
    const ext = path.extname(fileName);
    const fileBaseName = path.basename(fileName, ext);

    let clipboardContent = fileBaseName;
    if (appendWordUnderCursor) {
      if (word) {
        clipboardContent += `.${word}`;
      }
    }

    await vscode.env.clipboard.writeText(clipboardContent);
  });
}
