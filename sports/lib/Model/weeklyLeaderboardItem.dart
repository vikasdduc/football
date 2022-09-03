
class WeeklyLeaderboardItem{
  String _match_id,_title,_cid,_point,_team_name,_image;
 List< WeeklyLeaderboardWinner>_list;

  WeeklyLeaderboardItem(this._match_id, this._title, this._cid,this._point,this._team_name,this._image);


  factory WeeklyLeaderboardItem.fromJson(dynamic json){
    return WeeklyLeaderboardItem(
      json['match_id'].toString(),
      '',
      json['competition_id'].toString(),
      // (json['winner_list']as List).map((e)=>WeeklyLeaderboardWinner.fromJson(e)).toList(growable: false),
      json['point'].toString(),
      json['detail']['team_name'].toString(),
      json['detail']['profile_image'].toString(),
    );
  }

  // List<WeeklyLeaderboardWinner> get list => _list;

  get cid => _cid;

  get title => _title;

  get point => _point;

  get team_name => _team_name;

  get image => _image;

  String get match_id => _match_id;

  // List<WeeklyLeaderboardWinner> get list => _list;
}

class WeeklyLeaderboardWinner {
 var _id,_point;
 String _name,_team_name;

 WeeklyLeaderboardWinner(this._id, this._point, this._name, this._team_name);

 factory WeeklyLeaderboardWinner.fromJson(dynamic json){
   return WeeklyLeaderboardWinner(
     json['id'],
     json['point'],
     json['name'],
     json['team_name'],
   );
 }

  get team_name => _team_name;

  String get name => _name;

  get point => _point;

  int get id => _id;
}