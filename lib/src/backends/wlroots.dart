import 'package:args/args.dart';
import '../utils.dart';
import '../generic_backend.dart';

/// Wlroots backend, which uses swaybg.
class WlrootsBackend extends Backend {
  @override
  String get name => "WlrootsBackend";

  Future<List<ArgResults>> _getBGopts() async {
    var parser = ArgParser();
    parser.addOption("color", abbr: "c");
    parser.addOption("image", abbr: "i");
    parser.addOption("mode", abbr: "m");
    parser.addOption("output", abbr: "o");

    var output = await exec("ps aux");
    var processes = output.split("\n");
    var instances = [];
    for (var process in processes) {
      if (process.contains("swaybg")) {
        instances.add(process);
      }
    }
    late String cmdline;
    late ArgResults results;
    List<ArgResults> finale = [];
    for (var instanceVar in instances) {
      cmdline = "swaybg " + instanceVar.split("swaybg")[1].toString().trim();
      results = parser.parse(cmdline.split(" "));
      finale.add(results);
    }
    return finale;
  }

  /// Recognised currently active options in swaybg process and replaces the background image with the one provided.
  @override
  Future<void> setWall(String wallPath) async {
    var results = await _getBGopts();
    await exec("pkill swaybg");
    String cmdline = '';
    if (results.isEmpty) {
      backgroundExec("swaybg -i $wallPath");
    }
    List argsresult = [];
    for (var result in results) {
      argsresult = result.arguments.toList();
      try {
        argsresult.removeAt(argsresult.indexOf("-i") + 1);
        argsresult.remove("-i");
      } catch (e) {}
      try {
        argsresult.removeAt(argsresult.indexOf("--image") + 1);
        argsresult.remove("--image");
      } catch (e) {}
      argsresult.add("-i");
      argsresult.add(wallPath);
      cmdline = ("swaybg ") + argsresult.join(" ");
      print(cmdline);
      backgroundExec(cmdline);
    }
  }

  /// Recognises the currently active swaybg process and extracts background image(s) from it.
  @override
  Future<List<String>> getWall() async {
    List<String> backs = [];
    var res = await _getBGopts();
    List argsArray = [];
    for (var r in res) {
      argsArray = r.arguments.toList();
      for (var arg in argsArray) {
        if (arg == "-i" || arg == "--image") {
          backs.add(argsArray[(argsArray.indexOf(arg) + 1)]);
          break;
        }
      }
    }
    // Return only unique backgrounds
    return backs.toSet().toList();
  }
}
