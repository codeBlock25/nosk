import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nosk/generated/assets.dart';
import 'package:nosk/src/logic/room/logic.dart';
import 'package:nosk/src/logic/room/room_model.dart';
import 'package:nosk/src/route/route.dart';
import 'package:nosk/src/screens/rooms/edit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RoomDetailPage extends RouteFulWidget {
  const RoomDetailPage({super.key});

  static RouteFulWidget get route => RoomDetailPage();

  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();

  @override
  String path() => '/room-detail';

  @override
  String title() => 'Room Detail';
}

class _RoomDetailPageState extends State<RoomDetailPage> {
  final RoomLogic _roomLogic = RoomLogic.to;
  late final String roomName;

  @override
  void initState() {
    super.initState();
    roomName = Get.arguments?['roomName'] ?? 'some';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomName.capitalize ?? ''),
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: context.theme.scaffoldBackgroundColor,
          statusBarColor: context.theme.scaffoldBackgroundColor,
          systemNavigationBarIconBrightness:
              !GetPlatform.isIOS ? Brightness.dark : Brightness.light,
          statusBarBrightness:
              !GetPlatform.isIOS ? Brightness.dark : Brightness.light,
          statusBarIconBrightness:
              !GetPlatform.isIOS ? Brightness.dark : Brightness.light,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => EditRoomPage.route.goto(
          arguments: {
            'roomName': roomName,
          },
        ),
        child: const Icon(Icons.edit),
      ),
      body: StreamBuilder<DocumentSnapshot<RoomModel>>(
        stream: _roomLogic.getRoom(roomName),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<RoomModel>> snapshot) {
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
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator().sized(
                  width: 18.cl(24, 38),
                  height: 18.cl(24, 38),
                ),
                Text(
                  "Loading...",
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ).contain(
              width: 100.w,
              height: 100.h,
              alignment: Alignment.center,
            );
          }

          final RoomModel? room = snapshot.data?.data();
          if (room == null) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.imagesError,
                  width: 70.w,
                  fit: BoxFit.fitWidth,
                ),
                Text(
                  "404 - Not Found",
                  style: context.textTheme.headlineMedium,
                ),
                15.cl(10, 30).hSpacer,
                ElevatedButton(
                  onPressed: Get.back,
                  style: ButtonStyle(
                    backgroundColor: Colors.red.all,
                    foregroundColor: Colors.white.all,
                    minimumSize: Size(200, 28.cl(30, 55)).all,
                  ),
                  child: Text('Go Home'),
                )
              ],
            ).contain(
              width: 100.w,
              height: 100.h,
              alignment: Alignment.center,
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CarouselView(
                backgroundColor: Colors.grey[100],
                itemExtent: 200,
                itemSnapping: true,
                children: room.images
                    .map(
                      (image) => ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          width: double.infinity,
                          height: 30.ch(300, 500),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                    .toList(),
              ).contain(
                height: 30.ch(300, 450),
                padding: 15.cl(15, 40).pdX,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room.name,
                      style: context.textTheme.headlineMedium,
                    ),
                    10.cl(10, 20).hSpacer,
                    Text(
                      'Price Range: ${room.price.toMoney}',
                      style: context.textTheme.bodySmall,
                    ),
                    10.cl(10, 20).hSpacer,
                    Text(
                      room.description,
                      style: context.textTheme.bodySmall,
                    ),
                    15.cl(10, 30).hSpacer,
                    Text(
                      'Room Numbers',
                      style: context.textTheme.headlineSmall,
                    ),
                    10.cl(10, 20).hSpacer,
                    if (room.roomNumber.isEmpty)
                      Text(
                        'No room numbers added yet.',
                        style: context.textTheme.bodySmall,
                      ).addOpacity(0.6).center.expand
                    else
                      Wrap(
                        spacing: 8.cl(4, 12),
                        runSpacing: 8.cl(4, 12),
                        children: room.roomNumber.map((amenity) {
                          return Chip(
                            label: Text(
                              amenity.toUpperCase(),
                              style: context.textTheme.bodySmall,
                            ),
                          );
                        }).toList(),
                      )
                          .scrollable(
                            physics: const BouncingScrollPhysics(),
                          )
                          .sized(
                            width: 100.w,
                            height: 150,
                          ),
                    15.cl(10, 30).hSpacer,
                    Text(
                      'Amenities',
                      style: context.textTheme.headlineSmall,
                    ),
                    10.cl(10, 20).hSpacer,
                    if (room.amenities.isEmpty)
                      Text(
                        'No amenities added yet.',
                        style: context.textTheme.bodySmall,
                      ).addOpacity(0.6).center.expand
                    else
                      Wrap(
                        spacing: 8.cl(4, 12),
                        runSpacing: 8.cl(4, 12),
                        children: room.amenities.map((amenity) {
                          return Chip(
                            label: Text(
                              amenity.toUpperCase(),
                              style: context.textTheme.bodySmall,
                            ),
                          );
                        }).toList(),
                      )
                          .scrollable(
                            physics: const BouncingScrollPhysics(),
                          )
                          .sized(
                            width: 100.w,
                            height: 150,
                          ),
                  ],
                ),
              ),
            ],
          ).scrollable().sized(
                width: 100.w,
                height: 100.h,
              );
        },
      ),
    );
  }
}
