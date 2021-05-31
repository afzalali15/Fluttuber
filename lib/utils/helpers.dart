import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class Helper {
  static String nFormatter(int number) {
    if (number >= 1000000000) {
      return (number / 1000000000).toStringAsFixed(1) + 'B';
    }
    if (number >= 1000000) {
      return (number / 1000000).toStringAsFixed(1) + 'M';
    }
    if (number >= 1000) {
      return (number / 1000).toStringAsFixed(1) + 'K';
    }

    return number.toString();
  }

  static int expectedColCount(double width) {
    return (width / 180).floor();
  }

  static Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
