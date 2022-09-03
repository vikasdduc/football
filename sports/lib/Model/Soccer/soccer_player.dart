class SoccerPlayer {
  String pid, name, positiontype, positionname, fantasy_player_rating;
  nationality nation;

  SoccerPlayer.fromJson(json) {
    pid = json['pid'];
    name = json['name'];
    positiontype = json['positiontype'];
    positionname = json['positionname'];
    fantasy_player_rating = json['fantasy_player_rating'];
    nation = nationality.fromJson(json['nationality']);
  }
}

class SoccerPlayerResponse {
  bool status;
  List<SoccerPlayer> home, away;

  SoccerPlayerResponse.fromJson(json) {
    status = json['status'] == 'ok' ? true : false;
    home = json['response']['items']['teams']['home'] == null
        ? []
        : (json['response']['items']['teams']['home'] as List)
            .map((e) => SoccerPlayer.fromJson(e))
            .toList();
    away = json['response']['items']['teams']['away'] == null
        ? []
        : (json['response']['items']['teams']['away'] as List)
        .map((e) => SoccerPlayer.fromJson(e))
        .toList();
  }

  SoccerPlayerResponse.withError() {
    status = false;
    home = [];
    away = [];
  }
}

class nationality {
  String iocid, name, ioc;

  nationality.fromJson(json) {
    iocid = json['iocid'];
    name = json['name'];
    ioc = json['ioc'];
  }
}
