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

class AdminMainPage extends RouteFulWidget {
  const AdminMainPage({super.key});

  static AdminMainPage get route => const AdminMainPage();

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();

  @override
  String path() => '/admin';

  @override
  String title() => 'Dashboard';
}

class _AdminMainPageState extends State<AdminMainPage> {
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
        label: 'Reservations Management',
        page: Container(
          color: Colors.transparent,
          width: 100.w,
          height: 100.h,
        ),
        icon: Icons.calendar_today,
      ),
      AppTab(
        label: 'Room Management',
        page: RoomsPage(),
        icon: Icons.hotel,
      ),
      AppTab(
        label: 'Staff Management',
        page: UsersPage(),
        icon: Icons.people,
      ),
      AppTab(
        label: 'Guest Management',
        page: Container(
          color: Colors.transparent,
          width: 100.w,
          height: 100.h,
        ),
        icon: Icons.person,
      ),
      AppTab(
        label: 'Billing & Payments',
        page: Container(
          color: Colors.transparent,
          width: 100.w,
          height: 100.h,
        ),
        icon: Icons.attach_money,
      ),
      AppTab(
        label: 'Reports & Analytics',
        page: Container(
          color: Colors.transparent,
          width: 100.w,
          height: 100.h,
        ),
        icon: Icons.bar_chart,
      ),
      AppTab(
        label: 'Feedback & Reviews',
        page: Container(
          color: Colors.transparent,
          width: 100.w,
          height: 100.h,
        ),
        icon: Icons.rate_review,
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

class AppTab {
  late final String label;
  late final IconData? icon;
  late final HeroIcons? iconAlt;
  late final Widget? page;
  late final void Function()? onTap;

  AppTab({
    required this.label,
    this.icon,
    this.iconAlt,
    this.page,
    this.onTap,
  }) {
    if (icon == null && iconAlt == null) {
      assert(throw FlutterError('icon and iconAlt cant be both empty.'));
    }

    if (page == null && onTap == null) {
      assert(throw FlutterError('page and onTap cant be both empty.'));
    }
  }

  Widget iconWidget(bool isSelected) {
    if (icon is IconData) {
      return Icon(
        icon,
        color: isSelected.when(
          use: Colors.white,
          elseUse: appTheme.palette.primaryColor,
        ),
      );
    }

    if (iconAlt is HeroIcons && iconAlt != null) {
      return HeroIcon(
        iconAlt!,
        color: isSelected.when(
          use: Colors.white,
          elseUse: appTheme.palette.primaryColor,
        ),
      );
    }
    return 0.wSpacer;
  }
}
