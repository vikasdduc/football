import 'package:fantacySports/Model/WinnerItem.dart';

class winnerlist {
  var _contest_id, _compition_id, _match_id, _team_id, _prize;
  var _title,
      _result,
      _date,
      _teama_title,
      _teamb_title,
      _teama_logo,
      _teamb_logo,
      _teama_short_name,
      _teamb_short_name;
  List<winner_item> _winners;

  winnerlist(
      this._contest_id,
      this._compition_id,
      this._match_id,
      this._team_id,
      this._prize,
      this._title,
      this._result,
      this._teama_title,
      this._teamb_title,
      this._teama_logo,
      this._teamb_logo,
      this._teama_short_name,
      this._teamb_short_name,
      this._winners,
      this._date);

  factory winnerlist.fromJson(dynamic json) {
    print( json["contest_id"]);

    return winnerlist(
        json["contest_id"],
        json["compition_id"],
        json["matchDetail"]["match_id"],
        json["team_id"],
        json["contentsDetail"].isEmpty?'NA':json["contentsDetail"]["prize"],
        json["matchDetail"]["title"],
        json["matchDetail"]["result"],
        json["matchDetail"]["teama"]["name"],
        json["matchDetail"]["teamb"]["name"],
        json["matchDetail"]["teama"]["logo_url"],
        json["matchDetail"]["teamb"]["logo_url"],
        json["matchDetail"]["teama"]["short_name"],
        json["matchDetail"]["teamb"]["short_name"],
        (json["winner_list"] as List)
            .map((e) => winner_item.fromJson(e))
            .toList(),
        json["matchDetail"]["date_start"]);
  }

  get match_id => _match_id;

  List<winner_item> get winners => _winners;

  get teamb_short_name => _teamb_short_name;

  get teama_short_name => _teama_short_name;

  get teamb_logo => _teamb_logo;

  get teama_logo => _teama_logo;

  get teamb_title => _teamb_title;

  get teama_title => _teama_title;

  get result => _result;

  get date => _date;

   get title => _title;

  get prize => _prize;

  get team_id => _team_id;

  get compition_id => _compition_id;

  get contest_id => _contest_id;
}
