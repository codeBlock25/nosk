import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nosk/src/logic/auth/user_model.dart';
import 'package:nosk/src/logic/user/logic.dart';
import 'package:nosk/src/screens/screens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AdminsPage extends StatefulWidget {
  const AdminsPage({super.key});

  @override
  State<AdminsPage> createState() => _AdminsPageState();
}

class _AdminsPageState extends State<AdminsPage> {
  final UserLogic _userLogic = UserLogic.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: CreateAdminPage.route.goto,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot<UserModel>>(
        stream: _userLogic.getUsers(type: UserType.admin),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<UserModel>> snapshot) {
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
              "No Staffs yet, create one",
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
              final UserModel room = snapshot.data!.docs[index].data();
              return ListTile(
                leading: Text('${index + 1}.'),
                tileColor: context.theme.primaryColor.withValues(alpha: 0.05),
                splashColor: context.theme.primaryColor.withValues(alpha: 0.05),
                title: Text(
                  room.firstName ?? '',
                  style: context.textTheme.headlineSmall,
                ),
                subtitle: Text(
                  "${room.email ?? ''}\n${room.phoneNumber ?? ''}",
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
