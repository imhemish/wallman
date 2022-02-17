/// Generic backend class which is meant to be overriden to create new and custom backends.
/// To write custom backends, make a new file in lib/src/backends,
/// import generic_backend.dart,
/// extend Backend class with name of class in the format <nameOfBackend>Backend
/// and override getWall and setWall methods;
/// and "name" property.
/// setWall should be of ```Future<void>``` type and
/// getWall should be of ```Future<List<String>>``` type.
class Backend {
  /// Returns the name of backend in use
  String name = "";
  Future<void> setWall(String wallPath) async {}
  Future<List<String>> getWall() async {
    return [""];
  }
}
