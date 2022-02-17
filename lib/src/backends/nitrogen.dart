import '../utils.dart';
import '../generic_backend.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:ini/ini.dart';

class NitrogenBackend extends Backend {
  @override
  String get name => "NitrogenBackend";

  @override
  Future<void> setWall(String wallPath) async {
    await exec("nitrogen --save --set-zoom-fill $wallPath");
  }

  @override
  Future<List<String>> getWall() async {
    List<String> backs = [];
    var home = Platform.environment["HOME"];
    home = home ?? exec("env HOME").toString();
    var file = path.joinAll([
      home,
      ".config",
      "nitrogen",
      "bg-saved.cfg",
    ]);
    var document = await File(file)
        .readAsLines()
        .then((lines) => Config.fromStrings(lines));
    var sections = document.sections().toList();
    String back = '';
    for (var section in sections) {
      back = document.get(section, "file") ?? "";
      backs.add(back);
    }
    bool checkEmpty(element) {
      return (element == "");
    }

    // Remove any empty backgrounds and return unique ones
    return backs.where(checkEmpty).toList().toSet().toList();
  }
}
