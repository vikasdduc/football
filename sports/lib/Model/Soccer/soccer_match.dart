import 'package:fantacySports/Model/Soccer/periods.dart';
import 'package:fantacySports/Model/Soccer/soccer_competition.dart';
import 'package:fantacySports/Model/Soccer/soccer_result.dart';
import 'package:fantacySports/Model/Soccer/soccer_team.dart';
import 'package:fantacySports/Model/Soccer/venue.dart';

class SoccerMatch {
  String mid,
      round,
      datestart,
      dateend,
      injurytime,
      time,
      status_str,
      status,
      gamestate_str,
      gamestate,
      pre_squad,
      verified,
      periodlength,
      numberofperiods,
      attendance,
      overtimelength,title;
  SpeificPeriods periods;
  SpeicifTeam teams;
  SoccerResult result;
  SoccerCompetition competition;
  Venue venue;

  SoccerMatch.fromJson(json) {
    mid = json['mid'] == null ? '' : json['mid'];
    round = json['round'] == null ? '' : json['round'];
    datestart = json['datestart'] == null ? '' : json['datestart'];
    dateend = json['dateend'] == null ? '' : json['dateend'];
    injurytime = json['injurytime'] == null ? '' : json['injurytime'];
    time = json['time'] == null ? '' : json['time'];
    status_str = json['status_str'] == null ? '' : json['status_str'];
    gamestate_str = json['gamestate_str'] == null ? '' : json['gamestate_str'];
    gamestate = json['gamestate'] == null ? '' : json['gamestate'];
    pre_squad = json['pre_squad'] == null ? '' : json['pre_squad'];
    verified = json['verified'] == null ? '' : json['verified'];
    periodlength = json['periodlength'] == null ? '0' : json['periodlength'];
    numberofperiods =
        json['numberofperiods'] == null ? '0' : json['numberofperiods'];
    attendance = json['attendance'] == null ? '0' : json['attendance'];
    overtimelength =
        json['overtimelength'] == null ? '0' : json['overtimelength'];
    periods = SpeificPeriods.fromJson(json['periods']);
    teams = SpeicifTeam.fromJson(json['teams']);
    result = SoccerResult.fromJson(json['result']);
    competition = SoccerCompetition.fromJson(json['competition']);
    venue = Venue.fromJson(json['venue']);
    title = '${json['teams']['home']['abbr']} vs ${json['teams']['away']['abbr']}';
  }
}
