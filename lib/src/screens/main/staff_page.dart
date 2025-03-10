import 'dart:math';

import 'package:google_fonts/google_fonts.dart';
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

class StaffMainPage extends RouteFulWidget {
  const StaffMainPage({super.key});

  static StaffMainPage get route => const StaffMainPage();

  @override
  State<StaffMainPage> createState() => _GuestMainPageState();

  @override
  String path() => '/staff';

  @override
  String title() => 'Dashboard';
}

class _GuestMainPageState extends State<StaffMainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  final RxInt selectedTab = 0.obs;
  late List<AppTab> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      AppTab(
        label: 'Dashboard',
        page: Container(
          color: Colors.transparent,
          width: 100.w,
          height: 100.h,
        ),
        icon: Icons.dashboard,
      ),
      AppTab(
        label: 'Check-in & Check-out',
        page: CheckInOut(),
        icon: Icons.login, // or Icons.logout for check-out
      ),
      AppTab(
        label: 'Housekeeping',
        page: HouseKeepingPage(),
        icon: Icons.cleaning_services,
      ),
      AppTab(
        label: 'Room Service Requests',
        page: RoomServicePage(),
        icon: Icons.room_service,
      ),
      AppTab(
        label: 'Hotel Policies',
        page: Container(
          color: Colors.transparent,
          width: 100.w,
          height: 100.h,
        ),
        icon: Icons.rule,
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

  @override
  Widget build(BuildContext context) {
    if (context.breakpoint.largerOrEqualTo(TABLET)) {
      return Scaffold(
        body: Row(
          children: [
            Obx(
              () => ListView(
                padding: 0.pdAll,
                physics: const ClampingScrollPhysics(),
                children: [
                  context.mediaQueryPadding.top.hSpacer,
                  Row(
                    children: [
                      Image.asset(
                        Assets.iconsIcon,
                        width: 18.cl(20, 40),
                      ),
                      10.cl(10, 20).wSpacer,
                      Text(
                        "Apple's Field",
                        style: GoogleFonts.lato(
                          textStyle: context.textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ).marginSymmetric(
                    vertical: 10.cl(10, 20),
                    horizontal: 10.cl(10, 20),
                  ),
                  ..._tabs.map((tab) {
                    final int index = _tabs.indexOf(tab);
                    final isSelected = selectedTab.value == index;
                    return Material(
                      color: Colors.transparent,
                      child: ListTile(
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
                        selected: isSelected.isTrue,
                        selectedColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: 10.cl(10, 18).brcAll,
                        ),
                        hoverColor: isSelected.when(
                          use: context.theme.primaryColor.darken(),
                          elseUse: context.theme.primaryColor.lighten(20),
                        ),
                        splashColor: isSelected.when(
                          use: Colors.white.withValues(alpha: 0.1),
                          elseUse:
                              context.theme.primaryColor.withValues(alpha: 0.2),
                        ),
                        selectedTileColor: context.theme.primaryColor,
                        leading: tab.iconWidget(isSelected),
                        title: Text(tab.label),
                      ),
                    ).marginSymmetric(
                      horizontal: 10.cl(5, 40),
                      vertical: 5.cl(5, 10),
                    );
                  })
                ],
              ),
            ).contain(
              width: 20.cw(200, 450),
              height: 100.h,
              margin: 10.cl(5, 22).pdAll,
              decoration: BoxDecoration(
                color: context.theme.scaffoldBackgroundColor.darken(),
                borderRadius: 10.cl(10, 20).brcCircle,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: AccountPage.route.goto,
                  icon: HeroIcon(HeroIcons.user),
                  style: ButtonStyle(
                    padding: 15.cl(12, 35).pdXY(12.cl(5, 30)).all,
                  ),
                  label: Text(
                    'Setting',
                    style: context.textTheme.headlineSmall,
                  ),
                ).marginOnly(
                  top: 10.cl(10, 20),
                  right: 10.cl(10, 20),
                ),
                PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _tabs.where((tab) => tab.page != null).length,
                  itemBuilder: (BuildContext context, int index) {
                    final tab = _tabs.elementAt(index);
                    return tab.page ?? 0.hSpacer;
                  },
                ).expand
              ],
            ).expand
          ],
        ).sized(width: 100.w, height: 100.h),
      );
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
                    fit: BoxFit.fitHeight,
                  ).expand,
                  10.cl(10, 20).wSpacer,
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
              width: 28.cl(18, 40),
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
