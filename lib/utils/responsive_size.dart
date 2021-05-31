import 'package:flutter/material.dart';

class ResponsiveSize {
  static double getValue(
      BoxConstraints constraints, double mobile, double tab, double web) {
    if (constraints.maxWidth < 700) return mobile;
    if (constraints.maxWidth < 1200) return tab;
    return web;
  }
}
