class fow{
  String _name,_batsman_id,_runs,_how_out,_overs_at_dismissal;
  int _score_at_dismissal;
  fow(this._name, this._batsman_id, this._runs, this._how_out,
      this._score_at_dismissal, this._overs_at_dismissal);

factory fow.fromJson(dynamic json) {
  return fow(
    json["name"],
    json["batsman_id"],
    json["runs"],
    json["how_out"],
    json["score_at_dismissal"],
    json["overs_at_dismissal"],
  );
}


  @override
  String toString() {
    return 'fow{_name: $_name, _batsman_id: $_batsman_id, _runs: $_runs, _how_out: $_how_out, _score_at_dismissal: $_score_at_dismissal, _overs_at_dismissal: $_overs_at_dismissal}';
  }

  get overs_at_dismissal => _overs_at_dismissal;

  get score_at_dismissal => _score_at_dismissal;

  get how_out => _how_out;

  get runs => _runs;

  get batsman_id => _batsman_id;

  String get name => _name;
}