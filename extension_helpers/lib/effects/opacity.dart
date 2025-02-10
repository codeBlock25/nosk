part of 'effects.dart';

extension OpacityExt on Widget {
  Widget addOpacity(
    double opacity, {
    bool alwaysIncludeSemantics = false,
    Key? key,
  }) {
    return Opacity(
      opacity: opacity,
      alwaysIncludeSemantics: alwaysIncludeSemantics,
      key: key,
      child: this,
    );
  }
}
