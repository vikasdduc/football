import 'package:fantacySports/Model/Soccer/soccer_match.dart';

class SoccerMatchResponse {
  bool status;
  List<SoccerMatch> matches;
  int total_items, total_pages;

  SoccerMatchResponse.fromJson(json) {
    status = json['status'] == 'ok' ? true : false;
    matches = json['response']['items'] == null
        ? []
        : (json['response']['items'] as List)
            .map((e) => SoccerMatch.fromJson(e))
            .toList();
    total_items = json['response']['total_items'] == null
        ? 0
        : json['response']['total_items'];
    total_pages = json['response']['total_pages'] == null
        ? 0
        : json['response']['total_pages'];
  }
  SoccerMatchResponse.withError(){
    status = false;
  }

}
