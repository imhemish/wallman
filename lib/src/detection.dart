import 'dart:io';
import './backends/backends.dart';
import './generic_backend.dart';

/// Automatically detect which backend to use and return Backend inherited object
Backend getBackend() {
  var xdgSessionDesktop =
      Platform.environment["XDG_SESION_DESKTOP"].toString().toLowerCase();
  var xdgCurrentDesktop =
      Platform.environment["XDG_CURRENT_DESKTOP"].toString().toLowerCase();
  var xdgSessionType =
      Platform.environment["XDG_SESSION_TYPE"].toString().toLowerCase();
  if (xdgCurrentDesktop.contains("gnome")) {
    return GnomeBackend();
  } else if (xdgCurrentDesktop.contains("budgie")) {
    return GnomeBackend(); // Budgie as of now uses same technologies as GNOME.
  } else if (xdgCurrentDesktop.contains("mate")) {
    return MateBackend();
  } else if (xdgCurrentDesktop.contains("cinnamon")) {
    return CinnamonBackend();
  } else if (xdgCurrentDesktop.contains("xfce")) {
    return XfceBackend();
  } else if (xdgCurrentDesktop.contains("sway")) {
    return WlrootsBackend();
  } else if (xdgSessionDesktop.contains("gnome")) {
    return GnomeBackend();
  } else if (xdgSessionDesktop.contains("budgie")) {
    return GnomeBackend(); // Budgie as of now uses same technologies as GNOME.
  } else if (xdgSessionDesktop.contains("mate")) {
    return MateBackend();
  } else if (xdgSessionDesktop.contains("cinnamon")) {
    return CinnamonBackend();
  } else if (xdgSessionDesktop.contains("xfce")) {
    return XfceBackend();
  } else if (xdgSessionDesktop.contains("sway")) {
    return WlrootsBackend();
  } else {
    if (xdgSessionType.contains("x11")) {
      return NitrogenBackend();
    } else if (xdgSessionType.contains("wayland")) {
      // Default to swaybg for non-GNOME wayland environments
      return WlrootsBackend();
    } else if (xdgSessionType.contains("tty")) {
      // Happens when you launch a standalone window manager, which does not set XDG_SESSION_TYPE env var
      return NitrogenBackend();
    } else {
      // Platform not supported
      return Backend();
    }
  }
}
