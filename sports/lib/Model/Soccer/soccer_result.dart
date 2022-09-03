class SoccerResult {
//   "home": "2",
//   "away": "2",
//   "winner": "draw"
  String home, away, winner;

  SoccerResult.fromJson(json){
    home = json['home']==null?'':json['home'];
    away = json['away']==null?'':json['away'];
    winner= json['winner']==null?'':json['winner'];
  }

}
