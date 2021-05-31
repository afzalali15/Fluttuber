import 'package:fluttuber/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:fluttuber/models/channel_info.dart';

class YouTubeManager {
  Future<Item?> getChannelInfo(String channelId) async {
    var url =
        'https://youtube.googleapis.com/youtube/v3/channels?part=statistics%2C%20snippet&id=$channelId&key=${Constants.YOUTUBE_API_KEY}';

    try {
      final response = await http.get(Uri.parse(url));
      var channelInfo = channelInfoFromJson(response.body);
      return channelInfo.items?.first;
    } catch (e) {
      print('Error fetching data : $url');
      return null;
    }
  }
}
