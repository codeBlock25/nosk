import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ScreenType;
import 'package:nosk/src/logic/logic.dart';
import 'package:nosk/src/logic/room/logic.dart';
import 'package:nosk/src/logic/room_stay/logic.dart';
import 'package:nosk/src/logic/services/logic.dart';
import 'package:nosk/src/logic/user/logic.dart';
import 'package:nosk/src/screens/screens.dart';
import 'package:nosk/src/themes/themes.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final AppTheme appTheme = AppTheme(
  palette: AppThemePalette(
    primaryColor: const Color(0xff224CF0),
    primaryColorDark: const Color(0xff224CF0),
    primaryColorLight: const Color(0xff224CF0),
    background: const Color(0xffEAEAEA),
    backgroundDark: const Color(0xff141416),
    error: const Color(0xffd51134),
    errorContainer: const Color(0xffe5899a),
    secondary: const Color(0xff091739),
    tertiary: const Color(0xff272c38),
    textColorLight: Colors.grey[900]!,
    textColorDark: Colors.grey[100]!,
  ),
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      animationDuration: 300.milliseconds,
      type: MaterialType.canvas,
      surfaceTintColor: Colors.transparent,
      child: ResponsiveSizer(builder: (
        BuildContext context,
        Orientation orientation,
        ScreenType screenType,
      ) {
        return GetMaterialApp(
          title: 'Nosk',
          initialRoute: SplashPage.route.path(),
          unknownRoute: OuterPageNotFound.route.page(),
          builder: (BuildContext context, Widget? child) {
            return ResponsiveBreakpoints.builder(
              child: child ??
                  CircularProgressIndicator().center.contain(
                        width: 100.w,
                        height: 100.h,
                        color: Colors.white,
                      ),
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            );
          },
          getPages: [
            SplashPage.route.page(),
            LoginPage.route.page(),
            ForgotPasswordPage.route.page(),
            OuterPageNotFound.route.page(),
            InnerPageNotFound.route.page(),
            RegisterPage.route.page(),
            GuestMainPage.route.page(),
            AdminMainPage.route.page(),
            StaffMainPage.route.page(),
            AccountPage.route.page(),
            PersonalInformationPage.route.page(),
            PasswordSecurityPage.route.page(),
            CreateRoomPage.route.page(),
            RoomDetailPage.route.page(),
            EditRoomPage.route.page(),
            CreateUserPage.route.page(),
            CreateAdminPage.route.page(),
          ],
          onInit: () {
            AuthLogic.put;
            UserLogic.put;
            RoomLogic.put;
            ServiceLogic.put;
            RoomStayLogic.put;
          },
          color: Colors.blue,
          themeMode: ThemeMode.light,
          theme: appTheme.light,
          enableLog: true,
          defaultTransition: Transition.rightToLeftWithFade,
        );
      }),
    );
  }
}
