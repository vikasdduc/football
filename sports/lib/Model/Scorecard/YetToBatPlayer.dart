

class yet_to_bat_player{

  String _player_id,_name;

  yet_to_bat_player(this._player_id, this._name);

  factory yet_to_bat_player.fromJson(dynamic json){
    return yet_to_bat_player(
      json["player_id"],
      json["name"],
    );
  }

  get name => _name;

  String get player_id => _player_id;
}