import 'package:flutter/material.dart';
import 'package:nosk/src/route/route.dart';

class InnerPageNotFound extends RouteFulWidget {
  const InnerPageNotFound({super.key});

  static InnerPageNotFound get route => const InnerPageNotFound();

  @override
  State<InnerPageNotFound> createState() => _InnerPageNotFoundState();

  @override
  String path() => '/inner-not-found';

  @override
  String title() => '404 Page';
}

class _InnerPageNotFoundState extends State<InnerPageNotFound> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
