
import 'GetTeam_2.dart';

class leaderBoard_contest{

  var _id,_contest_id,_user_id,_match_id,_compition_id;
  GetTeam_2 _team;

  leaderBoard_contest(this._id, this._contest_id, this._user_id, this._match_id,
      this._compition_id, this._team);

  factory leaderBoard_contest.fromJson(dynamic json){
   return leaderBoard_contest(
     json['id'],
     json['contest_id'],
     json['user_id'],
     json['match_id'],
     json['compition_id'],
     GetTeam_2.fromJson(json['teams'][0]),
   );
  }

  GetTeam_2 get team => _team;

  get compition_id => _compition_id;

  get match_id => _match_id;

  get user_id => _user_id;

  get contest_id => _contest_id;

  int get id => _id;
}