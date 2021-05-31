import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget? mobile;
  final Widget? tab;
  final Widget? web;

  const ResponsiveWidget(
      {Key? key, @required this.mobile, this.tab, @required this.web})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) return mobile!;
        if (constraints.maxWidth < 1200) return tab ?? web!;
        return web!;
      },
    );
  }
}
