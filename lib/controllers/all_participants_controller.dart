import 'package:fluttuber/constants/youtube_channels.dart';
import 'package:fluttuber/models/participant_info.dart';
import 'package:get/state_manager.dart';

class AllParticipantsController extends GetxController {
  var allChannels = RxList<ParticipantInfo>();
  @override
  void onInit() {
    super.onInit();
    populateParticipants();
  }

  void populateParticipants() {
    YOUTUBE_CHANNELS.forEach((key, value) {
      allChannels.add(ParticipantInfo(value, key));
    });
  }
}
