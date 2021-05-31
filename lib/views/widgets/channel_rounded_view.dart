import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:fluttuber/models/channel_info.dart';
import 'package:fluttuber/utils/helpers.dart';
import 'package:get/get.dart';

class ChannelRoundedView extends StatelessWidget {
  final Item flutterChannel;
  final int index;
  final FirebaseAnalytics? analytics;

  const ChannelRoundedView({
    Key? key,
    required this.flutterChannel,
    required this.index,
    this.analytics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 36,
              backgroundImage: Image.network(flutterChannel
                          .snippet?.thumbnails?.thumbnailsDefault?.url ??
                      '')
                  .image,
            ),
            Positioned(
              right: -16,
              bottom: -8,
              child: Chip(
                label: Text(
                  '#${index + 1}',
                  style: Get.textTheme.bodyText1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        MaterialButton(
          onPressed: () async {
            Helper.launchInBrowser(
                'https://youtube.com/channel/${flutterChannel.id}');
            await analytics?.logEvent(
              name: 'channel_opened',
              parameters: <String, dynamic>{
                'id': '${flutterChannel.id}',
                'channel_name': '${flutterChannel.snippet?.title}',
              },
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${flutterChannel.snippet?.title}',
                overflow: TextOverflow.ellipsis,
                style: Get.textTheme.bodyText1?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.open_in_new_rounded,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        Text(
          Helper.nFormatter(int.parse(
                  flutterChannel.statistics?.subscriberCount ?? '0')) +
              ' Subscribers',
          style: Get.textTheme.bodyText2?.copyWith(color: Colors.white54),
        ),
      ],
    );
  }
}
