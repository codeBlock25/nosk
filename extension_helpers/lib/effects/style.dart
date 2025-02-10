part of 'effects.dart';

extension MaterialSylePropertyExt<T> on T {
  WidgetStatePropertyAll<T> get all => () {
        return WidgetStatePropertyAll(this);
      }();
}
