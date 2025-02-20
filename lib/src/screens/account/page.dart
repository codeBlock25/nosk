import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:nosk/generated/assets.dart';
import 'package:nosk/src/logic/auth/logic.dart';
import 'package:nosk/src/route/route.dart';
import 'package:nosk/src/screens/login/page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AccountPage extends RouteFulWidget {
  const AccountPage({super.key});

  static AccountPage get route => const AccountPage();

  @override
  State<AccountPage> createState() => _AccountScreenState();

  @override
  String path() => '/account';

  @override
  String title() => 'Account';

  @override
  Transition transition() => Transition.rightToLeftWithFade;
}

class _AccountScreenState extends State<AccountPage> {
  final AuthLogic _authLogic = AuthLogic.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Image.asset(
            Assets.iconsIcon,
            fit: BoxFit.fitHeight,
            height: 28.cl(30, 40),
          ),
          5.cl(5, 10).wSpacer,
          Text(
            'Setting',
            style: context.textTheme.headlineMedium,
          ),
        ],
      )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 24.cl(28, 40),
                child: HeroIcon(
                  HeroIcons.user,
                  color: context.theme.primaryColor,
                  size: 28.cl(30, 40),
                ).marginAll(10.cl(10, 20)),
              ),
              10.cl(10, 20).wSpacer,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _authLogic.user.value?.fullName ?? '',
                    style: context.textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  Text(
                    (_authLogic.user.value?.type?.value ?? '').toUpperCase(),
                    style: context.textTheme.headlineSmall,
                  ),
                ],
              ).expand
            ],
          ),
          25.cl(15, 50).hSpacer,
          Text(
            'Account Settings',
            style: context.textTheme.headlineSmall,
          ).addOpacity(0.6),
          15.cl(15, 30).hSpacer,
          ListTile(
            tileColor: Colors.white.withValues(alpha: 0.7),
            shape: RoundedRectangleBorder(
              borderRadius: 15.cl(10, 25).brcCircle,
            ),
            leading: HeroIcon(
              HeroIcons.user,
            ),
            title: Text(
              'Personal Information',
              style: context.textTheme.headlineSmall,
            ),
            trailing: HeroIcon(
              HeroIcons.chevronRight,
            ),
          ),
          15.cl(15, 30).hSpacer,
          ListTile(
            tileColor: Colors.white.withValues(alpha: 0.7),
            shape: RoundedRectangleBorder(
              borderRadius: 15.cl(10, 25).brcCircle,
            ),
            leading: HeroIcon(
              HeroIcons.shieldCheck,
            ),
            title: Text(
              'Password & Security',
              style: context.textTheme.headlineSmall,
            ),
            trailing: HeroIcon(
              HeroIcons.chevronRight,
            ),
          ),
          30.cl(30, 50).hSpacer,
          Text(
            'Others',
            style: context.textTheme.headlineSmall,
          ).addOpacity(0.6),
          15.cl(15, 30).hSpacer,
          ListTile(
            tileColor: Colors.white.withValues(alpha: 0.7),
            splashColor: context.theme.primaryColor.withValues(alpha: 0.15),
            onTap: () async {
              await _authLogic.signOut();
              LoginPage.route.startAt();
            },
            shape: RoundedRectangleBorder(
              borderRadius: 15.cl(10, 25).brcCircle,
            ),
            leading: HeroIcon(
              HeroIcons.power,
              color: context.theme.colorScheme.error,
            ),
            title: Text(
              'Logout',
              style: context.textTheme.headlineSmall,
            ),
            trailing: HeroIcon(
              HeroIcons.xMark,
              color: context.theme.colorScheme.error,
            ),
          ),
        ],
      ).scrollable().contain(
            width: 100.w,
            height: 100.h,
            padding: 15.cl(15, 35).pdX,
          ),
    );
  }
}
