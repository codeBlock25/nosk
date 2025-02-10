part of 'effects.dart';

extension RadiusExtension on num {
  BorderRadius get brcAll => () {
        return BorderRadius.all(Radius.circular(toDouble()));
      }();

  BorderRadius get brcCircle => () {
    return BorderRadius.circular(toDouble());
  }();

  Radius get rc => () {
        return Radius.circular(toDouble());
      }();

  Radius re(num? y) {
    return Radius.elliptical(toDouble(), y?.toDouble() ?? toDouble());
  }
}

extension BorderRadiusExtension on Radius {
  BorderRadius get brAll => () {
        return BorderRadius.all(this);
      }();
}
