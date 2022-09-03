

class total_level{
  var _total_point;
  String _user_level;

  total_level(this._total_point, this._user_level);

  factory total_level.fromJson(dynamic json){
    return total_level(
      json["total_point"],
      json["user_level"],
    );
  }

  String get user_level => _user_level;

 get total_point => _total_point;
}