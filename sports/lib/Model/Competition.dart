
class competition{

  var _cid;
  var _title,_abbr,_category,_datestart,_dateend,_game_format,_status,_country;
  List<String>_rank_prize;

  competition(
      this._cid,
      this._title,
      this._abbr,
      this._category,
      this._datestart,
      this._dateend,
      this._game_format,
      this._status,
      this._country,this._rank_prize,);

  factory competition.fromJson(dynamic json) {
    return competition(
      json['cid'],
      json['title'],
      json['abbr'],
      json['category'],
      json['datestart'],
      json['dateend'],
      json['game_format'],
      json['status'],
      json['country'],
      json['rank_prize'].toString().split(','),
    );
  }

  get country => _country;

  get status => _status;

  List<String> get rank_prize => _rank_prize;

  get game_format => _game_format;

  get dateend => _dateend;

  get datestart => _datestart;

  get category => _category;

  get abbr => _abbr;

  String get title => _title;

  int get cid => _cid;
}