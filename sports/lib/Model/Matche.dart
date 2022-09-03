import 'package:fantacySports/Model/Competition.dart';
import 'package:fantacySports/Model/Team.dart';

class match {
  var _match_id, _format, _status, _cid;
  var _title,
      _short_title,
      _subtitle,
      _format_str,
      _status_str,
      _status_note,
      _date_end,
      _date_start,_total_contest,_total_teams,_total_winner_amount,_mega_price;
  team _teama, _teamb;
  competition _competition;

  match(
    this._match_id,
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
    this._cid,
    this._date_start,
    this._date_end,
    this._competition,
      this._total_teams,
  this._total_contest,
  this._total_winner_amount,
  this._mega_price,
  );

  factory match.fromJson(dynamic json) {
    return match(
      json['match_id'],
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
      json['competition']['cid'],
      json['date_start_ist'],
      json['date_end'],
      competition.fromJson(json['competition']),
      json['total_teams']==null?0:json['total_teams'],
      json['total_contest']==null?0:json['total_contest'],
      json['total_winner_amount']==null?0:json['total_winner_amount'],
      json['mega_price'],
    );
  }

  competition get Competition => _competition;

  get teamb => _teamb;

  team get teama => _teama;

  get status_note => _status_note;

  get mega_price => _mega_price;

  get status_str => _status_str;

  get status => _status;

  get format_str => _format_str;

  get format => _format;

  get subtitle => _subtitle;

  get short_title => _short_title;

  String get title => _title;

  int get match_id => _match_id;

  set setcid(value) {
    _cid = value;
  }

  get total_winner_amount => _total_winner_amount;

  get total_contest => _total_contest;

  get date_end => _date_end;

  get cid => _cid;

  get date_start => _date_start;

  get total_teams => _total_teams;


}
