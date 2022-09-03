import 'dart:collection';
import 'dart:math';

import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/GetTeam.dart';
import 'package:fantacySports/Model/Matche.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/constance/themes.dart';
import 'package:fantacySports/modules/matchDetail/matchDetailPage.dart';
import 'package:fantacySports/widget/cardView.dart';
import 'package:flutter/material.dart';
import 'package:fantacySports/constance/constance.dart' as constance;
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Model/contest.dart';
import '../../../Networking/AccessNetwork.dart';
import '../../../widget/myContestCard.dart';

class UpComingPage extends StatefulWidget {
  @override
  _UpComingPageState createState() => _UpComingPageState();
}

class _UpComingPageState extends State<UpComingPage> {
  List<match> myLiveMatchList = new List<match>();
  List<match> LiveMatchList = new List<match>();

  @override
  Widget build(BuildContext context) {
    return ConstanceData.matchUpcominglist == null || ConstanceData.matchUpcominglist.length <= 0
        ? getEmpty()
        : Expanded(
            child: ListView.builder(
                itemCount:ConstanceData.matchUpcominglist.length,
                shrinkWrap: true,
                itemBuilder: (cont, index) {
                  match data =ConstanceData.matchUpcominglist[index];
                  int year = int.parse(data.date_start
                      .toString()
                      .split(' ')[0]
                      .toString()
                      .split('-')[0]);
                  int month = int.parse(data.date_start
                      .toString()
                      .split(' ')[0]
                      .toString()
                      .split('-')[1]);
                  int day = int.parse(data.date_start
                      .toString()
                      .split(' ')[0]
                      .toString()
                      .split('-')[2]);
                  int hour = int.parse(data.date_start
                      .toString()
                      .split(' ')[1]
                      .toString()
                      .split(':')[0]);
                  int mint = int.parse(data.date_start
                      .toString()
                      .split(' ')[1]
                      .toString()
                      .split(':')[1]);
                  int sec = int.parse(data.date_start
                      .toString()
                      .split(' ')[1]
                      .toString()
                      .split(':')[2]);
                  return MyContestCard(
                    txt1: AppLocalizations.of('${data.Competition.title}'),
                    txt2: AppLocalizations.of('${data.teama.name}'),
                    txt3: AppLocalizations.of('${data.teamb.name}'),
                    txt4: "${data.teama.short_name}",
                    setTime: data.status_str == 'Completed'
                        ? Text(
                            'Completed',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff0ebd01),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : CountdownTimer(
                            endTime: DateTime(
                                    year, month, day, hour, mint, sec)
                                .millisecondsSinceEpoch,
                            endWidget: Text(
                              'Live',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff0ebd01),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            widgetBuilder: (_, CurrentRemainingTime time) {
                              // print(time);
                              if (time == null) {
                                return Text(
                                  'Live',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff0ebd01),
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                              return Text(
                                '${getTime(time)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    txt6: "${data.teamb.short_name}",
                    txt7: AppLocalizations.of(
                        '${data.total_teams} Team'),
                    txt8:
                        '${data.total_contest} Contests',
                    image1: Image.network(
                      data.teama.logo_url,
                      fit: BoxFit.cover,
                      errorBuilder: (cont, s, d) => Center(
                        child: Icon(
                          Icons.image,
                        ),
                      ),
                    ),
                    image2: Image.network(
                      data.teamb.logo_url,
                      fit: BoxFit.cover,
                      errorBuilder: (cont, s, d) => Center(
                        child: Icon(
                          Icons.image,
                        ),
                      ),
                    ),
                    onTap: () {
                      ConstanceData.matchLiveIndex = index;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MatchDetailPage(
                            ConstanceData.matchUpcominglist,
                            ConstanceData.matchLiveIndex,
                            constance.CompetitionType.upcoming,
                            DateTime(
                                year, month, day, hour, mint, sec),
                          ),
                        ),
                      );
                    },
                  );
                }),
          );
  }
  List<GetTeam> filterContent(List<GetTeam> mylist, competition_id, match_id) {
    print('s ${mylist.length} ${match_id}');
    List<GetTeam> list = new List<GetTeam>();
    for (var i in mylist) {
      if (i.competition_id.toString() == competition_id.toString() &&
          i.match_id.toString() == match_id.toString()) {
        list.add(i);
        print(i.match_id);
      } else {}
    }
    return list;
  }
  List<Contest> filterContest(List<Contest> mylist) {
    List<Contest> list = new List<Contest>();
    try {
      for (var i in mylist) {
        if (i.user_id.toString() == ConstanceData.prof.id.toString()) {
          list.add(i);
        } else {}
      }
    } catch (e) {
      print(e);
    }
    return list;
  }
  getEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            AppLocalizations.of("You haven't joined a contest yet!"),
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Colors.black54,
                  letterSpacing: 0.6,
                  fontSize: 16,
                ),
          ),
          SizedBox(
            height: 10,
          ),
          Image.asset(
            'assets/images/upcoming.png',
            scale: 3.0,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.of('What are you waiting for?'),
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Colors.black54,
                  letterSpacing: 0.6,
                  fontSize: 14,
                ),
          ),
          SizedBox(
            height: 20,
          ),
          // GestureDetector(
          //   onTap:(){
          //
          //   },
          //   child: Card(
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(6),
          //     ),
          //     child: Container(
          //       height: 50,
          //       width: 200,
          //       decoration: BoxDecoration(
          //         color: Colors.green,
          //         borderRadius: BorderRadius.circular(6),
          //       ),
          //       child: Center(
          //         child: Text(
          //           AppLocalizations.of('View Upcoming Matches'),
          //           style: Theme.of(context).textTheme.caption.copyWith(
          //             color: Colors.white,
          //             letterSpacing: 0.6,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 14,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  getTotalHours(CurrentRemainingTime time) {
    if (time.days != null && time.days > 0) {
      return time.hours + (time.days * 24);
    }
    return time.hours == null ? 00 : time.hours;
  }

  getTime(CurrentRemainingTime time) {
    try {
      if (getTotalHours(time) < 9) {
        if (time.min < 9) {
          if (getTotalHours(time) != 0) {
            return '0${getTotalHours(time) % 24}h : 0${time.min}m';
          } else {
            return ' 0${time.min}m : ${time.sec}s';
          }
        } else {
          if (getTotalHours(time) != 0) {
            return '0${getTotalHours(time)}h : ${time.min}m';
          } else {
            return ' ${time.min}m : ${time.sec}s';
          }
        }
      } else {
        if (time.min < 9) {
          return '${getTotalHours(time)}h : 0${time.min}m';
        } else {
          if (getTotalHours(time)>24) {
            return '${double.parse((getTotalHours(time) / 24).toString()).floor()} days';
          } else {
            if (getTotalHours(time)<=9) {
              return '0${getTotalHours(time)}h : ${time.min}m';
            } else {
              return '${getTotalHours(time)}h : ${time.min}m';
            }
          }
        }
      }
    } catch (e) {
      print(e);
      return 'TBA';
    }
  }

  getLiveist(List<match> matchLivelist) {
    List<match> list = new List<match>();
    for (var i in matchLivelist) {
      // print(' ${i.title} ${i.status}');
      if (i.status.toString() == '1') {
        list.add(i);
      }
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          try {
            fetchMatches();
          } catch (e) {
            print(e);
          }
          try {
            myLiveMatchList =
                getList(ConstanceData.mylist, ConstanceData.matchLivelist);
            LiveMatchList = getLiveist(ConstanceData.matchLivelist);
          } catch (e) {
            print(e);
          }
        });
      } else {
        fetchMatches();
        try {
          myLiveMatchList =
              getList(ConstanceData.mylist, ConstanceData.matchLivelist);
          LiveMatchList = getLiveist(ConstanceData.matchLivelist);
        } catch (e) {
          print(e);
        }
      }
    });
  }

  void fetchMatches() {
    try {
      access_network().getTeam().then((value) => {
            setValues(value),
          });
    } catch (e) {
      print(e);
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Oops something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  setValues(value) {
    if (value != null && value.length != 0) {
      if (mounted) {
        setState(() {
                ConstanceData.setMyList(value);
                myLiveMatchList =
                    getList(ConstanceData.mylist, ConstanceData.matchLivelist);
              });
      } else {

      }
    } else {}
  }

  getList(List<GetTeam> mylist, List<match> matchLivelist) {
    var temporaryList = new List<match>();
    for (var i in mylist) {
      for (var j in matchLivelist) {
        if (i.competition_id.toString() == j.cid.toString() &&
            i.match_id.toString() == j.match_id.toString()) {
          if (j.status.toString()=='1') {
            temporaryList.add(j);
          }
        }
      }
    }
    return LinkedHashSet<match>.from(temporaryList).toList(growable: false);
  }

  getPrizeName(prize) {
    if (int.parse(prize.toString()) >= 100000 &&
        int.parse(prize.toString()) < 10000000) {
      String txt = prize.toString().split('')[0].toString();
      txt = txt + ' Lakh';
      return txt;
    } else if (int.parse(prize.toString()) > 10000000) {
      String txt = prize.toString().split('')[0].toString();
      txt = txt + ' Crore';
      return txt;
    } else {
      return '${prize}';
    }
  }
}
