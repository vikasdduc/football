

import 'package:fantacySports/Model/Profile.dart';

class GetTeam_2{
  String _id,_uid,_match_id,_competition_id,_team_A,_team_B;
  Profile _user;
  var _contest_total_point;

  GetTeam_2(this._id, this._uid, this._match_id, this._competition_id,
      this._team_A, this._team_B,this._user,this._contest_total_point);

  factory GetTeam_2.fromJson(dynamic json){
    return GetTeam_2(
      json["id"].toString(),
      json["uid"].toString(),
      json["match_id"].toString(),
      json["competition_id"].toString(),
      json["team_a"],
      json["team_b"],
      Profile.fromJson(json["user"]),
      json["contest_total_point"],
    );
  }

  Profile get user => _user;

  get team_B => _team_B;

  get team_A => _team_A;

  get competition_id => _competition_id;

  get match_id => _match_id;

   get contest_total_point => _contest_total_point;

  get uid => _uid;

  String get id => _id;
}