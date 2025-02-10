part of 'effects.dart';

extension BuildContextExt on BuildContext {
  ResponsiveBreakpointsData get breakpoint => () {
        return ResponsiveBreakpoints.of(this);
      }();
}
