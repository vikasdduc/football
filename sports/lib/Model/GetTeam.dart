

class GetTeam{
  String _id,_uid,_match_id,_competition_id,_team_A,_team_B;

  GetTeam(this._id, this._uid, this._match_id, this._competition_id,
      this._team_A, this._team_B);

  factory GetTeam.fromJson(dynamic json){
    return GetTeam(
      json["id"].toString(),
      json["uid"],
      json["match_id"],
      json["competition_id"],
      json["team_a"],
      json["team_b"],
    );
  }

  get team_B => _team_B;

  get team_A => _team_A;

  get competition_id => _competition_id;

  get match_id => _match_id;

  get uid => _uid;

  String get id => _id;
}