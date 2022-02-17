// To write custom backends, make a new file,
// extend Backend class with name as <...>Backend
// and override getWall and setWall methods;
// and "name" property
// setWall should be of Future<void> type and
// getWall should be of Future<List<String>> type

export './backman.dart';

// Contains the gsettings, gnome, mate, cinnamon backends
export './gsettings.dart';

export './nitrogen.dart';
export './wlroots.dart';
export './xfce.dart';

/// Returns the list of names of backends available
List<String> availableBackends = [
  "BackmanBackend",
  "GsettingsBackend",
  "GnomeBackend",
  "MateBackend",
  "CinnamonBackend",
  "NitrogenBackend",
  "XfceBackend",
  "WlrootsBackend"
];
