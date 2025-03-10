import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nosk/src/logic/room_stay/logic.dart';
import 'package:nosk/src/logic/room_stay/room_stay_model.dart';
import 'package:nosk/src/screens/screens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CheckInOut extends StatefulWidget {
  const CheckInOut({super.key});

  @override
  State<CheckInOut> createState() => _CheckInOutState();
}

class _CheckInOutState extends State<CheckInOut> {
  final RoomStayLogic _roomStayLogic = RoomStayLogic.to;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: CreateRoomPage.route.goto,
        child: const Icon(Icons.edit_note_outlined),
      ),
      body: StreamBuilder<List<RoomStayModel>>(
        stream: _roomStayLogic.getCheckIns(),
        builder: (BuildContext context,
            AsyncSnapshot<List<RoomStayModel>> snapshot) {
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
              "No Rooms yet, create one",
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
              final RoomStayModel room = snapshot.data!.elementAt(index);
              return ListTile(
                tileColor: context.theme.primaryColor.withValues(alpha: 0.05),
                splashColor: context.theme.primaryColor.withValues(alpha: 0.05),
                trailing: Text(
                  room.price.toMoney,
                  style: context.textTheme.bodySmall,
                ),
                title: Text(
                  room.roomId.frontTag('Room: '),
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
