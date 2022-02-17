import 'package:wallman/wallman.dart';
import 'dart:io';

void main() async {
  // Auto detect backend and store its instance in wall identifier
  var wall = getBackend();

  // Prints the list of currently set wallpaper(s).
  print(await wall.getWall());

  // Prints the name of backend in use
  print("The backend in use is: ${wall.name}");

  // Set wallpaper to /usr/share/backgrounds/xfce/xfce-teal.jpg
  await wall.setWall("/usr/share/backgrounds/xfce/xfce-teal.jpg");

  exit(1);
}
