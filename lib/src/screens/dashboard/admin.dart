import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key, required this.changeTab});

  final void Function(int) changeTab;

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Quick View'.toUpperCase(),
          style: context.textTheme.headlineSmall,
        ).addOpacity(0.6).paddingOnly(
              top: 10.cl(10, 20),
              bottom: 20.cl(10, 40),
              left: 15.cl(10, 30),
              right: 15.cl(10, 30),
            ),
        GridView(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.breakpoint.largerOrEqualTo(TABLET).when(
                  use: context.breakpoint
                      .largerOrEqualTo(DESKTOP)
                      .when(use: 4, elseUse: 3),
                  elseUse: 2,
                ),
            childAspectRatio: 16 / 9,
            crossAxisSpacing: 15.cl(10, 30),
            mainAxisSpacing: 17.cl(10, 35),
          ),
          physics: NeverScrollableScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Total Check-ins'.toUpperCase(),
                  style: context.textTheme.headlineSmall
                      ?.copyWith(color: Colors.white),
                ),
                Text(
                  '10M',
                  style: context.textTheme.headlineLarge
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ).contain(
              padding: 15.cl(10, 35).pdYX(10.cl(10, 20)),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF0072FF).withValues(alpha: 0.4),
                      blurRadius: 15.cl(5, 20),
                      offset: Offset(-4.cl(5, 10), -4.cl(5, 10))),
                  BoxShadow(
                      color: Color(0xFF00C6FF).withValues(alpha: 0.4),
                      blurRadius: 15.cl(5, 20),
                      offset: Offset(4.cl(5, 10), 4.cl(5, 10))),
                ],
                borderRadius: 10.cl(10, 20).brcAll,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Total Sales'.toUpperCase(),
                  style: context.textTheme.headlineSmall
                      ?.copyWith(color: Colors.white),
                ),
                Text(
                  '10M',
                  style: context.textTheme.headlineLarge
                      ?.copyWith(color: Colors.white),
                ),
              ],
            )
                .contain(
                  padding: 15.cl(10, 35).pdYX(10.cl(10, 20)),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFFF4B2B).withValues(alpha: 0.4),
                          blurRadius: 15.cl(5, 20),
                          offset: Offset(-4.cl(5, 10), -4.cl(5, 10))),
                      BoxShadow(
                          color: Color(0xFFFF416C).withValues(alpha: 0.4),
                          blurRadius: 15.cl(5, 20),
                          offset: Offset(4.cl(5, 10), 4.cl(5, 10))),
                    ],
                    borderRadius: 10.cl(10, 20).brcAll,
                  ),
                )
                .gestureHandler(onTap: () => widget.changeTab(6)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Total Admins'.toUpperCase(),
                  style: context.textTheme.headlineSmall,
                ),
                Text(
                  '10M',
                  style: context.textTheme.headlineLarge,
                ),
              ],
            )
                .contain(
                  padding: 15.cl(10, 35).pdYX(10.cl(10, 20)),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF9A9E), Color(0xFFFAD0C4)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFFAD0C4).withValues(alpha: 0.4),
                          blurRadius: 15.cl(5, 20),
                          offset: Offset(-4.cl(5, 10), -4.cl(5, 10))),
                      BoxShadow(
                          color: Color(0xFFFF9A9E).withValues(alpha: 0.4),
                          blurRadius: 15.cl(5, 20),
                          offset: Offset(4.cl(5, 10), 4.cl(5, 10))),
                    ],
                    borderRadius: 10.cl(10, 20).brcAll,
                  ),
                )
                .gestureHandler(onTap: () => widget.changeTab(4)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Total Staffs'.toUpperCase(),
                  style: context.textTheme.headlineSmall
                      ?.copyWith(color: Colors.white),
                ),
                Text(
                  '10M',
                  style: context.textTheme.headlineLarge
                      ?.copyWith(color: Colors.white),
                ),
              ],
            )
                .contain(
                  padding: 15.cl(10, 35).pdYX(10.cl(10, 20)),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0D244D), Color(0xFF2F80ED)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF2F80ED).withValues(alpha: 0.4),
                          blurRadius: 15.cl(5, 20),
                          offset: Offset(-4.cl(5, 10), -4.cl(5, 10))),
                      BoxShadow(
                          color: Color(0xFF0D244D).withValues(alpha: 0.4),
                          blurRadius: 15.cl(5, 20),
                          offset: Offset(4.cl(5, 10), 4.cl(5, 10))),
                    ],
                    borderRadius: 10.cl(10, 20).brcAll,
                  ),
                )
                .gestureHandler(onTap: () => widget.changeTab(3)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Total Reservations'.toUpperCase(),
                  style: context.textTheme.headlineSmall,
                ),
                Text(
                  '10M',
                  style: context.textTheme.headlineLarge,
                ),
              ],
            )
                .contain(
                  padding: 15.cl(10, 35).pdYX(10.cl(10, 20)),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFF7971E), Color(0xFFFFD200)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFFFD200).withValues(alpha: 0.4),
                          blurRadius: 15.cl(5, 20),
                          offset: Offset(-4.cl(5, 10), -4.cl(5, 10))),
                      BoxShadow(
                          color: Color(0xFFF7971E).withValues(alpha: 0.4),
                          blurRadius: 15.cl(5, 20),
                          offset: Offset(4.cl(5, 10), 4.cl(5, 10))),
                    ],
                    borderRadius: 10.cl(10, 20).brcAll,
                  ),
                )
                .gestureHandler(onTap: () => widget.changeTab(1)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Total Guests'.toUpperCase(),
                  style: context.textTheme.headlineSmall
                      ?.copyWith(color: Colors.white),
                ),
                Text(
                  '10M',
                  style: context.textTheme.headlineLarge
                      ?.copyWith(color: Colors.white),
                ),
              ],
            )
                .contain(
                  padding: 15.cl(10, 35).pdYX(10.cl(10, 20)),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF4A00E0).withValues(alpha: 0.4),
                          blurRadius: 15.cl(5, 20),
                          offset: Offset(-4.cl(5, 10), -4.cl(5, 10))),
                      BoxShadow(
                          color: Color(0xFF8E2DE2).withValues(alpha: 0.4),
                          blurRadius: 15.cl(5, 20),
                          offset: Offset(4.cl(5, 10), 4.cl(5, 10))),
                    ],
                    borderRadius: 10.cl(10, 20).brcAll,
                  ),
                )
                .gestureHandler(onTap: () => widget.changeTab(5)),
          ],
        ).paddingSymmetric(
          horizontal: 15.cl(10, 30),
        ),
        Text(
          'Recent Reservations'.toUpperCase(),
          style: context.textTheme.headlineSmall,
        ).addOpacity(0.6).paddingOnly(
              top: 20.cl(10, 40),
              bottom: 10.cl(10, 20),
              left: 15.cl(10, 30),
              right: 15.cl(10, 30),
            ),
        ListTile(
          leading: Icon(
            Icons.bedroom_child_rounded,
            color: context.theme.primaryColor,
          ),
          tileColor: Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: 10.cl(10, 20).brcAll,
          ),
          title: Text(
            'Lorem res trf tesdfg trfd.',
            style: context.textTheme.bodySmall,
          ),
          subtitle: Text(
            '10:10 AM',
            style: context.textTheme.bodySmall,
          ),
          trailing: Icon(
            Icons.timer_sharp,
            color: Colors.blue[400],
          ),
        ).marginSymmetric(
          vertical: 4.cl(4, 10),
          horizontal: 15.cl(10, 30),
        ),
        Text(
          'Recent Check-ins/outs'.toUpperCase(),
          style: context.textTheme.headlineSmall,
        ).addOpacity(0.6).paddingOnly(
              top: 20.cl(10, 40),
              bottom: 5.cl(5, 10),
              left: 15.cl(10, 30),
              right: 15.cl(10, 30),
            ),
        ListTile(
          leading: Icon(
            Icons.bedroom_child_rounded,
            color: context.theme.primaryColor,
          ),
          tileColor: Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: 10.cl(10, 20).brcAll,
          ),
          title: Text(
            'Lorem res trf tesdfg trfd.',
            style: context.textTheme.bodySmall,
          ),
          subtitle: Text(
            '10:10 AM',
            style: context.textTheme.bodySmall,
          ),
          trailing: Icon(
            Icons.timer_sharp,
            color: Colors.blue[400],
          ),
        ).marginSymmetric(
          vertical: 4.cl(4, 10),
          horizontal: 15.cl(10, 30),
        ),
        ListTile(
          leading: Icon(
            Icons.bedroom_child_rounded,
            color: context.theme.primaryColor,
          ),
          tileColor: Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: 10.cl(10, 20).brcAll,
          ),
          title: Text(
            'Lorem res trf tesdfg trfd.',
            style: context.textTheme.bodySmall,
          ),
          subtitle: Text(
            '10:10 AM',
            style: context.textTheme.bodySmall,
          ),
          trailing: Icon(
            Icons.timer_sharp,
            color: Colors.blue[400],
          ),
        ).marginSymmetric(
          vertical: 4.cl(4, 10),
          horizontal: 15.cl(10, 30),
        ),
        ListTile(
          leading: Icon(
            Icons.bedroom_child_rounded,
            color: context.theme.primaryColor,
          ),
          tileColor: Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: 10.cl(10, 20).brcAll,
          ),
          title: Text(
            'Lorem res trf tesdfg trfd.',
            style: context.textTheme.bodySmall,
          ),
          subtitle: Text(
            '10:10 AM',
            style: context.textTheme.bodySmall,
          ),
          trailing: Icon(
            Icons.timer_sharp,
            color: Colors.blue[400],
          ),
        ).marginSymmetric(
          vertical: 4.cl(4, 10),
          horizontal: 15.cl(10, 30),
        ),
      ],
    ).scrollable().contain(
          width: 100.w,
          height: 100.h,
        );
  }
}
