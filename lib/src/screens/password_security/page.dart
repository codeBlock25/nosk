import 'package:flutter/material.dart';
import 'package:nosk/src/route/route.dart';

class PasswordSecurityPage extends RouteFulWidget {
  const PasswordSecurityPage({super.key});

  static PasswordSecurityPage get route => const PasswordSecurityPage();

  @override
  State<PasswordSecurityPage> createState() => _PasswordSecurityPageState();

  @override
  String path() => '/setting/password-security';

  @override
  String title() => 'Password & Security';
}

class _PasswordSecurityPageState extends State<PasswordSecurityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
