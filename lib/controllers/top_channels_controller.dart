import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttuber/constants/constants.dart';
import 'package:fluttuber/constants/youtube_channels.dart';
import 'package:fluttuber/models/channel_info.dart';
import 'package:fluttuber/services/youtube_manager.dart';
import 'package:fluttuber/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class TopChannelsController extends GetxController {
  ScreenshotController screenshotController = ScreenshotController();
  var topFlutterChannels = RxList<Item>();
  var message = ''.obs;
  var isLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    populateChannels();
  }

  void populateChannels() async {
    if (Constants.YOUTUBE_API_KEY.isEmpty) {
      print('Please provide valid YouTube API Key in constants.dart file to fetch the results.');
      isLoaded.value = true;
      return;
    }
    var rawData = RxList<Item>();
    message('Talking to clouds...');
    for (String channelId in YOUTUBE_CHANNELS.keys) {
      var channelInfo = await YouTubeManager().getChannelInfo(channelId);
      if (channelInfo != null) rawData.add(channelInfo);
    }
    message('Analyzing bits and bytes...');
    await Future.delayed(1.seconds);
    rawData.sort(
        (a, b) => int.parse(b.statistics?.subscriberCount ?? '0').compareTo(int.parse(a.statistics?.subscriberCount ?? '0')));
    message('Almost done!');
    await Future.delayed(300.milliseconds);
    topFlutterChannels.value = rawData.take(Constants.RESULT_COUNT).toList();
    isLoaded(true);
  }

  void copyToClipBoard() {
    var message = 'Top 30 Flutter Youtubers \n https://fluttuber-codex.web.app';
    Clipboard.setData(ClipboardData(text: message));
    Get.snackbar(
      'Copied to Clipboard',
      '',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
    );
  }
}
