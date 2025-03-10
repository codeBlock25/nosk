import 'package:extension_helpers/extension_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nosk/generated/assets.dart';
import 'package:nosk/src/logic/auth/logic.dart';
import 'package:nosk/src/logic/auth/user_model.dart';
import 'package:nosk/src/logic/user/logic.dart';
import 'package:nosk/src/route/route.dart';
import 'package:nosk/src/screens/screens.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashPage extends RouteFulWidget {
  const SplashPage({super.key});

  static SplashPage get route => const SplashPage();

  @override
  State<SplashPage> createState() => _SplashPageState();

  @override
  String path() => '/';

  @override
  String title() => 'Welcome to Nosk';
}

class _SplashPageState extends State<SplashPage> {
  final AuthLogic authLogic = AuthLogic.to;
  final UserLogic userLogic = UserLogic.to;

  @override
  void initState() {
    super.initState();
    authLogic.firebaseAuth.authStateChanges().first.then((User? user) async {
      if (user == null) {
        LoginPage.route.startAt();
      } else {
        await userLogic.getUser(user.uid).then(
          (UserModel? userModel) {
            if (userModel == null) {
              GuestMainPage.route.startAt();
            } else if (userModel.type == UserType.admin) {
              authLogic.setCurrentUser(userModel, user);
              AdminMainPage.route.startAt();
            } else if (userModel.type == UserType.staff) {
              authLogic.setCurrentUser(userModel, user);
              StaffMainPage.route.startAt();
            } else {
              authLogic.setCurrentUser(userModel, user);
              GuestMainPage.route.startAt();
            }
          },
          onError: (e) {
            OuterPageNotFound.route.startAt();
          },
        );
      }
    }).catchError((_) {
      OuterPageNotFound.route.startAt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Assets.iconsIcon,
                width: context.breakpoint
                    .largerThan(MOBILE)
                    .when(use: 25.cw(100, 250), elseUse: 35.cw(50, 350)),
                fit: BoxFit.fitWidth,
              ),
              Text(
                "Apple's Field",
                style: context.textTheme.headlineMedium,
              )
            ],
          ).center.positionFill(),
          context.breakpoint
              .largerThan(MOBILE)
              .when(
                  use: LinearProgressIndicator(
                    borderRadius: 5.cl(5, 10).rc.brAll,
                  ).sized(
                    width: 15.cw(150, 300),
                  ),
                  elseUse: CircularProgressIndicator())
              .center
              .position(
                width: 100.w,
                bottom: 5.ch(50, 100),
              ),
        ],
      ),
    );
  }
}
