import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DashboardController extends GetxController {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  var title = 'Login'.obs;

  void doLogin() {
    //API
    title.value = 'Done!';
  }

  bool validate() {
    return false;
  }
}
