class Player {
  String _Name, _pic, _role, _team;
  int  _point;
  double _sel,_credit;
  bool _playedlast, _selected;

  Player(this._Name, this._pic, this._role, this._team, this._sel, this._point,
      this._credit, this._playedlast, this._selected);

  get selected => _selected;

  set selected(value) {
    _selected = value;
  }

  bool get playedlast => _playedlast;

  set playedlast(bool value) {
    _playedlast = value;
  }

  get credit => _credit;

  set credit(value) {
    _credit = value;
  }

  get point => _point;

  set point(value) {
    _point = value;
  }

  double get sel => _sel;

  set sel(double value) {
    _sel = value;
  }

  get team => _team;

  set team(value) {
    _team = value;
  }

  get role => _role;

  set role(value) {
    _role = value;
  }

  get pic => _pic;

  set pic(value) {
    _pic = value;
  }

  String get Name => _Name;

  set Name(String value) {
    _Name = value;
  }
}
