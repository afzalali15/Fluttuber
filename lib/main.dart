import 'package:flutter/material.dart';
import 'package:fluttuber/constants/routes.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Top 30 Channels',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'MPLUSRounded',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: AppPages.routes,
    );
  }
}
