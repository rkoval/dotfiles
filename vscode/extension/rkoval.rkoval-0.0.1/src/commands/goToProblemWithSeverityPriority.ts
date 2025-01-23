import * as vscode from 'vscode';

export default async function goToProblemWithSeverityPriority(options: {isPrev?: boolean} = {}) {
  const {isPrev = false} = options;
  const editor = vscode.window.activeTextEditor;
  if (!editor) {
    vscode.window.showInformationMessage('No active text editor.');
    return;
  }

  const uri = editor.document.uri;
  // Get all diagnostics for the current file
  const allDiagnostics = vscode.languages.getDiagnostics(uri);

  if (allDiagnostics.length === 0) {
    vscode.window.showInformationMessage('No problems in this file.');
    return;
  }

  // Separate by severity
  const errors: vscode.Diagnostic[] = [];
  const warnings: vscode.Diagnostic[] = [];
  const infos: vscode.Diagnostic[] = [];
  const hints: vscode.Diagnostic[] = [];

  for (const diag of allDiagnostics) {
    switch (diag.severity) {
      case vscode.DiagnosticSeverity.Error:
        errors.push(diag);
        break;
      case vscode.DiagnosticSeverity.Warning:
        warnings.push(diag);
        break;
      case vscode.DiagnosticSeverity.Information:
        infos.push(diag);
        break;
      case vscode.DiagnosticSeverity.Hint:
        hints.push(diag);
        break;
    }
  }

  // Pick the highest group that is non-empty:
  // Errors > Warnings > Information > Hints
  let chosenGroup: vscode.Diagnostic[] | undefined;
  if (errors.length > 0) {
    chosenGroup = errors;
  } else if (warnings.length > 0) {
    chosenGroup = warnings;
  } else if (infos.length > 0) {
    chosenGroup = infos;
  } else if (hints.length > 0) {
    chosenGroup = hints;
  }

  if (!chosenGroup || chosenGroup.length === 0) {
    vscode.window.showInformationMessage('No problems at or above the chosen severity.');
    return;
  }

  // Sort diagnostics by range.start
  chosenGroup.sort((a, b) => a.range.start.compareTo(b.range.start));

  const currentPos = editor.selection.active;

  let targetIndex: number;
  if (!isPrev) {
    // Next problem: find the first diagnostic *after* current cursor
    targetIndex = chosenGroup.findIndex((diag) => diag.range.start.isAfter(currentPos));
    // If none is after, wrap to the first
    if (targetIndex === -1) {
      targetIndex = 0;
    }
  } else {
    // Previous problem: find the last diagnostic *before* current cursor
    // We'll search in reverse
    targetIndex = -1;
    for (let i = chosenGroup.length - 1; i >= 0; i--) {
      if (chosenGroup[i].range.start.isBefore(currentPos)) {
        targetIndex = i;
        break;
      }
    }
    // If none is before, wrap to the last
    if (targetIndex === -1) {
      targetIndex = chosenGroup.length - 1;
    }
  }

  const targetDiag = chosenGroup[targetIndex];

  let positionBeforeProblem: vscode.Position = targetDiag.range.start;
  if (chosenGroup.length === 1) {
    // peek command doesn't seem to work to show problems tooltip, and there's weird behavior if there's just one error left in that it'll ignore the current error,
    // so just move the cursor to right next to the problem, then invoke Go To Next Problem
    if (targetDiag.range.start.character <= 0) {
      positionBeforeProblem = new vscode.Position(targetDiag.range.start.line + 1, 0); // not sure how to get end of previous line, so just get beginning of following
    } else {
      positionBeforeProblem = new vscode.Position(
        targetDiag.range.start.line,
        targetDiag.range.start.character - 1,
      );
    }
  }
  const newSelection = new vscode.Selection(positionBeforeProblem, positionBeforeProblem);
  editor.selection = newSelection;
  editor.revealRange(targetDiag.range, vscode.TextEditorRevealType.InCenter);

  // await vscode.commands.executeCommand('editor.action.marker.peek');
  await vscode.commands.executeCommand('editor.action.marker.next');
}
