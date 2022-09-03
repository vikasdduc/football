class bowler{

  String _name,_bowler_id,_position,_overs,_maidens,_runs_conceded,_wickets,_econ;
  bool _bowling;

  bowler(
      this._name,
      this._bowler_id,
      this._position,
      this._overs,
      this._maidens,
      this._runs_conceded,
      this._wickets,
      this._econ,
      this._bowling);

  factory bowler.fromJson(dynamic json){
    return bowler(
      json['name'],
      json['bowler_id'],
      json['position'],
      json['overs'],
      json['maidens'],
      json['runs_conceded'],
      json['wickets'],
      json['econ'],
      json['bowling']=='true'?true:false,
    );
  }

  @override
  String toString() {
    return 'bowler{_name: $_name, _bowler_id: $_bowler_id, _position: $_position, _overs: $_overs, _maidens: $_maidens, _runs_conceded: $_runs_conceded, _wickets: $_wickets, _econ: $_econ, _bowling: $_bowling}';
  }

  bool get bowling => _bowling;

  get econ => _econ;

  get wickets => _wickets;

  get runs_conceded => _runs_conceded;

  get maidens => _maidens;

  get overs => _overs;

  get position => _position;

  get bowler_id => _bowler_id;

  String get name => _name;
}