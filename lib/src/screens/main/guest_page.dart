import 'dart:math';

import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:nosk/generated/assets.dart';
import 'package:nosk/src/app.dart';
import 'package:nosk/src/route/route.dart';
import 'package:nosk/src/screens/screens.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GuestMainPage extends RouteFulWidget {
  const GuestMainPage({super.key});

  static GuestMainPage get route => const GuestMainPage();

  @override
  State<GuestMainPage> createState() => _GuestMainPageState();

  @override
  String path() => '/main';

  @override
  String title() => 'Dashboard';
}

class _GuestMainPageState extends State<GuestMainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  final RxInt selectedTab = 0.obs;
  late List<AppTab> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      AppTab(
        label: 'Home',
        page: Container(
          color: Colors.transparent,
          width: 100.w,
          height: 100.h,
        ),
        iconAlt: HeroIcons.homeModern,
      ),
      AppTab(
        label: 'Book a room',
        page: Container(
          color: Colors.transparent,
          width: 100.w,
          height: 100.h,
        ),
        icon: Icons.bed_rounded,
      ),
      AppTab(
        label: 'My Reservations',
        page: Container(
          color: Colors.transparent,
          width: 100.w,
          height: 100.h,
        ),
        iconAlt: HeroIcons.calendarDateRange,
      ),
      AppTab(
        label: 'Hotel Services',
        page: Container(
          color: Colors.transparent,
          width: 100.w,
          height: 100.h,
        ),
        iconAlt: HeroIcons.server,
      ),
      AppTab(
        label: 'Bar/Restaurant',
        page: Container(
          color: Colors.transparent,
          width: 100.w,
          height: 100.h,
        ),
        icon: Icons.fastfood_outlined,
      ),
      AppTab(
        label: 'Facility Map',
        page: Container(
          color: Colors.transparent,
          width: 100.w,
          height: 100.h,
        ),
        iconAlt: HeroIcons.map,
      ),
      AppTab(
        label: 'Bill',
        page: Container(
          color: Colors.transparent,
          width: 100.w,
          height: 100.h,
        ),
        iconAlt: HeroIcons.banknotes,
      ),
      AppTab(
        label: 'How to get here',
        onTap: () {
          Get.back();
          Get.defaultDialog(
            title: 'Select your means of navigation',
            barrierDismissible: true,
            content: Wrap(
              runSpacing: 10.cl(10, 20),
              spacing: 10.cl(10, 20),
              children: [
                ElevatedButton(
                  onPressed: () => openGoogleMaps(9.07438, 7.494721),
                  style: ButtonStyle(
                    fixedSize: Size(35.w, 55.cl(60, 120)).all,
                    shape: RoundedRectangleBorder(
                      borderRadius: 10.cl(10, 20).brcAll,
                    ).all,
                    backgroundColor: context.theme.scaffoldBackgroundColor.all,
                    overlayColor: context.theme.scaffoldBackgroundColor
                        .darken()
                        .withValues(alpha: 0.4)
                        .all,
                    foregroundColor: appTheme.palette.textColorLight.all,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        Assets.iconsGoogleMap,
                        fit: BoxFit.fitHeight,
                        height: 25.cl(40, 80),
                      ),
                      Text('Google Maps'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => openBolt(9.07438, 7.494721),
                  style: ButtonStyle(
                    fixedSize: Size(35.w, 55.cl(60, 120)).all,
                    shape: RoundedRectangleBorder(
                      borderRadius: 10.cl(10, 20).brcAll,
                    ).all,
                    backgroundColor: Colors.green[100].all,
                    overlayColor:
                        Colors.green[100]?.darken().withValues(alpha: 0.4).all,
                    foregroundColor: appTheme.palette.textColorLight.all,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        Assets.iconsBolt,
                        fit: BoxFit.fitHeight,
                        height: 25.cl(40, 80),
                      ),
                      Text('Bolt'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => openUber(9.07438, 7.494721),
                  style: ButtonStyle(
                    fixedSize: Size(35.w, 55.cl(60, 120)).all,
                    shape: RoundedRectangleBorder(
                      borderRadius: 10.cl(10, 20).brcAll,
                    ).all,
                    backgroundColor: Colors.grey[100].all,
                    overlayColor:
                        Colors.grey[100]?.darken().withValues(alpha: 0.4).all,
                    foregroundColor: appTheme.palette.textColorLight.all,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        Assets.iconsUber,
                        fit: BoxFit.fitHeight,
                        height: 25.cl(40, 80),
                      ),
                      Text('Uber'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => openInDrive(9.07438, 7.494721),
                  style: ButtonStyle(
                    fixedSize: Size(35.w, 55.cl(60, 120)).all,
                    shape: RoundedRectangleBorder(
                      borderRadius: 10.cl(10, 20).brcAll,
                    ).all,
                    backgroundColor: Colors.greenAccent[100]?.lighten(5).all,
                    overlayColor: Colors.greenAccent[50]
                        ?.darken()
                        .withValues(alpha: 0.4)
                        .all,
                    foregroundColor: appTheme.palette.textColorLight.all,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        Assets.iconsIndrive,
                        fit: BoxFit.fitHeight,
                        height: 25.cl(40, 80),
                      ),
                      Text('InDrive'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        icon: Icons.directions_car_outlined,
      ),
    ];
    selectedTab.listen((int selected) {
      final currentPage = _pageController.page?.toInt() ?? 0;
      if (selected > currentPage) {
        _pageController.jumpToPage(max(selected - 1, 0));
      }
      if (selected < currentPage) {
        _pageController.jumpToPage(selected + 1);
      }
      _pageController.animateToPage(
        selected,
        duration: 400.milliseconds,
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    });
  }

  void openGoogleMaps(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunchUrlString(googleUrl)) {
      Get.back();
      await launchUrlString(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  /// 🚖 Open Bolt
  void openBolt(double latitude, double longitude) async {
    final boltUrl =
        'bolt://r?destination_lat=$latitude&destination_lng=$longitude';
    final webUrl = 'https://bolt.eu/en/cities/'; // Fallback

    if (await canLaunchUrlString(boltUrl)) {
      Get.back();
      await launchUrlString(boltUrl);
    } else {
      Get.back();
      await launchUrlString(webUrl);
    }
  }

  /// 🚗 Open Uber
  void openUber(double latitude, double longitude) async {
    final uberUrl =
        'uber://?action=setPickup&dropoff[latitude]=$latitude&dropoff[longitude]=$longitude';
    final webUrl =
        'https://m.uber.com/ul/?action=setPickup&dropoff[latitude]=$latitude&dropoff[longitude]=$longitude';

    if (await canLaunchUrlString(uberUrl)) {
      Get.back();
      await launchUrlString(uberUrl);
    } else {
      Get.back();
      await launchUrlString(webUrl);
    }
  }

  /// 🚕 Open InDrive
  void openInDrive(double latitude, double longitude) async {
    final inDriveUrl = 'indrive://route?daddr=$latitude,$longitude';
    final webUrl = 'https://indrive.com/';

    if (await canLaunchUrlString(inDriveUrl)) {
      Get.back();
      await launchUrlString(inDriveUrl);
    } else {
      Get.back();
      await launchUrlString(webUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (context.breakpoint.largerOrEqualTo(TABLET)) {
      return Scaffold();
    }
    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: true,
      drawerScrimColor:
          context.theme.primaryColor.darken(40).withValues(alpha: 0.6),
      drawer: Drawer(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        shadowColor: Colors.grey[600],
        elevation: 20.cl(20, 70),
        semanticLabel: 'Side Menu',
        child: Obx(
          () => ListView(
            padding: 0.pdAll,
            children: [
              context.mediaQueryPadding.top.hSpacer,
              Row(
                children: [
                  Image.asset(
                    Assets.iconsIcon,
                    width: 30.cl(35, 100),
                  ),
                  10.cl(10, 20).wSpacer,
                  Text(
                    'Nosk',
                    style: context.textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: Get.back,
                    style: ButtonStyle(
                      backgroundColor: context.theme.primaryColor.all,
                      foregroundColor: Colors.white.all,
                      shape: RoundedRectangleBorder(
                        borderRadius: 10.cl(10, 20).brcAll,
                      ).all,
                      fixedSize: 25.cl(30, 80).sized.all,
                    ),
                    icon: HeroIcon(
                      HeroIcons.chevronLeft,
                      color: Colors.white,
                    ),
                  ),
                  10.cl(10, 20).wSpacer,
                ],
              ),
              20.cl(10, 40).hSpacer,
              ..._tabs.map((tab) {
                final int index = _tabs.indexOf(tab);
                final isSelected = selectedTab.value == index;
                return ListTile(
                  onTap: () {
                    if (tab.onTap == null) {
                      selectedTab.value = index;
                      Get.back();
                    } else {
                      tab.onTap?.call();
                    }
                  },
                  titleTextStyle: context.textTheme.bodySmall?.copyWith(
                    color: isSelected.when(
                      use: Colors.white,
                      elseUse: appTheme.palette.textColorLight,
                    ),
                  ),
                  tileColor: isSelected.when(
                    use: context.theme.primaryColor,
                    elseUse: Colors.transparent,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: 10.cl(10, 18).brcAll,
                  ),
                  hoverColor: isSelected.when(
                    use: context.theme.primaryColor.darken(),
                    elseUse: context.theme.primaryColor.lighten(20),
                  ),
                  splashColor: isSelected.when(
                    use: Colors.white.withValues(alpha: 0.1),
                    elseUse: context.theme.primaryColor.withValues(alpha: 0.2),
                  ),
                  selectedTileColor: context.theme.primaryColor,
                  leading: tab.iconWidget(isSelected),
                  title: Text(tab.label),
                ).marginAll(5.cl(5, 10));
              })
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: context.breakpoint.smallerOrEqualTo(TABLET).whenOnly(
              use: IconButton(
                onPressed: () {
                  if (_scaffoldKey.currentState?.hasDrawer ?? false) {
                    _scaffoldKey.currentState?.openDrawer();
                  }
                },
                icon: Icon(Icons.menu),
              ),
            ),
        leadingWidth: 25.cl(20, 50),
        title: Row(
          children: <Widget>[
            Image.asset(
              Assets.iconsIcon,
              width: 22.cl(18, 34),
              fit: BoxFit.fitWidth,
            ),
            5.cl(10, 20).wSpacer,
            Obx(
              () => Text(
                _tabs.elementAt(selectedTab.value).label,
                style: context.textTheme.headlineSmall,
              ),
            ).expand
          ],
        ),
        actions: [
          IconButton(
            onPressed: AccountPage.route.goto,
            icon: HeroIcon(
              HeroIcons.userCircle,
              size: 20.cl(20, 44),
            ),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _tabs.where((tab) => tab.page != null).length,
        itemBuilder: (BuildContext context, int index) {
          final tab = _tabs.elementAt(index);
          return tab.page ?? 0.hSpacer;
        },
      ),
    );
  }
}