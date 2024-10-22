import * as vscode from 'vscode';
import * as path from 'path';
import {withSelectionOrWord} from './helpers/selection';

function find(text: string) {
  return vscode.commands.executeCommand('workbench.action.findInFiles', {
    query: text,
    isRegex: false,
    isCaseSensitive: true,
    matchWholeWord: false,
    triggerSearch: true,
    filesToInclude: '',
    filesToExclude: '',
  });
}

export default async function findAllUnderCursor(
  options: {includeFile?: boolean; onlyFile?: boolean} = {},
) {
  const {includeFile = false, onlyFile = false} = options;

  const editor = vscode.window.activeTextEditor;
  if (!editor) {
    return;
  }
  const document = editor.document;
  const fileName = document.fileName;
  const ext = path.extname(fileName);
  const fileBaseName = path.basename(fileName, ext);

  if (onlyFile) {
    find(fileBaseName);
  } else {
    await withSelectionOrWord(async (word) => {
      const text = includeFile ? `${fileBaseName}.${word}` : word;
      await find(text);
    });
  }
}

export function deactivate() {}
