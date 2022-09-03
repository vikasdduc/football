import 'soccer_competition.dart';

class SoccerCompResponse {
  bool status;
  List<SoccerCompetition> competition;
  int total_items, total_pages;

  SoccerCompResponse.fromJson(json) {
    status = json['status'] == 'ok' ? true : false;
    competition =
        json['response']['items'] == null ? [] : (json['response']['items'] as List).map((e) => SoccerCompetition.fromJson(e)).toList();
    total_items = json['response']['total_items'] == null
        ? 0
        : json['response']['total_items'];
    total_pages = json['response']['total_pages'] == null
        ? 0
        : json['response']['total_pages'];
  }
  SoccerCompResponse.withError(){
    status = false;
  }
}
