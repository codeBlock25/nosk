part of 'format.dart';


extension StringExt on String {
  String frontTag(String tag) {
    return "$tag$this";
  }
  String backTag(String tag) {
    return "$this$tag";
  }
}