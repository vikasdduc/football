class Anounced {
  String _player_id, _role, _role_str, _name;
  bool _substitute, _playing11;

  Anounced(this._player_id, this._role, this._role_str, this._name,
      this._substitute, this._playing11);

  factory Anounced.fromJson(dynamic json) {
    return Anounced(
      json["player_id"],
      json["role"],
      json["role_str"],
      json["name"],
      json["substitute"] == 'true' ? true : false,
      json["playing11"] == 'true' ? true : false,
    );
  }

  get playing11 => _playing11;

  bool get substitute => _substitute;

  get name => _name;

  get role_str => _role_str;

  get role => _role;

  String get player_id => _player_id;
}
