part of 'format.dart';

extension ListExt<T> on List<T> {
  int get size => () {
        return length - 1;
      }();
}
