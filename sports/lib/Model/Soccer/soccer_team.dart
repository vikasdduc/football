class SoccerTeam {
  String tid, tname, logo, fullname, abbr;

  SoccerTeam.fromJson(json) {
    tid = json['tid'] == null ? '0' : json['tid'];
    tname = json['tname'] == null ? 'NA' : json['tname'];
    logo = json['logo'] == null ? '' : json['logo'];
    fullname = json['fullname'] == null ? 'NA' : json['fullname'];
    abbr = json['abbr'] == null ? 'NA' : json['abbr'];
  }
}

class SpeicifTeam{
  SoccerTeam home,away;
  SpeicifTeam.fromJson(json){
    home = SoccerTeam.fromJson(json['home']);
    away = SoccerTeam.fromJson(json['away']);
  }
}
