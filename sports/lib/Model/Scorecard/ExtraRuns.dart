
class extra_runs{
  int _byes,_legbyes,_wides,_noballs,_total;
  String _penalty;

  extra_runs(this._byes, this._legbyes, this._wides, this._noballs, this._total,
      this._penalty);

  factory extra_runs.fromJson(dynamic json){
    return extra_runs(
      json["byes"],
      json["legbyes"],
      json["wides"],
      json["noballs"],
      json["total"],
      json["penalty"]==null?'0':json["penalty"],
    );
  }


  @override
  String toString() {
    return '(byes: $_byes, legbyes: $_legbyes, wides: $_wides, noballs: $_noballs, penalty: $_penalty)';
  }

  String get penalty => _penalty;

  get total => _total;

  get noballs => _noballs;

  get wides => _wides;

  get legbyes => _legbyes;

  int get byes => _byes;
}