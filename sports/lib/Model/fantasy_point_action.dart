
class fantasy_point_action{
String _action;
var _t10,_t20,_test,_odi;

fantasy_point_action(
      this._action, this._t10, this._t20, this._test, this._odi);

factory fantasy_point_action.fromJson(json){
  return fantasy_point_action(
    json['action'],
    json['t10'],
    json['t20'],
    json['test'],
    json['odi'],
  );
}

  get odi => _odi;

  get test => _test;

  get t20 => _t20;

 get t10 => _t10;

  String get action => _action;
}