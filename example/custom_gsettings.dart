import 'package:wallman/wallman.dart';

void main() async {
  GsettingsBackend wall = GsettingsBackend();

  wall.gsettingsInterface = "org.blahdesktop.background";
  // This is just a dummy example, you have to give your respective desktop's interface here.
  // Example, for gnome we put "org.gnome.desktop.background"
  // for mate we put "org.mate.background"

  wall.gsettingPictureKey = "picture-path"; // Again dummy example
  // Example, for gnome and cinnamon we put "picture-uri"
  // for mate, we put "picture-filename"

  wall.usesUri = false;
  // If the key stores filepath in "file:///path/to/file" format, mark true, else mark it false
  // example, we put false for mate and true for gnome and cinnamon

  // Initialise gsettings interface through provided settings
  wall.initialise();

  print(await wall
      .getWall()); // Returns list of background in use, in this case this list would be singleton

  // Similarly wall.setWall(wallPath) can be used.
}
