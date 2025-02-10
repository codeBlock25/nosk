part of 'sizing.dart';

extension BlankSpaceExtension on num {
  Widget get hSpacer => () {
        return SizedBox(
          height: toDouble(),
        );
      }();

  Widget get wSpacer => () {
        return SizedBox(
          width: toDouble(),
        );
      }();

  Widget get spacer => () {
        return SizedBox(
          width: toDouble(),
          height: toDouble(),
        );
      }();

  Size get sized => () {
        return Size(toDouble(), toDouble());
      }();
}
