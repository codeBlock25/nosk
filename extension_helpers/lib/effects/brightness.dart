part of 'effects.dart';

extension BrightnessExt on Brightness {
  /// Keep the applied brightness is device is android and else converts it to it opposite
  Brightness get ifAndroid => () {
        return GetPlatform.isAndroid
            ? this
            : this == Brightness.dark
                ? Brightness.light
                : Brightness.dark;
      }();

  /// Keep the applied brightness is device is iOS and else converts it to it opposite
  Brightness get ifIOS => () {
        return GetPlatform.isIOS
            ? this
            : this == Brightness.dark
                ? Brightness.light
                : Brightness.dark;
      }();

  /// Returns the opposite brightness
  Brightness get ops => () {
        return this == Brightness.light ? Brightness.dark : this;
      }();
}
