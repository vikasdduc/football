import 'Team.dart';

class upcomingMatchModel {
  var _match_id, _format, _status, _cid;
  var _title,
      _short_title,
      _subtitle,
      _format_str,
      _status_str,
      _status_note,
      _date_start;
  team _teama, _teamb;

  upcomingMatchModel(
      this._match_id,
      this._format,
      this._status,
      this._cid,
      this._title,
      this._short_title,
      this._subtitle,
      this._format_str,
      this._status_str,
      this._status_note,
      this._date_start,
      this._teama,
      this._teamb);

  factory upcomingMatchModel.fromJson(dynamic json) {
    print(json['competition_id']);
    return upcomingMatchModel(
      json['match_id'],
      json['format'],
      json['status'],
      (json['competition_id'] as List)
          .map((e) => e.toString())
          .toList()[0]
          .toString(),
      json['title'],
      json['short_title'],
      json['subtitle'],
      json['format_str'],
      json['status_str'],
      json['status_note'],
      json['date_start_ist'],
      team.fromJson(json['teama']),
      team.fromJson(json['teamb']),
    );
  }

  get teamb => _teamb;

  team get teama => _teama;

  get date_start => _date_start;

  get status_note => _status_note;

  get status_str => _status_str;

  get format_str => _format_str;

  get subtitle => _subtitle;

  get short_title => _short_title;

  get title => _title;

  get cid => _cid;

  get status => _status;

  get format => _format;

  get match_id => _match_id;
}
