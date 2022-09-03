

class batsman{
  String _name,_batsman_id,_position,_role,_role_str,_runs,_balls_faced,_fours,_sixes,_how_out,_strike_rate;
  bool _batting;

  batsman(
      this._name,
      this._batsman_id,
      this._position,
      this._role,
      this._role_str,
      this._runs,
      this._balls_faced,
      this._fours,
      this._sixes,
      this._how_out,
      this._strike_rate,
      this._batting);

  factory batsman.fromJson(dynamic json){
    return batsman(
      json["name"],
      json["batsman_id"],
      json["position"],
      json["role"],
      json["role_str"],
      json["runs"],
      json["balls_faced"],
      json["fours"],
      json["sixes"],
      json["how_out"],
      json["strike_rate"],
      json["batting"]=='true'?true : false,
    );
  }

  @override
  String toString() {
    return 'batsman{_name: $_name, _batsman_id: $_batsman_id, _position: $_position, _role: $_role, _role_str: $_role_str, _runs: $_runs, _balls_faced: $_balls_faced, _fours: $_fours, _sixes: $_sixes, _how_out: $_how_out, _strike_rate: $_strike_rate, _batting: $_batting}';
  }

  bool get batting => _batting;

  get strike_rate => _strike_rate;

  get how_out => _how_out;

  get sixes => _sixes;

  get fours => _fours;

  get balls_faced => _balls_faced;

  get runs => _runs;

  get role_str => _role_str;

  get role => _role;

  get position => _position;

  get batsman_id => _batsman_id;

  String get name => _name;
}