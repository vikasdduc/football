import 'Team.dart';

class match_new {
  var _match_id,
      _compition_id,
      _total_match,
      _total_contest,
  _total_teams,
  _total_winner_amount;
  String _title,
      _short_title,
      _subtitle,
      _format_str,
      _status_str,
      _status_note,
      _format,
      _status,
      _date_end,
      _date_start;
  team _teama, _teamb;

  match_new(
    this._match_id,
    this._compition_id,
    this._title,
    this._short_title,
    this._subtitle,
    this._format,
    this._format_str,
    this._status,
    this._status_str,
    this._status_note,
    this._teama,
    this._teamb,
    this._date_start,
    this._date_end,
    this._total_match,
    this._total_contest,
    this._total_winner_amount,
      this._total_teams,
      );

  factory match_new.fromJson(dynamic json) {
    return match_new(
      json['match_id'],
      json['compition_id'],
      json['title'],
      json['short_title'],
      json['subtitle'],
      json['format'],
      json['format_str'],
      json['status'],
      json['status_str'],
      json['status_note'],
      team.fromJson(json['teama']),
      team.fromJson(json['teamb']),
      json['date_start'],
      json['date_end'],
      json['total_match'],
      json['total_contest'],
      json['total_winner_amount'],
      json['total_teams'],
    );
  }

  get teamb => _teamb;

  team get teama => _teama;

  get date_start => _date_start;

  get date_end => _date_end;

  get total_match => _total_match;

  get status_note => _status_note;

  get compition_id => _compition_id;
  get cid => _compition_id;

  get status_str => _status_str;

  get format_str => _format_str;

  get subtitle => _subtitle;

  get short_title => _short_title;

  String get title => _title;

  get status => _status;

  get format => _format;

  int get match_id => _match_id;

  get total_contest => _total_contest;

  get total_teams => _total_teams;

  get total_winner_amount => _total_winner_amount;
}
