import '../utils.dart';
import '../generic_backend.dart';

/// Backman wallpaper setter backend;
/// use this only if you are using https://github.com/securearth/backman
class BackmanBackend extends Backend {
  @override
  String get name => "BackmanBackend";

  /// Set the provided wallpaper.
  @override
  Future<void> setWall(String wallPath) async {
    // The backman program can set background by passing the path of image in '-i' arguement.
    await exec("backman -i $wallPath");
  }

  /// Get list of wallpapers being used currently.
  @override
  Future<List<String>> getWall() async {
    // The backman program can return previously set background with the '-p -r' arguements.
    return [await exec("backman -p -r")];
  }
}
