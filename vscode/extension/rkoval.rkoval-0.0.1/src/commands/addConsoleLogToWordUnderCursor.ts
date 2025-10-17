import * as vscode from 'vscode';
import {withSelectionOrWord} from './helpers/selection';

export default async function addConsoleLogToWordUnderCursor(options: {stringify?: boolean} = {}) {
  const {stringify} = options;
  await withSelectionOrWord((word, selection, document, editBuilder) => {
    const position = selection.active;
    const line = document.lineAt(position.line);
    const currentIndent = line.firstNonWhitespaceCharacterIndex;
    const indent = line.text.substring(0, currentIndent);

    let extension = document.fileName.split('.').pop()?.toLowerCase();
    let stringToInsert = '';

    if (
      extension === 'py' ||
      extension === 'star' ||
      extension === 'bzl' ||
      extension === 'bazel'
    ) {
      stringToInsert = `${indent}print("🍕 ${word}", ${word})\n`;
    } else if (extension === 'go') {
      stringToInsert = `${indent}log.Printf("🍕 ${word} %#v", ${word})\n`;
    } else {
      // Default to JavaScript/TypeScript
      let logContent = options?.stringify ? `JSON.stringify(${word}, null, 2)` : word;
      stringToInsert = `${indent}console.log('🍕 ${word}', ${logContent});\n`;
    }

    const insertPosition = new vscode.Position(line.lineNumber + 1, 0);
    editBuilder.insert(insertPosition, stringToInsert);
  });
}
