library;

import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tinycolor2/tinycolor2.dart';

part 'light.dart';

part 'palette.dart';

class AppTheme {
  const AppTheme({
    required this.palette,
  });

  final AppThemePalette palette;

  ThemeData get light => () {
        return _lightTheme(palette);
      }();
}
