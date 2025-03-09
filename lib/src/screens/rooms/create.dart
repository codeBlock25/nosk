import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nosk/src/route/route.dart';

class CreateRoomPage extends RouteFulWidget {
  const CreateRoomPage({super.key});

  static CreateRoomPage get route => const CreateRoomPage();

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();

  @override
  String path() => '/create-room';

  @override
  String title() => 'Create Room';

  @override
  Transition transition() => Transition.leftToRightWithFade;
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
