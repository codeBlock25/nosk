part of  'effects.dart';


extension FocusExt on BuildContext {
  FocusScopeNode get focus => () {
    return FocusScope.of(this);
  }();
}
