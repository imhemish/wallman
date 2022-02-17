A Dart library for linux platforms to get and set backgrounds, which supports multiple desktop environments and window managers

## Features

- Can automatically sense desktop environments and return the respective backend
- Get list of wallpaper(s) set
- Set a wallpaper
- Provides a way to write your own custom backend and add it to lib/src/backends directory

## Getting started

You just require a working GUI linux system, satisfy all the dependencies and then see the usage.

## Usage
If you dont wanna read any documentation and just want to use this package, just headup to example/example.dart and just copy-paste required code from there. Otherwise, you can read the following documentation.

First, import the wallman library.
```dart
import 'package:wallman/wallman.dart';
```

- Auto detect backend (this is what you would generally want to do):
```dart
var wall = getBackend();
```
- Specifically use a backend (if you want it to use it for specific desktop/WM):
```dart
var wall = GnomeBackend();
```

The wallman library exposes a variable (property) called "availableBackends" which returns list of names of available backends.

The Backend object exposes a 'name' property of String type which gives the name of backend currently in use.

```dart
print(wall.name)
```

You can use getWall and setWall functions as given:

```dart
print(await wall.getWall());

wall.setWall("/usr/share/backgrounds/xfce/xfce-teal.jpg");
```

The getWall function returns a ```Future<List<String>>```.

The setWall function is of ```Future<void>``` type.

## Additional information

- The library code during execution would return empty values if any error occurs and would not fail, but would write warnings, information to STDERR. So, if you are using it in some program, be sure to discard STDERR or redirect it to /dev/null.
- Wlroots backend requires python3 to be present in system and callable through "python3" command
- To create your own custom backend, see documentation or source of Backend class (present in lib/src/generic_backend.dart). To see examples of backends and analyse how they are created, analyse the code of lib/src/backends. The simplest to understand would be backman.dart. Understanding gsettings.dart would help a lot.
- If your custom backend would anyhow utilise gsettings, better check gsettings.dart and analyse the implementation of MateBackend in lib/src/backends/gsettings.dart and implement your own taking it as example, instead of creating your backend from scratch. You can also use gsettings without implementing new backend class, you can just use Gsettings class and set interface, key, and value type in your program itself in which you are gonna use this library; for doing that see example/custom_gsettings.dart
- Pull requests adding new backends are welcome.
- Any general pull requests are also welcome.
- Pull requests are accepted at [https://github.com/securearth/wallman](https://github.com/securearth/wallman)

## Todo:
 - warnings
 - wlroots null values
 - Check if the user has set solid color instead of picture and return the colour