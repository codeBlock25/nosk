part of 'themes.dart';


class AppThemePalette {
  const AppThemePalette({
    required this.primaryColor,
    required this.primaryColorDark,
    required this.primaryColorLight,
    required this.background,
    required this.backgroundDark,
    required this.error,
    required this.errorContainer,
    required this.secondary,
    required this.tertiary,
    required this.textColorLight,
    required this.textColorDark,
  });

  final Color primaryColor;
  final Color primaryColorDark;
  final Color primaryColorLight;
  final Color background;
  final Color backgroundDark;
  final Color error;
  final Color errorContainer;
  final Color secondary;
  final Color tertiary;
  final Color textColorLight;
  final Color textColorDark;

  AppThemePalette copyWith({
    Color? primaryColor,
    Color? primaryColorDark,
    Color? primaryColorLight,
    Color? background,
    Color? backgroundDark,
    Color? error,
    Color? errorContainer,
    Color? secondary,
    Color? tertiary,
    Color? textColorLight,
    Color? textColorDark,
  }) {
    return AppThemePalette(
      primaryColor: primaryColor ?? this.primaryColor,
      primaryColorDark: primaryColorDark ?? this.primaryColorDark,
      primaryColorLight: primaryColorLight ?? this.primaryColorLight,
      background: background ?? this.background,
      backgroundDark: backgroundDark ?? this.backgroundDark,
      error: error ?? this.error,
      errorContainer: errorContainer ?? this.errorContainer,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      textColorLight: textColorLight ?? this.textColorLight,
      textColorDark: textColorDark ?? this.textColorDark,
    );
  }

  @override
  String toString() {
    return 'AppThemePalette (\n'
        '\tprimaryColor: $primaryColor\n'
        '\tprimaryColorDark: $primaryColorDark\n'
        '\tprimaryColorLight: $primaryColorLight\n'
        '\tbackground: $background\n'
        '\tbackgroundDark: $backgroundDark\n'
        '\terror: $error\n'
        '\terrorContainer: $errorContainer\n'
        '\tsecondary: $secondary\n'
        '\ttertiary: $tertiary\n'
        '\ttextColorLight: $textColorLight\n'
        '\ttextColorDark: $textColorDark\n'
        ')\n';
  }
}