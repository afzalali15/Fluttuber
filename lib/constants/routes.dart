import 'package:fluttuber/views/pages/all_participants_page.dart';
import 'package:fluttuber/views/pages/dashboard_page.dart';
import 'package:fluttuber/views/pages/top_channels.dart';
import 'package:get/get.dart';

class AppPages {
  static List<GetPage> routes = [
    GetPage(name: '/', page: () => DashboardPage()),
    GetPage(name: '/top_channels', page: () => TopChannels()),
    GetPage(name: '/all_participants', page: () => AllParticipantsPage()),
  ];
}
