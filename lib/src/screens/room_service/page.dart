import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nosk/src/logic/services/logic.dart';
import 'package:nosk/src/logic/services/service_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RoomServicePage extends StatefulWidget {
  const RoomServicePage({super.key});

  @override
  State<RoomServicePage> createState() => _RoomServicePageState();
}

class _RoomServicePageState extends State<RoomServicePage> {
  final ServiceLogic _serviceLogic = ServiceLogic.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ServiceModel>>(
        stream: _serviceLogic.getServices(
          userId: null,
          excepts: ServiceType.cleaning,
        ),
        builder:
            (BuildContext context, AsyncSnapshot<List<ServiceModel>> snapshot) {
          if (snapshot.hasError) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Something went wrong',
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ).contain(
              width: 100.w,
              height: 100.h,
              alignment: Alignment.center,
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text(
              "Loading",
              style: context.textTheme.bodyMedium,
            ).contain(
              width: 100.w,
              height: 100.h,
              alignment: Alignment.center,
            );
          }

          if (snapshot.data!.isEmpty) {
            return Text(
              "No Room Service requests yet.",
              style: context.textTheme.bodyMedium,
            ).contain(
              width: 100.w,
              height: 100.h,
              alignment: Alignment.center,
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              final ServiceModel room = snapshot.data!.elementAt(index);
              return ListTile(
                leading: Text('${index + 1}.'),
                tileColor: context.theme.primaryColor.withValues(alpha: 0.05),
                splashColor: context.theme.primaryColor.withValues(alpha: 0.05),
                title: Text(
                  room.type.value,
                  style: context.textTheme.headlineSmall,
                ),
              ).marginSymmetric(
                vertical: 4.cl(4, 12),
              );
            },
          );
        },
      ),
    );
  }
}
