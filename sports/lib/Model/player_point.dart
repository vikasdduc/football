
class player_point{
  var _pid,_name,_role,_total_point;
  bool _lastMatchPlayed;

  player_point(this._pid, this._name, this._role, this._total_point,this._lastMatchPlayed);

  factory player_point.fromJson(json){
    return player_point(
      json["pid"],
      json["name"],
      json["role"],
      json["total_point"],
      json["lastMatchPlayed"],
    );
  }

  get total_point => _total_point;

  get role => _role;

  get name => _name;

  bool get lastMatchPlayed => _lastMatchPlayed;

  get pid => _pid;
}