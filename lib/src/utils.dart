import 'dart:io';

/// Executes a process that would eventually stop during runtime and returns its output in string format.
Future<String> exec(String cmd) async {
  var command = cmd.split(" ");
  var process =
      await Process.run(command[0], command.sublist(1), runInShell: true);
  return process.stdout.toString().trim() + process.stderr.toString().trim();
}

/// Executes a process detached so that the process can still continue even if the dart code exits.
/// Requires Python3 to be present in system.
void backgroundExec(String cmd) async {
  print(cmd);
  var cmdList = cmd.split(" ");
  var prs = await Process.run("/usr/bin/setsid", ['-f'] + cmdList,
      runInShell: true, includeParentEnvironment: false);

  // Only added so that editor does not show that variable prs is not used.
  prs.exitCode;
}

void warn(String message) {
  stderr.write("Wallman: " + message + "\n");
}
