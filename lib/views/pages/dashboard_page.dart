import 'dart:async';
import 'dart:math';
import 'package:fluttuber/constants/styles.dart';
import 'package:fluttuber/controllers/dashboard_controller.dart';
import 'package:fluttuber/utils/helpers.dart';
import 'package:fluttuber/utils/responsive_size.dart';
import 'package:fluttuber/utils/responsive_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttuber/constants/colors.dart';

class DashboardPage extends StatefulWidget {
  final String? title;
  const DashboardPage({Key? key, this.title}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  FixedExtentScrollController _scrollController = FixedExtentScrollController();
  int currentPosition = 0;
  DashboardController _pageController = DashboardController();

  @override
  void initState() {
    super.initState();
    Timer.periodic(2.seconds, (t) {
      currentPosition++;
      _scrollController.animateToItem(currentPosition, duration: 300.milliseconds, curve: Curves.easeInCubic);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            // Positioned(
            //   left: 0,
            //   bottom: 0,
            //   child: Opacity(
            //     opacity: 0.2,
            //     child: FlutterLogo(
            //       size: ResponsiveSize.getValue(constraints, 64, 128, 256),
            //     ),
            //   ),
            // ),
            SingleChildScrollView(
              padding: EdgeInsets.only(
                  left: ResponsiveSize.getValue(constraints, 32, 64, 200),
                  right: ResponsiveSize.getValue(constraints, 32, 64, 200),
                  top: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.title ?? '',
                    style: TextStyle(),
                  ),
                  TextField(
                    controller: _pageController.usernamecontroller,
                    style: Styles.inputTextStyle(),
                  ),
                  TextField(
                    controller: _pageController.usernamecontroller,
                  ),
                  ResponsiveWidget(
                    web: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildImage(constraints),
                        buildIntro(),
                      ],
                    ),
                    mobile: Column(
                      children: [
                        buildImage(constraints),
                        buildIntro(),
                      ],
                    ),
                  ),
                  SizedBox(height: ResponsiveSize.getValue(constraints, 24, 48, 72)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      verticalDirection: VerticalDirection.up,
                      spacing: 8,
                      runSpacing: 16,
                      children: [
                        ActionCard(
                          image: 'assets/images/bmc_logo.png',
                          boldText: 'Support',
                          normalText: 'Developer 😍',
                          constraints: constraints,
                          onPressed: () {
                            Helper.launchInBrowser('https://www.buymeacoffee.com/afzalali15');
                          },
                        ),
                        ActionCard(
                          image: 'assets/images/submit_channel.png',
                          boldText: 'Submit',
                          normalText: 'Your Channel',
                          constraints: constraints,
                          onPressed: () {
                            Get.snackbar(
                              'Coming soon...',
                              'Expedite development by contributing on BMC',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.white,
                              duration: Duration(seconds: 5),
                              icon: Image.asset('assets/images/bmc_logo.png'),
                            );
                          },
                        ),
                        ActionCard(
                          image: 'assets/images/participants.png',
                          boldText: 'All',
                          normalText: 'Participants',
                          constraints: constraints,
                          onPressed: () {
                            Get.toNamed('/all_participants');
                          },
                        ),
                        ActionCard(
                          image: 'assets/images/trophy.png',
                          boldText: 'Top 30',
                          normalText: 'Channels',
                          constraints: constraints,
                          onPressed: () {
                            Get.toNamed('/top_channels');
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: RichText(
                      text: TextSpan(
                        style: Get.textTheme.bodyText1?.copyWith(color: Colors.white, fontSize: 12),
                        children: [
                          TextSpan(text: 'Made with '),
                          WidgetSpan(
                              child: Image.asset(
                            'assets/images/heart.png',
                            height: 18,
                          )),
                          TextSpan(text: ' in Flutter'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildIntro() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        RichText(
          textAlign: TextAlign.right,
          text: TextSpan(
            style: Get.textTheme.headline4?.copyWith(color: Colors.white),
            children: [
              TextSpan(
                text: 'Welcome 👋',
              ),
              TextSpan(
                text: '\nFlutter Community',
              ),
            ],
          ),
        ),
        SizedBox(height: 64),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 50,
              width: 100,
              child: AbsorbPointer(
                absorbing: true,
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 50,
                  diameterRatio: 0.5,
                  clipBehavior: Clip.antiAlias,
                  controller: _scrollController,
                  physics: FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: [
                      Text(
                        'learn',
                        style: TextStyle(fontSize: 36, color: Colors.white70),
                      ),
                      Text(
                        'build',
                        style: TextStyle(fontSize: 36, color: Colors.white70),
                      ),
                      Text(
                        'grow',
                        style: TextStyle(fontSize: 36, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              ' Together',
              style: Get.textTheme.headline4?.copyWith(fontSize: 36, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  Image buildImage(BoxConstraints constraints) {
    return Image.asset(
      'assets/images/fluttuber_art.png',
      width: max(200, constraints.maxWidth / 3),
    );
  }
}

class ActionCard extends StatelessWidget {
  final String? image;
  final String? boldText;
  final String? normalText;
  final VoidCallback? onPressed;
  final BoxConstraints? constraints;

  const ActionCard({
    Key? key,
    @required this.image,
    @required this.boldText,
    @required this.normalText,
    this.onPressed,
    @required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed ?? () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        height: ResponsiveSize.getValue(constraints!, 160, 200, 220),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: AspectRatio(
          aspectRatio: 0.75,
          child: Column(
            children: [
              Image.asset(
                image ?? 'images/trophy.png',
                width: ResponsiveSize.getValue(constraints!, 50, 80, 100),
              ),
              SizedBox(height: 12),
              Text(
                boldText ?? 'Subscribe',
                style: TextStyle(
                    fontSize: ResponsiveSize.getValue(constraints!, 16, 18, 20), fontWeight: FontWeight.bold, height: 1),
              ),
              Text(
                normalText ?? 'For more..',
                style: TextStyle(
                  fontSize: ResponsiveSize.getValue(constraints!, 12, 18, 20),
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
