

class Player_Points{


  String _pid,_name,_rating,_point,_starting11;

  Player_Points(
      this._pid, this._name, this._rating, this._point, this._starting11);

  factory Player_Points.fromJson(dynamic json){
    return Player_Points(
      json["pid"],
      json["name"],
      json["rating"],
      json["point"],
      json["starting11"],
    );
  }

  get starting11 => _starting11;

  get point => _point;

  get rating => _rating;

  get name => _name;

  String get pid => _pid;
}