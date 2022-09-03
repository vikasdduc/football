import 'package:fantacySports/Model/Scorecard/ExtraRuns.dart';
import 'package:fantacySports/Model/Scorecard/FOW.dart';

import 'Batsman.dart';
import 'Bowler.dart';
import 'YetToBatPlayer.dart';

class innings {
  int _iid, _number, _status, _result, _batting_team_id, _fielding_team_id;
  String _short_name, _scores, _scores_full;
  List<batsman> _batsmen;
  List<bowler> _bowlers;
  List<fow> _fows;
  extra_runs _extra_runs;
  List<yet_to_bat_player> _did_not_bat;

  innings(
      this._iid,
      this._number,
      this._status,
      this._result,
      this._batting_team_id,
      this._fielding_team_id,
      this._short_name,
      this._scores,
      this._scores_full,
      this._batsmen,
      this._bowlers,
      this._fows,
      this._extra_runs,
      this._did_not_bat);

  factory innings.fromJson(dynamic json) {
    return innings(
      json["iid"],
      json["number"],
      json["status"],
      json["result"],
      json["batting_team_id"],
      json["fielding_team_id"],
      json["short_name"],
      json["scores"],
      json["scores_full"],
      (json["batsmen"] as List).map((e) => batsman.fromJson(e)).toList(growable: false),
      (json["bowlers"] as List).map((e) => bowler.fromJson(e)).toList(growable: false),
      (json["fows"] as List).map((e) => fow.fromJson(e)).toList(growable: false),
      extra_runs.fromJson(json["extra_runs"]),
      (json["did_not_bat"] as List)
          .map((e) => yet_to_bat_player.fromJson(e))
          .toList(growable: false),
    );
  }

  @override
  String toString() {
    return 'innings{_iid: $_iid, _number: $_number, _status: $_status, _result: $_result, _batting_team_id: $_batting_team_id, _fielding_team_id: $_fielding_team_id, _short_name: $_short_name, _scores: $_scores, _scores_full: $_scores_full, _batsmen: $_batsmen, _bowlers: $_bowlers, _fows: $_fows, _extra_runs: $_extra_runs, _did_not_bat: $_did_not_bat}';
  }

  List<yet_to_bat_player> get did_not_bat => _did_not_bat.toList(growable: false);

  extra_runs get extra_run => _extra_runs;

  List<fow> get fows => _fows.toList(growable: false);

  List<bowler> get bowlers => _bowlers.toList(growable: false);

  List<batsman> get batsmen => _batsmen.toList(growable: false);

  get scores_full => _scores_full;

  get scores => _scores;

  String get short_name => _short_name;

  get fielding_team_id => _fielding_team_id;

  get batting_team_id => _batting_team_id;

  get result => _result;

  get status => _status;

  get number => _number;

  int get iid => _iid;
}
