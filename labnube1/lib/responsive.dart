import 'package:flutter/material.dart';

class Responsive extends StatefulWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.desktop,
    this.tablet,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 576;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 576 &&
      MediaQuery.of(context).size.width <= 992;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 992;
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width > 992) {
      return desktop;
    } else if (size.width >= 576 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    throw UnimplementedError();
  }
}
