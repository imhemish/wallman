import 'package:gsettings/gsettings.dart';
import 'package:dbus/dbus.dart';
import '../generic_backend.dart';

/// Gsettings backend: This can be used to implement custom gsettings backend if your desktop is not GNOME, Mate, Cinnamon, Budgie; these are already provided as backends.
/// You need to override interface and key, see implementation of MateBackend class in lib/src/backends/gsettings to know how to do so.
/// You can also directly use an object instantinated from this class. See example/custom_gsettings.dart to see an example.
class GsettingsBackend extends Backend {
  @override
  String get name => "GsettingsBackend";

  /// Whether the gsettings key supports "file:///path/to/file" format or not.
  bool usesUri = true;

  bool isInitialised = false;
  String wall = "";

  // Can be overriden by extended class, or can be set with setter methods
  String gsettingsInterface = "";
  List<String> gsettingPictureKeys = ["picture-uri", "picture-uri-dark"];

  late GSettings settings;

  void initialise() {
    settings = GSettings(gsettingsInterface);
    isInitialised = true;
  }

  /// Set the provided wallpaper.
  @override
  Future<void> setWall(String wallPath) async {
    if (!isInitialised) {
      initialise();
    }

    for (var gsettingPictureKey in gsettingPictureKeys) {
      if (usesUri) {
        await settings.set(gsettingPictureKey, DBusString("file://" + wallPath));
      } else {
        await settings.set(gsettingPictureKey, DBusString(wallPath));
      }
    }
  }

  /// Get the list of wallpapers being used currently.
  @override
  Future<List<String>> getWall() async {
    if (!isInitialised) {
      initialise();
    }
    if (usesUri) {
      return [
        (await settings.get(gsettingPictureKeys.first))
            .toNative()
            .toString()
            .split("file://")
            .toList()[1]
            .toString()
      ];
    } else {
      return [(await settings.get(gsettingPictureKeys.first)).toNative().toString()];
    }
  }
}

/// GNOME desktop backend
class GnomeBackend extends GsettingsBackend {
  @override
  String get gsettingsInterface => "org.gnome.desktop.background";
  @override
  String get name => "GnomeBackend";
}

/// Cinnamon desktop backend
class CinnamonBackend extends GsettingsBackend {
  @override
  List<String> gsettingPictureKeys = ["picture-uri"];
  @override
  String get gsettingsInterface => "org.cinnamon.desktop.background";
  @override
  String get name => "CinnamonBackend";
}

/// Mate desktop backend
class MateBackend extends GsettingsBackend {
  @override
  String get name => "MateBackend";
  @override
  String get gsettingsInterface => "org.mate.background";
  @override
  List<String> get gsettingPictureKeys => ["picture-filename"];
  @override
  bool get usesUri => false;
}
