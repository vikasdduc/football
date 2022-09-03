

class series_leaderboard_item{
  var _point,_match_id,_user_id,_name,_team_name,_image;

  series_leaderboard_item(
      this._point, this._match_id, this._user_id, this._name, this._team_name,this._image);

  factory series_leaderboard_item.fromjson(dynamic json){
    return series_leaderboard_item(
      json["point"],
      json["match_id"],
      json["user_id"],
      json["detail"]["name"],
      json["detail"]["team_name"],
      json["detail"]["profile_image"],
    );
  }

  get team_name => _team_name;

  get name => _name;

  get user_id => _user_id;

  get match_id => _match_id;

  get image => _image;

  get point => _point;
}