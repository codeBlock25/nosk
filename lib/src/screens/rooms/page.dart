import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nosk/src/logic/room/logic.dart';
import 'package:nosk/src/logic/room/room_model.dart';
import 'package:nosk/src/screens/screens.dart';

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
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final RoomModel room = snapshot.data!.docs[index].data();
              return ListTile(
                title: Text(room.name),
              );
            },
          );
        },
      ),
    );
  }
}
