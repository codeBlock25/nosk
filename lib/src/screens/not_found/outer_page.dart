import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:nosk/generated/assets.dart';
import 'package:nosk/src/route/route.dart';
import 'package:nosk/src/screens/screens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OuterPageNotFound extends RouteFulWidget {
  const OuterPageNotFound({super.key});

  static OuterPageNotFound get route => const OuterPageNotFound();

  @override
  State<OuterPageNotFound> createState() => _OuterPageNotFoundState();

  @override
  String path() => '/not-found';

  @override
  String title() => '404 Page';
}

class _OuterPageNotFoundState extends State<OuterPageNotFound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Assets.iconsIcon,
            fit: BoxFit.fitHeight,
            height: 30.cl(50, 100),
          ).marginOnly(
            top: context.mediaQueryPadding.top.division(2.6).toDouble(),
            bottom: 10.cl(10, 20),
          ),
          const Spacer(),
          Image.asset(
            Assets.imagesError,
            fit: BoxFit.fitWidth,
            width: 80.cw(200, 450),
          ),
          Text(
            'Ops! An Error occurred.',
            style: context.textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          5.cl(5, 15).hSpacer,
          Text(
            'Please check your internet connection, and try again.',
            style: context.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          20.cl(20, 50).hSpacer,
          ElevatedButton.icon(
            onPressed: SplashPage.route.startAt,
            style: ButtonStyle(
              minimumSize: Size(60.cl(100, 350), 28.cl(40, 60)).all,
              elevation: 0.0.all,
              shape: RoundedRectangleBorder(
                borderRadius: 16.cl(10, 35).brcCircle,
              ).all,
            ),
            icon: HeroIcon(HeroIcons.arrowPath),
            label: Text(
              'Try Again',
              style: context.textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(
            flex: 4,
          ),
        ],
      ).contain(
        width: 100.w,
        height: 100.h,
        padding: 25.cl(10, 45).pdAll,
      ),
    );
  }
}
