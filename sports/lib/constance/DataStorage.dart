import 'package:cookie_jar/cookie_jar.dart';
import 'package:fantacySports/Model/Anounced.dart';
import 'package:fantacySports/Model/Commentaries/commentary.dart';
import 'package:fantacySports/Model/Competition.dart';
import 'package:fantacySports/Model/Matche.dart';
import 'package:fantacySports/Model/Players.dart';
import 'package:fantacySports/Model/Scorecard/Innings.dart';
import 'package:fantacySports/Model/Soccer/soccer_player.dart';
import 'package:fantacySports/Model/contest.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Data with ChangeNotifier, DiagnosticableTreeMixin {
  List<Contest> _fileteredContests;

  List<competition> _competitionlist,
      _livecompetitionlist,
      _Compcompetitionlist,
      _Schedcompetitionlist;

  List<match> _matchlist;
  List<match> _matchLivelist;
  List<match> _matchSchedlist;
  List<match> _matchComplist;

  bool _data = false;
  List<players> selectedPlayers = new List<players>();
  List<players> teamA = new List<players>();
  List<players> teamB = new List<players>();
  List<players> teamCombine = new List<players>();

  List<Anounced> anouncedTeamA;
  List<Anounced> anouncedTeamB;

  List<innings> Innings;
  List<commentaries> CommentariesA = new List<commentaries>();
  List<commentaries> CommentariesB = new List<commentaries>();
  List<commentaries> CommentariesCombo = new List<commentaries>();

  List<SoccerPlayer> home = [], away = [], total = [];

  setSoccerTeams(SoccerPlayerResponse resp) {
    home = resp.home;
    away = resp.away;
    ConstanceData.soccerTeamA = resp.home;
    ConstanceData.soccerTeamB = resp.away;
    total.addAll(resp.home);
    total.addAll(resp.away);
    ConstanceData.soccerTeamCombine.addAll(resp.home);
    ConstanceData.soccerTeamCombine.addAll(resp.away);
    ConstanceData.soccerTeamCombine.shuffle();
    notifyListeners();
  }

  setCommentariesA(List<commentaries> list) {
    CommentariesA = list.toList(growable: false);
    print('Commentaries A ${list.length}');
    setCommentariesCombo(CommentariesA, CommentariesB);
  }

  setCommentariesB(List<commentaries> list) {
    CommentariesB = list.toList(growable: false);
    print('Commentaries B ${list.length}');
    setCommentariesCombo(CommentariesA, CommentariesB);
  }

  setCommentariesCombo(List<commentaries> list, List<commentaries> list1) {
    if (list == null || list.isEmpty) {
      print('1 ');
      print('1  ${list.length} ${list1.length}');
      List<commentaries> list3 = list1;
      CommentariesCombo.addAll(list3.toList(growable: false));
    } else if (list1 == null || list1.isEmpty) {
      print('2 ');
      print('2  ${list.length} ${list1.length}');
      List<commentaries> list3 = list;
      CommentariesCombo.addAll(list3.toList(growable: false));
    } else {
      print('3 ');
      print('3  ${list.length} ${list1.length}');
      try {
        List<commentaries> list3 = list + list1;
        CommentariesCombo.addAll(list3.toList(growable: false));
      } catch (e) {
        print('${e} ${list.length} ${list1.length}');
      }
    }
  }

  setInnings(List<innings> list) {
    Innings = list;
    print('Innings A ${list.length}');
  }

  setAnnouncedA(List<Anounced> list) {
    anouncedTeamA = list;
    print('announced A ${list.length}');
  }

  setAnnouncedB(List<Anounced> list) {
    anouncedTeamB = list;
    print('announced B ${list.length}');
  }

  setMatch(List<match> list) async {
    _matchlist = list;
  }

  addMatch(List<match> list) async {
    if (_matchlist == null) {
      _matchlist = new List<match>();
    }
    _matchlist.add(list[0]);
  }

  setSchedMatch(List<match> list) async {
    _matchSchedlist = list;
  }

  addSchedMatch(match list) async {
    if (_matchSchedlist == null) {
      _matchSchedlist = new List<match>();
    }
    _matchSchedlist.add(list);
  }

  setLiveMatch(List<match> list) async {
    _matchLivelist = list;
  }

  addLiveMatch(match list) async {
    if (_matchLivelist == null) {
      _matchLivelist = new List<match>();
    }
    _matchLivelist.add(list);
  }

  setCompMatch(List<match> list) async {
    _matchComplist = list;
  }

  addCompMatch(match list) async {
    if (_matchComplist == null) {
      _matchComplist = new List<match>();
    }
    _matchComplist.add(list);
  }

  void setCompetition(List<competition> list) {
    _competitionlist = list;
    notifyListeners();
  }

  void setLiveCompetition(List<competition> list) {
    _livecompetitionlist = list;
    print(list);
    notifyListeners();
  }

  void setSchedCompetition(List<competition> list) {
    _Schedcompetitionlist = list;
    notifyListeners();
  }

  List<Contest> get fileteredContests => _fileteredContests;

  List<competition> get competitionlist => _competitionlist;

  get livecompetitionlist => _livecompetitionlist;

  get Compcompetitionlist => _Compcompetitionlist;

  get Schedcompetitionlist => _Schedcompetitionlist;
}
