

class leaderboard_outside{

  String _user_id,_name,_team_a,_team_b;
  var _points,_rank,_team_id;

  get team_id => _team_id;

  leaderboard_outside(this._user_id, this._name, this._points, this._rank,this._team_a,this._team_b,this._team_id);

  factory leaderboard_outside.fromJson(json){
    return leaderboard_outside(
      json['user_id'],
      json['name'],
      json['points'],
      json['rank'],
      json['team_a'],
      json['team_b'],
      json['team_id'],
    );
  }

  get rank => _rank;

  get points => _points;

  get team_a => _team_a;

  get name => _name;

  String get user_id => _user_id;

  get team_b => _team_b;
}