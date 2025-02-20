part of './themes.dart';

ThemeData _lightTheme(AppThemePalette palette) {
  return ThemeData(
    colorScheme: ColorScheme.light(
      onPrimary: palette.primaryColor,
      onPrimaryContainer: palette.primaryColor.withValues(alpha: 0.2),
      onError: palette.error,
      onErrorContainer: palette.errorContainer,
      brightness: GetPlatform.isIOS ? Brightness.dark : Brightness.light,
      primary: palette.primaryColor,
      error: palette.error,
      errorContainer: palette.errorContainer,
      secondary: palette.secondary,
      tertiary: palette.tertiary,
    ),
    hoverColor: palette.primaryColor.darken(5).withValues(alpha: 0.2),
    scaffoldBackgroundColor: palette.background,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.grey[900],
      selectionColor: palette.primaryColor.withValues(alpha: 0.5),
      selectionHandleColor: palette.primaryColor,
    ),
    snackBarTheme: SnackBarThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: 10.cl(10, 20).rc.brAll,
      ),
      width: 100.cw(200, 500).minus(15.cl(10, 35).square).toDouble(),
      dismissDirection: DismissDirection.vertical,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      contentTextStyle: TextStyle(
        fontSize: 15.cl(12, 18),
        fontWeight: FontWeight.w400,
        color: palette.textColorDark,
      ),
      behavior: SnackBarBehavior.floating,
    ),
    primaryColor: palette.primaryColor,
    primaryColorDark: palette.primaryColorDark,
    primaryColorLight: palette.primaryColorLight,
    useMaterial3: true,
    tabBarTheme: TabBarTheme(
      overlayColor: palette.primaryColor.withValues(alpha: 0.1).all,
      labelColor: palette.textColorLight,
      unselectedLabelColor: palette.textColorLight.withValues(alpha: 0.8),
      unselectedLabelStyle: TextStyle(
        fontSize: 12.cl(12, 18),
        fontWeight: FontWeight.w400,
        color: palette.textColorLight,
      ),
      labelStyle: TextStyle(
        fontSize: 12.cl(12, 18),
        fontWeight: FontWeight.w600,
        color: palette.textColorLight,
      ),
      tabAlignment: TabAlignment.fill,
      dividerColor: Colors.transparent,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: palette.background,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 16.cl(16, 22),
        fontWeight: FontWeight.w600,
        color: palette.textColorLight,
      ),
      iconTheme: IconThemeData(
        color: palette.textColorLight,
      ),
      actionsIconTheme: IconThemeData(
        color: palette.primaryColorLight,
      ),
      scrolledUnderElevation: 10,
      foregroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: palette.background,
        systemNavigationBarColor: palette.background,
        statusBarBrightness:
            GetPlatform.isIOS ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            GetPlatform.isIOS ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            GetPlatform.isIOS ? Brightness.light : Brightness.dark,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: palette.primaryColor,
      iconTheme: IconThemeData(
        size: 18.cl(16, 28),
      ).all,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      labelTextStyle: TextStyle(
        fontSize: 12.cl(10, 16),
      ).all,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: palette.primaryColor,
      circularTrackColor: palette.primaryColor.withValues(alpha: 0.5),
      refreshBackgroundColor: palette.primaryColor.withValues(alpha: 0.5),
      linearTrackColor: palette.primaryColor.withValues(alpha: 0.5),
      linearMinHeight: 8.cl(6, 12),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor: Colors.transparent.all,
        overlayColor: palette.primaryColor.withValues(alpha: 0.2).all,
        elevation: 2.sp.all,
        foregroundColor: palette.primaryColor.all,
        iconColor: palette.primaryColor.all,
        textStyle: TextStyle(
          fontSize: 15.cl(10, 20),
          fontWeight: FontWeight.w600,
        ).all,
        padding: 10
            .cl(12, 20)
            .pdX
            .copyWith(
              top: 5.cl(5, 14),
              bottom: 5.cl(5, 14),
            )
            .all,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10.cl(10, 25),
          ),
        ).all,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: Colors.transparent.all,
        overlayColor: palette.primaryColor.withValues(alpha: 0.1).all,
        elevation: 2.sp.all,
        foregroundColor: palette.primaryColor.all,
        surfaceTintColor: palette.primaryColor.withValues(alpha: 0.2).all,
        iconColor: palette.primaryColor.all,
        textStyle: TextStyle(
          fontSize: 15.cl(14, 18),
          fontWeight: FontWeight.w600,
        ).all,
        padding: 10
            .cl(12, 20)
            .pdX
            .copyWith(
              top: 5.cl(5, 14),
              bottom: 5.cl(5, 14),
            )
            .all,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            6.cl(5, 16),
          ),
        ).all,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: Colors.transparent.all,
        overlayColor: palette.primaryColor.withValues(alpha: 0.1).all,
        elevation: 2.sp.all,
        foregroundColor: palette.primaryColor.all,
        surfaceTintColor: palette.primaryColor.withValues(alpha: 0.2).all,
        iconColor: palette.primaryColor.all,
        textStyle: TextStyle(
          fontSize: 16.cl(14, 20),
          fontWeight: FontWeight.w600,
        ).all,
        padding: 10
            .cl(12, 20)
            .pdX
            .copyWith(
              top: 5.cl(5, 14),
              bottom: 5.cl(5, 14),
            )
            .all,
        shape: RoundedRectangleBorder(
          borderRadius: 8.cl(8, 17).rc.brAll,
          side: BorderSide(
            color: palette.primaryColor,
            width: 2.cl(2, 4),
          ),
        ).all,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((val) {
          if (val.contains(WidgetState.disabled)) {
            return palette.primaryColor.darken(17);
          }
          if (val.contains(WidgetState.hovered)) {
            return palette.primaryColor.lighten(5);
          }
          if (val.contains(WidgetState.focused) ||
              val.contains(WidgetState.pressed)) {
            return palette.primaryColor.darken(10);
          }
          return palette.primaryColor;
        }),
        overlayColor:
            palette.primaryColor.darken(10).withValues(alpha: 0.2).all,
        elevation: 2.sp.all,
        foregroundColor: Colors.white.all,
        surfaceTintColor: palette.primaryColor.withValues(alpha: 0.2).all,
        iconColor: Colors.white.all,
        textStyle: TextStyle(
          fontSize: 16.cl(14, 20),
          fontWeight: FontWeight.w600,
        ).all,
        padding: 10
            .cl(12, 20)
            .pdX
            .copyWith(
              top: 15.cl(5, 18),
              bottom: 15.cl(5, 18),
            )
            .all,
        shape: RoundedRectangleBorder(
          borderRadius: 8.cl(8, 17).rc.brAll,
        ).all,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.selected) ||
            states.contains(WidgetState.focused)) {
          return palette.primaryColor; // Button is pressed
        }
        return Colors.grey; // Default state
      }),
      trackOutlineColor:
          WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.selected) ||
            states.contains(WidgetState.focused)) {
          return palette.primaryColor; // Button is pressed
        }
        return Colors.grey; // Default state
      }),
      trackColor: palette.primaryColor.lighten(30).all,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: palette.primaryColor.lighten(20),
      foregroundColor: palette.primaryColor.darken(10),
      elevation: 4.cl(4, 10),
      focusColor: palette.primaryColor.lighten(10),
      focusElevation: 7.cl(4, 16),
      hoverColor: palette.primaryColor.lighten(10),
      splashColor: palette.primaryColor.withValues(alpha: 0.3),
      iconSize: 18.cl(20, 40),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 24.cl(24, 36),
        fontWeight: FontWeight.w600,
        color: palette.textColorLight,
      ),
      titleMedium: TextStyle(
        fontSize: 22.cl(22, 32),
        fontWeight: FontWeight.w600,
        color: palette.textColorLight,
      ),
      titleSmall: TextStyle(
        fontSize: 20.cl(20, 28),
        fontWeight: FontWeight.w600,
        color: palette.textColorLight,
      ),
      headlineLarge: TextStyle(
        fontSize: 22.cl(24, 26),
        fontWeight: FontWeight.w600,
        color: palette.textColorLight,
      ),
      headlineMedium: TextStyle(
        fontSize: 18.cl(16, 20),
        fontWeight: FontWeight.w600,
        color: palette.textColorLight,
      ),
      headlineSmall: TextStyle(
        fontSize: 14.cl(14, 16),
        fontWeight: FontWeight.w600,
        color: palette.textColorLight,
      ),
      bodyLarge: TextStyle(
        fontSize: 22.cl(24, 30),
        fontWeight: FontWeight.w400,
        color: palette.textColorLight,
      ),
      bodyMedium: TextStyle(
        fontSize: 18.cl(12, 20),
        fontWeight: FontWeight.w400,
        color: palette.textColorLight,
      ),
      bodySmall: TextStyle(
        fontSize: 14.cl(14, 16),
        fontWeight: FontWeight.w400,
        color: palette.textColorLight,
      ),
      labelLarge: TextStyle(
        fontSize: 22.cl(24, 32),
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 18.cl(12, 22),
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 14.cl(14, 18),
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      textStyle: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.white.withValues(alpha: 0.6),
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: 5.cl(5, 15).rc.brAll,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10.cl(5, 25),
        vertical: 2.cl(2, 20),
      ),
      labelStyle: TextStyle(
        fontSize: 15.cl(14, 18),
        color: palette.primaryColor,
      ),
      hintStyle: TextStyle(
        fontSize: 15.cl(14, 18),
        textBaseline: TextBaseline.alphabetic,
        color: palette.textColorLight.lighten(40),
        fontWeight: FontWeight.normal,
      ),
      prefixIconColor: palette.primaryColor,
      suffixIconColor: palette.primaryColor.withValues(alpha: 0.7),
      hoverColor: palette.primaryColor.withValues(alpha: 0.05),
      errorBorder: OutlineInputBorder(
        borderRadius: 8.cl(8, 17).rc.brAll,
        borderSide: BorderSide(
          width: 2.sp,
          color: palette.error,
        ),
      ),
      errorMaxLines: 2,
      focusColor: palette.primaryColor,
      fillColor: Colors.transparent,
      iconColor: Colors.grey[900],
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: 8.cl(8, 17).rc.brAll,
        borderSide: BorderSide(
          width: 2.sp,
          color: Colors.grey[600]!,
        ),
      ),
      activeIndicatorBorder: BorderSide(
        width: 2.sp,
        color: palette.primaryColor,
      ),
      outlineBorder: BorderSide(
        width: 2.sp,
        color: Colors.grey[600]!,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: 8.cl(8, 17).rc.brAll,
        borderSide: BorderSide(
          width: 2.sp,
          color: palette.primaryColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: 8.cl(8, 17).rc.brAll,
        borderSide: BorderSide(
          width: 2.sp,
          color: palette.primaryColor.withValues(alpha: 0.4),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: 8.cl(8, 17).rc.brAll,
        borderSide: BorderSide(
          width: 2.sp,
          color: Colors.grey[400]!,
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 0,
      enableFeedback: true,
      selectedIconTheme: IconThemeData(
        color: palette.primaryColor,
        size: 18.cl(18, 26),
      ),
      selectedItemColor: palette.textColorLight,
      unselectedItemColor: palette.textColorLight,
      unselectedIconTheme: IconThemeData(
        color: Colors.grey[500],
        size: 18.cl(18, 26),
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.shifting,
      selectedLabelStyle: TextStyle(
        fontSize: 15.cl(12, 18),
        color: palette.textColorLight,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 15.cl(12, 18),
        color: palette.textColorLight,
      ),
    ),
  );
}
