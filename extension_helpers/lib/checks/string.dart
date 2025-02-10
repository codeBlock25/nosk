part of 'checks.dart';

extension StringCheckExt on String? {
  bool get isNothing => () {
        if (this == null) {
          return true;
        }
        if (this == '') {
          return true;
        }
        return false;
      }();
}
