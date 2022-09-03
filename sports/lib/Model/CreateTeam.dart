


class CreateTeam{

  String _uid,_match_id,_competition_id,_team_A,_team_B;

  CreateTeam(this._uid, this._match_id, this._competition_id, this._team_A,
      this._team_B);

  get team_B => _team_B;

  get team_A => _team_A;

  get competition_id => _competition_id;

  get match_id => _match_id;

  String get uid => _uid;
}