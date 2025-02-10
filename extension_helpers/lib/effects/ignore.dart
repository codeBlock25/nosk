part of 'effects.dart';

extension IgnoreEx on Widget {
  Widget get fullyIgnore => () {
        return Opacity(
          opacity: 0,
          child: IgnorePointer(
            child: this,
          ),
        );
      }();

  Widget conditionalIgnore({bool condition = true}) => () {
        if (!condition) {
          return this;
        }
        return Opacity(
          opacity: 0,
          child: IgnorePointer(
            child: this,
          ),
        );
      }();

  Widget get ignore => () {
        return IgnorePointer(
          child: this,
        );
      }();
}
