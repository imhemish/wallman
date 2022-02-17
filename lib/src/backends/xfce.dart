import '../utils.dart';
import '../generic_backend.dart';

class XfceBackend extends Backend {
  @override
  String get name => "XfceBackend";

  Future<List<String>> _getProps() async {
    var desktop = await exec("xfconf-query --channel xfce4-desktop --list");
    var lastImagesProperties = desktop
        .split("\n")
        .where((element) => element.contains("last-image"))
        .toList();
    return lastImagesProperties;
  }

  @override
  Future<List<String>> getWall() async {
    Future<String> getBackgroundFromProperty(String property) async {
      return await exec(
          "xfconf-query --channel xfce4-desktop --property $property");
    }

    List<String> backs = [];

    var props = await _getProps();
    for (var property in props) {
      backs.add(await getBackgroundFromProperty(property));
    }

    // Return only unique backgrounds.
    return backs.toSet().toList();
  }

  @override
  Future<void> setWall(String wallPath) async {
    Future<void> setBackgroundFromProperty(String property, String bg) async {
      await exec(
          "xfconf-query --channel xfce4-desktop --property $property --set $bg");
    }

    var props = await _getProps();
    for (var property in props) {
      await setBackgroundFromProperty(property, wallPath);
    }
  }
}
