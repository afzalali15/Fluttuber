import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:fluttuber/constants/colors.dart';
import 'package:fluttuber/constants/constants.dart';
import 'package:fluttuber/controllers/top_channels_controller.dart';
import 'package:fluttuber/utils/helpers.dart';
import 'package:fluttuber/views/widgets/channel_rounded_view.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class TopChannels extends StatelessWidget {
  final TopChannelsController _controller = Get.put(TopChannelsController());
  GlobalKey _appBarKey = GlobalKey();
  FirebaseAnalytics _analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Container(
            key: _appBarKey,
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
                  'Top ${Constants.RESULT_COUNT} Fluttubers',
                  style: Get.textTheme.headline6?.copyWith(color: Colors.white),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.share_rounded,
                    color: Colors.white,
                  ),
                  onPressed: _controller.copyToClipBoard,
                ),
              ],
            ),
          ),
          Obx(() {
            if (!_controller.isLoaded.value)
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/loader.gif', height: 100),
                    Obx(() => Text(
                          _controller.message.value,
                          style: Get.textTheme.headline5
                              ?.copyWith(color: Colors.white),
                        )),
                  ],
                ),
              );
            return LayoutBuilder(builder: (context, constraints) {
              var renderBox =
                  _appBarKey.currentContext?.findRenderObject() as RenderBox;
              var size = renderBox.size;
              return SingleChildScrollView(
                child: Container(
                  height: Get.height - size.height,
                  child: Screenshot(
                    controller: _controller.screenshotController,
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            Helper.expectedColCount(constraints.maxWidth),
                        mainAxisExtent: 160,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 4,
                      ),
                      itemCount: _controller.topFlutterChannels.length,
                      itemBuilder: (context, index) {
                        return ChannelRoundedView(
                          flutterChannel: _controller.topFlutterChannels[index],
                          index: index,
                          analytics: _analytics,
                        );
                      },
                    ),
                  ),
                ),
              );
            });
          }),
        ],
      ),
    );
  }
}
