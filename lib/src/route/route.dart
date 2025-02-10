import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extension_helpers/extension_helpers.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

abstract class RouteFulWidget extends StatefulWidget {
  const RouteFulWidget({super.key});

  @protected
  @factory
  String path();

  @protected
  @factory
  String title();

  @protected
  Transition transition() => Transition.rightToLeftWithFade;

  @override
  @protected
  @factory
  State createState();

  GetPage page() {
    return GetPage(
      name: path(),
      page: () => this,
      title: title(),
      transition: transition(),
    );
  }

  String _redirect() {
    return path();
    // final authController = AuthController.to;
    // final profileController = ProfileController.to;
    // if (path().contains('auth')) {
    //   if (profileController.profile == null) {
    //     return path();
    //   } else {
    //     return const DashboardScreen().path();
    //   }
    // } else if (path().contains('on_boarding')) {
    //   if (authController.auth.value == null) {
    //     return path();
    //   } else {
    //     return const LoadingScreen().path();
    //   }
    // } else {
    //   return path();
    // }
  }

  Future<dynamic>? goto({
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    return Get.toNamed(
      _redirect(),
      arguments: arguments,
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
    );
  }

  Future<dynamic>? startAt() {
    return Get.offAllNamed(_redirect());
  }

  Future<dynamic>? stepBackAndTo({
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) {
    return Get.offAndToNamed(
      _redirect(),
      arguments: arguments,
      id: id,
      parameters: parameters,
    );
  }

  Future<dynamic>? stepBackUntil(
    bool Function(Route<dynamic>) route, {
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) {
    return Get.offNamedUntil(
      _redirect(),
      route,
      arguments: arguments,
      id: id,
      parameters: parameters,
    );
  }

  Future<dynamic>? openBottomSheet() {
    return Get.bottomSheet(
      this,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: 20.sp.rc,
        ),
      ),
      ignoreSafeArea: true,
      backgroundColor: const Color(0xffDAEBDA),
      elevation: 10,
      barrierColor: Colors.black.withValues(alpha: 0.2),
    );
  }
}
