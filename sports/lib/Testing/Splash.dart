import 'dart:math';
import 'package:fantacySports/constance/DataStorage.dart';
import 'package:fantacySports/constance/constance.dart' as constance;
import 'package:fantacySports/Networking/AccessNetwork.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/src/provider.dart';

import '../main.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: Color(0xff7E0000),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "assets/images/splashscreen.webp",
            fit: BoxFit.cover,
          ),
        ),
        LoadingAnimationWidget.discreteCircle(
          color: Colors.red,
          size: 50,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    // fetchCompetition();

    // fetchLiveCompetition();
    // fetchUpcomingCompetition();
    Future.delayed(Duration(seconds: 1), () async{
      fetchLiveMatches(await ConstanceData.getId());
      fetchupcoming_match_user(await ConstanceData.getId());
      fetchCompletedMatches(await ConstanceData.getId());
      fetchUpcomingMatches();
      fetchTeams(await ConstanceData.getId());
      fetchJoinedMatches(await ConstanceData.getId());
    });
    try {
      fetchLEvel();
    } catch (e) {
      print(e);
    }

    try {
      fetchuser_play_history();
    } catch (e) {
      print(e);
    }
    fetch_fantasy_point_brekdown();

    // fetchContest();
    fetchNotification();
    fetchLeaderboard();
    fetchBanner();
    Future.delayed(Duration(seconds: 8), () async {
      ConstanceData.id = await ConstanceData.getId();
      ConstanceData.access_token = await ConstanceData.getToken();
      // print(ConstanceData.getId());
      // print(ConstanceData.getProf());
      if (ConstanceData.access_token != null && ConstanceData.id != null) {
        Navigator.pushReplacementNamed(context, Routes.HOME);
      } else {
        Navigator.pushReplacementNamed(context, Routes.HOST);
      }
    });
  }

  void fetchCompetition() {
    access_network()
        .fetchCompetition(constance.CompetitionType.def)
        .then((value) => {
              ConstanceData.setCompetition(value),
              ConstanceData.filterCompetition(value),
              ConstanceData.competitionNo = Random().nextInt(value.length),
              for (var i in ConstanceData.filteredcompetitionlist)
                {
                  access_network()
                      .fetchMatches(i.cid.toString())
                      .then((value) => {
                            if (mounted)
                              {
                                setState(() {
                                  ConstanceData.addMatch(value);
                                  ConstanceData.addIDs(i.cid.toString());
                                })
                              }
                            else
                              {ConstanceData.addMatch(value)},
                            ConstanceData.addIDs(i.cid.toString()),
                          }),
                }
            });
  }

  // void fetchLiveCompetition() {
  //   access_network().fetchMatches('3').then((value) => {
  //         for (var i in value)
  //           {
  //             if (i.status_str.toString() != 'Completed' && i.status == 3)
  //               {
  //                 if (mounted)
  //                   {
  //                     setState(() {
  //                       ConstanceData.addLiveMatch(i);
  //                       ConstanceData.addLiveIDs(i.cid.toString());
  //                     })
  //                   }
  //                 else
  //                   {
  //                     ConstanceData.addLiveMatch(i),
  //                     ConstanceData.addLiveIDs(i.cid.toString()),
  //                   },
  //               }
  //             else
  //               {
  //                 print(i.date_start.toString()),
  //                 print(i.title),
  //                 if (mounted)
  //                   {
  //                     setState(() {
  //                       ConstanceData.addCompMatch(i);
  //                       ConstanceData.addCompIDs(i.cid.toString());
  //                     })
  //                   }
  //                 else
  //                   {
  //                     ConstanceData.addCompMatch(i),
  //                     ConstanceData.addCompIDs(i.cid.toString()),
  //                   },
  //               }
  //           },
  //       });
  // }

  void fetchCompletedMatches(id) {
    try {
      access_network()
          .get_competed_match(id.toString(),0)
          .then((value) => {
                ConstanceData.setCompMatch(value),
              });
    } catch (e) {
      print(e);
    }
  }

  void fetchLiveMatches(id) {
    try {
      access_network()
          .get_live_match(id.toString())
          .then((value) => {
                ConstanceData.setLiveMatch(value),
              });
    } catch (e) {
      print(e);
    }
  }
  void fetchupcoming_match_user(id) {
    try {
      access_network()
          .get_upcoming_match_user(id.toString())
          .then((value) => {
                ConstanceData.matchUpcominglist=value,
              });
    } catch (e) {
      print(e);
    }
  }

  // void fetchUpcomingCompetition() {
  //   access_network().fetchMatches('1').then((value) => {
  //         for (var j in value)
  //           {
  //             if (Compare_Date_upcoming(
  //                 j.date_start.toString().split(' ')[0].split('-')))
  //               {
  //                 if (mounted)
  //                   {
  //                     setState(() {
  //                       ConstanceData.addSchedMatch(j);
  //                       ConstanceData.addSchedIDs(j.cid.toString());
  //                     })
  //                   }
  //                 else
  //                   {
  //                     ConstanceData.addSchedMatch(j),
  //                     ConstanceData.addSchedIDs(j.cid.toString()),
  //                   },
  //               }
  //             else
  //               {
  //                 if (mounted)
  //                   {
  //                     setState(() {
  //                       ConstanceData.addLiveMatch(j);
  //                       ConstanceData.addLiveIDs(j.cid.toString());
  //                     })
  //                   }
  //                 else
  //                   {
  //                     ConstanceData.addLiveMatch(j),
  //                     ConstanceData.addLiveIDs(j.cid.toString()),
  //                   },
  //               }
  //           }
  //       });
  // }

  // void fetchContest() {
  //   access_network().getCompletions().then((value) => {
  //         ConstanceData.setContests(value),
  //       });
  // }

  void fetchLEvel() {
    access_network().level(ConstanceData.prof.id.toString()).then((value) => {
          ConstanceData.setLvl(value),
        });
    access_network()
        .get_series_list(ConstanceData.prof.id.toString())
        .then((_) {
      ConstanceData.setSeriesPlayeds(_);
    });
  }

  void fetchNotification() {
    access_network().getNotification().then((value) => {
          ConstanceData.notifications = value,
        });
  }

  void fetchLeaderboard() {
    access_network().leader_board().then((value) => {
          ConstanceData.setleaderboard(value),
        });
  }

  void fetchuser_play_history() {
    access_network()
        .user_play_history(ConstanceData.prof.id.toString())
        .then((value) => {
              ConstanceData.setLeader(value),
            });
  }

  void fetch_fantasy_point_brekdown() {
    access_network().fantasy_point_brekdown().then((_) {
      ConstanceData.listOne = _['one'];
      ConstanceData.listBonus = _['bonus'];
      ConstanceData.listEconomy = _['economy'];
      ConstanceData.listStrike = _['strike'];
    });
  }

  CompareDate(datestart) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var date = formattedDate.toString().split('-');
    if (int.parse(datestart[0].toString()) == int.parse(date[0])) {
      if (int.parse(datestart[1].toString()) == int.parse(date[1])) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Compare_Date_live(List<String> datestart) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var date = formattedDate.toString().split('-');
    if (int.parse(datestart[2].toString()) >= int.parse(date[2]) &&
        int.parse(datestart[1].toString()) == int.parse(date[1]) &&
        (int.parse(datestart[2].toString()) - (int.parse(date[2]))) < 3) {
      return true;
    } else {
      print('to ${date} ${datestart}');
      return false;
    }
  }

  Compare_Date_upcoming(List<String> datestart) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var date = formattedDate.toString().split('-');
    if (int.parse(datestart[2].toString()) >= int.parse(date[2]) &&
        (int.parse(datestart[2].toString()) - (int.parse(date[2]))) > 3) {
      return true;
    } else {
      return false;
    }
  }

  Compare_Date_live2(List<String> time, datestart) {
    var now = new DateTime.now();
    var formattertime = new DateFormat('Hm');
    String formattedTime = formattertime.format(now);
    var Time = formattedTime.toString().split(':');
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var date = formattedDate.toString().split('-');
    int hour = int.parse(time[0]);

    if (int.parse(date[2]) == int.parse(datestart[2].toString())) {
      print('fsvm');
      return true;
    } else {
      return true;
    }
  }

  void fetchBanner() async {
    access_network().banner_list().then((_) {
      setState(() {
        ConstanceData.setBanner(_);
      });
    });
  }

  void fetchUpcomingMatches() async {
    access_network().fetchUpcomingMatches(0).then((_) {
      if (mounted) {
        setState(() {
          ConstanceData.setSchedMatch(_);
        });
      } else {
        ConstanceData.setSchedMatch(_);
      }
    });
  }
  void fetchJoinedMatches(id) async {
    access_network().fetchJoinedMatches(id).then((_) {
      if (mounted) {
        setState(() {
          ConstanceData.setJoinedMatch(_);
        });
      } else {
        ConstanceData.setJoinedMatch(_);
      }
    });
  }

  void fetchTeams(id) async{
    access_network().getTeamWithID(id).then((value) => {
      setValues(value),
    });
  }
  setValues(value) {
    if (value != null && value.length != 0) {
      setState(() {
        ConstanceData.setMyList(value);
      });
    } else {}
  }
}
