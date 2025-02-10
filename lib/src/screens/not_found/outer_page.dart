import 'package:flutter/material.dart';
import 'package:nosk/src/route/route.dart';

class OuterPageNotFound extends RouteFulWidget {
  const OuterPageNotFound({super.key});

  static OuterPageNotFound get route => const OuterPageNotFound();

  @override
  State<OuterPageNotFound> createState() => _OuterPageNotFoundState();

  @override
  String path() => '/not-found';

  @override
  String title() => '404 Page';
}

class _OuterPageNotFoundState extends State<OuterPageNotFound> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
