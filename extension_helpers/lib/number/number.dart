import 'dart:math';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

extension NullDouble on double? {
  double get def => () {
        return this ?? 0.0;
      }();
}

extension AritimeticExt<T extends num> on T {
  num minus(num val) {
    return this - val;
  }

  num plus(num val) {
    return this + val;
  }

  num division(num val) {
    return this / val;
  }

  num multiple(num val) {
    return this * val;
  }

  num get square => () {
        return this + this;
      }();
}

extension SizerHelper on num {
  double cl(
    int lowerLimit,
    int upperLimit,
  ) {
    return sp.clamp(lowerLimit, upperLimit).toDouble();
  }

  double cw(
    int lowerLimit,
    int upperLimit,
  ) {
    return w.clamp(lowerLimit, upperLimit).toDouble();
  }

  double ch(
    int lowerLimit,
    int upperLimit,
  ) {
    return h.clamp(lowerLimit, upperLimit).toDouble();
  }

  num minM(num minimum) {
    return min(this, minimum);
  }

  double interpolate({
    required List<num> inputRange,
    required List<num> outputRange,
  }) {
    if (inputRange.length < 2) {
      throw ArgumentError.value(
        inputRange,
        'inputRange',
        'Needs at least two points to interpolate',
      );
    }
    if (inputRange.length != outputRange.length) {
      throw ArgumentError.value(
        outputRange,
        'outputRange',
        'Must have the same number of elements as the key points',
      );
    }
    var p = inputRange.lowerBound(this);
    if (p > inputRange.length - 2) p = inputRange.length - 2;
    var startPosition = inputRange[p];
    var endPosition = inputRange[p + 1];
    var startValue = outputRange[p];
    var endValue = outputRange[p + 1];
    return (this - startPosition) /
        (endPosition - startPosition) *
        (endValue - startValue);
  }
}
