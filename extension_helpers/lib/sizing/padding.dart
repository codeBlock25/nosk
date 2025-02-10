part of 'sizing.dart';

extension PaddingSizingDouble on num {
  EdgeInsets get pdAll => () {
        return EdgeInsets.all(toDouble());
      }();

  EdgeInsets get pdX => () {
        return EdgeInsets.symmetric(horizontal: toDouble());
      }();

  EdgeInsets get pdY => () {
        return EdgeInsets.symmetric(vertical: toDouble());
      }();

  EdgeInsets pdXY(num padding) {
    return EdgeInsets.symmetric(horizontal: toDouble(), vertical: toDouble());
  }

  EdgeInsets pdYX(num padding) {
    return EdgeInsets.symmetric(vertical: toDouble(), horizontal: toDouble());
  }

  EdgeInsets get pdL => () {
        return EdgeInsets.only(left: toDouble());
      }();

  EdgeInsets get pdR => () {
        return EdgeInsets.only(right: toDouble());
      }();

  EdgeInsets get pdB => () {
        return EdgeInsets.only(bottom: toDouble());
      }();

  EdgeInsets get pdT => () {
        return EdgeInsets.only(top: toDouble());
      }();

  EdgeInsets pd(double right, double bottom, double left) {
    return EdgeInsets.fromLTRB(left, toDouble(), right, bottom);
  }
}
