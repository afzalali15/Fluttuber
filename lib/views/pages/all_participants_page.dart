import 'package:flutter/material.dart';
import 'package:fluttuber/constants/colors.dart';
import 'package:fluttuber/controllers/all_participants_controller.dart';
import 'package:fluttuber/utils/helpers.dart';
import 'package:fluttuber/utils/responsive_size.dart';
import 'package:fluttuber/views/widgets/participants_view.dart';
import 'package:get/get.dart';

class AllParticipantsPage extends StatelessWidget {
  final AllParticipantsController _controller =
      Get.put(AllParticipantsController());
  GlobalKey _participantsKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Container(
            key: _participantsKey,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(32),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.back();
                    }),
                SizedBox(width: 16),
                Text(
                  'All Participants',
                  style: Get.textTheme.headline6?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          LayoutBuilder(builder: (context, constraints) {
            var renderBox = _participantsKey.currentContext?.findRenderObject()
                as RenderBox;
            var size = renderBox.size;
            return Container(
              height: Get.height - size.height,
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 16,
                  alignment: WrapAlignment.end,
                  children:
                      List.generate(_controller.allChannels.length, (index) {
                    return MaterialButton(
                      onPressed: () {
                        Helper.launchInBrowser(
                            'https://youtube.com/channel/${_controller.allChannels[index].id}');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _controller.allChannels[index].name,
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.open_in_new_rounded,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
