import 'package:cached_network_image/cached_network_image.dart';
import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nosk/src/logic/room/logic.dart';
import 'package:nosk/src/logic/room/room_model.dart';
import 'package:nosk/src/screens/screens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  final RoomLogic _roomLogic = RoomLogic.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: CreateRoomPage.route.goto,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot<RoomModel>>(
        stream: _roomLogic.getRooms(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<RoomModel>> snapshot) {
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

          if (snapshot.data!.docs.isEmpty) {
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
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final RoomModel room = snapshot.data!.docs[index].data();
              return ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 18.cl(24, 38),
                      height: 18.cl(24, 38),
                      decoration: BoxDecoration(
                        borderRadius: 6.cl(5, 10).brcAll,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(room.images.first),
                        ),
                      ),
                    ),
                    Text('${index + 1}.')
                  ],
                ).sized(width: 18.cl(24, 38).square.toDouble()),
                tileColor: context.theme.primaryColor.withValues(alpha: 0.05),
                splashColor: context.theme.primaryColor.withValues(alpha: 0.05),
                onTap: () => RoomDetailPage.route.goto(arguments: {
                  'roomName': room.name,
                }),
                trailing: Text(
                  room.price.toMoney,
                  style: context.textTheme.bodySmall,
                ),
                title: Text(
                  room.name.frontTag('Room: '),
                  style: context.textTheme.headlineSmall,
                ),
                subtitle: Text(
                  room.description.frontTag('Description: '),
                  style: context.textTheme.bodySmall,
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
