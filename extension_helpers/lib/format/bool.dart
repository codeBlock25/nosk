part of 'format.dart';

extension BoolExt on bool {
  bool get isFalse => () {
        return this == false;
      }();

  bool get isTrue => () {
        return this == true;
      }();
}
