

class team{
  int _team_id;
  String _name,_short_name,_logo_url,_thumb_url,_scores;

  team(this._team_id, this._name, this._short_name, this._logo_url,
      this._thumb_url, this._scores);

  factory team.fromJson(dynamic json) {
   return team(
     json['team_id'],
     json['name'],
     json['short_name'],
     json['logo_url'],
     json['thumb_url'],
     json['scores']
   );
  }

  get scores => _scores;

  get thumb_url => _thumb_url;

  get logo_url => _logo_url;

  get short_name => _short_name;

  String get name => _name;

  int get team_id => _team_id;
}