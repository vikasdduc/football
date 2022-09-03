

class players{

  int _pid;
  String _title,_short_title,_country,_playing_role,_batting_style,_bowling_style,_nationality;
  dynamic _fantasy_player_rating;

  players(
      this._pid,
      this._title,
      this._short_title,
      this._country,
      this._playing_role,
      this._batting_style,
      this._bowling_style,
      this._fantasy_player_rating,
      this._nationality);

  factory players.fromJson(dynamic json){
    return players(
      json['pid'],
      json['title'],
      json['short_name'],
      json['country'],
      json['playing_role'],
      json['batting_style'],
      json['bowling_style'],
      json['fantasy_player_rating'],
      json['nationality'],
    );
  }

  get nationality => _nationality;

  get fantasy_player_rating => _fantasy_player_rating;

  get bowling_style => _bowling_style;

  get batting_style => _batting_style;

  get playing_role => _playing_role;

  get country => _country;

  get short_title => _short_title;

  String get title => _title;

  int get pid => _pid;
}