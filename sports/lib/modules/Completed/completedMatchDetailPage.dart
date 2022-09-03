import 'dart:async';

import 'package:fantacySports/Model/Matche.dart';
import 'package:fantacySports/Model/match_new.dart';
import 'package:fantacySports/modules/matchDetail/myCompletedContestsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Language/appLocalizations.dart';
import '../../Model/Commentaries/commentary.dart';
import '../../Model/GetTeam.dart';
import '../../Model/Scorecard/Innings.dart';
import '../../Model/contest.dart';
import '../../Networking/AccessNetwork.dart';
import '../../constance/constance.dart';
import '../createTeam/createTeam.dart';
import '../filter/filter.dart';
import '../matchDetail/Leaderboard_completed_list.dart';
import '../matchDetail/Leaderboard_outside_list.dart';
import '../matchDetail/WinnerOutside.dart';
import '../matchDetail/commentary.dart';
import '../matchDetail/contests.dart';
import '../matchDetail/mathDetailsPageWidgets/batStatusScoreCard.dart';
import '../matchDetail/mathDetailsPageWidgets/runsPerBowlScoreCard.dart';
import '../matchDetail/myCompletedTeam.dart';
import '../matchDetail/myContests.dart';
import '../matchDetail/myTeam.dart';
import '../matchDetail/scoreCard.dart';
import '../matchDetail/stats.dart';
import '../matchDetail/stats_completed.dart';

class CompletedMatchDetailPage extends StatefulWidget {
  final list, index, type;
  final DateTime time;
  Function onTapEntry;
  Function onTapTeams;

  CompletedMatchDetailPage(this.list, this.index, this.type, this.time);

  @override
  State<CompletedMatchDetailPage> createState() =>
      _CompletedMatchDetailPageState();
}

enum selected { first, second }

class _CompletedMatchDetailPageState extends State<CompletedMatchDetailPage> {
  List<GetTeam> dataList = new List<GetTeam>();
  bool isContests = false;
  bool isMyContests = true;
  bool isMyTeams = false;
  bool isScoreCards = false;
  bool isCommentaries = false;
  bool isleaderboard = false;
  bool isWinners = false;
  bool isWinnings = true;
  bool isLive = false;
  bool isStats = false;
  bool first = true;
  bool second = false;
  bool shouldRun = false;
  selected current = selected.first;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  match_new currentMatch;
  AlertDialog alert;
  Timer periodicTimer;
  List<String> runs = new List<String>();
  List<String> balls = new List<String>();
  List<GetTeam> dataTeams = new List<GetTeam>();
  List<Contest> contests = new List<Contest>();
  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero).then((value) => {showLoaderDialog(context)});
    // fetchLiveCompetition();
    fetchRoosters();
    fetchMatchSquad();
    fetchInnings();
    fetchUserContest();
    shouldRun = true;
    Future.delayed(
      Duration.zero,
      () {
        if (shouldRun && isLive) {
          if (mounted) {
            setState(() {
              fetchInnings();
            });
          } else {
            fetchInnings();
          }
        } else {}
      },
    );
    if (widget.time.isBefore(DateTime.now())) {
      setState(() {
        isLive = true;
        isContests = false;
        isMyContests = true;
      });
    }
    currentMatch = widget.list[widget.index];
    ConstanceData.fileteredContests = ConstanceData.contests;
    Future.delayed(Duration(seconds: 2), () {
      getTeams();
      getcontests();
    });
  }

  @override
  void dispose() {
    ConstanceData.selectedPlayers.clear();
    ConstanceData.teamCombine.clear();
    ConstanceData.CommentariesCombo = new List<commentaries>();
    ConstanceData.CommentariesA = new List<commentaries>();
    ConstanceData.CommentariesB = new List<commentaries>();
    ConstanceData.Innings = new List<innings>();
    periodicTimer = null;
    shouldRun = false;
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ConstanceData.fileteredContests == null) {
      setState(() {
        ConstanceData.fileteredContests = ConstanceData.contests;
      });
    }
    return Scaffold(
      body: (ConstanceData.Innings != null &&
                  ConstanceData.Innings.isNotEmpty) ||
              !isLive
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: [
                !isLive
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //AppBar
                          Container(
                            height: MediaQuery.of(context).padding.top,
                            color: Theme.of(context).primaryColor,
                          ),
                          //Red space
                          Container(
                            height: AppBar().preferredSize.height,
                            color: Theme.of(context).primaryColor,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 270,
                                          child: Text(
                                            AppLocalizations.of(
                                                '${widget.list[widget.index].title}'),
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ),
                                        Flexible(
                                          child: CountdownTimer(
                                            endTime: widget
                                                .time.millisecondsSinceEpoch,
                                            endWidget: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xff0ebd01),
                                                  ),
                                                  height: 7,
                                                  width: 7,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Completed',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xff0ebd01),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            widgetBuilder:
                                                (_, CurrentRemainingTime time) {
                                              if (time == null) {
                                                return Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Color(0xff0ebd01),
                                                      ),
                                                      height: 7,
                                                      width: 7,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Completed',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff0ebd01),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }
                                              return Text(
                                                '${getTime(time)}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                              );
                                            },
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          LiveStatus(),
                          isContests
                              ? Column(
                                  children: [
                                    Container(
                                      child: secondRow(),
                                    ),
                                    Divider(
                                      thickness: 1.5,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          isContests && !isLive
                              ? ContestsPage(
                                  widget.time,
                                  widget.list[widget.index].title,
                                  ConstanceData.fileteredContests,
                                  widget.list,
                                  widget.index,
                                  scrollController,
                                  dataTeams)
                              : isMyContests
                                  ? MyCompletedContestPage(
                                      widget.time,
                                      widget.list[widget.index].title,
                                      () {
                                        setState(() {
                                          isContests = true;
                                          isMyContests = false;
                                        });
                                      },
                                      widget.list,
                                      widget.index,
                                      update_parent,
                                      isLive,
                                      dataTeams,
                                      widget.list[widget.index],
                                      changeToLeaderBoard,
                                    )
                                  : isleaderboard
                                      ? leaderboard_completed_list(
                                          widget.list[widget.index].match_id
                                              .toString(),
                                          dataTeams,
                                          widget.list[widget.index],
                            widget.list[widget.index].compition_id.toString(),
                                        )
                                      : isWinners
                                          ? winnersOutside()
                                          : isMyTeams
                                          ? MyTeamPage(
                                          widget.list[widget.index].cid,
                                          widget
                                              .list[widget.index].match_id,
                                          widget.type,
                                          widget.list[widget.index],
                                          widget.time,
                                          dataTeams,
                                          update_parent)
                                          : isCommentaries
                                              ? Commentary()
                                              : isScoreCards
                                                  ? Scorecard()
                                                  : isStats
                                                      ? stats(
                                                          list: ConstanceData
                                                              .teamCombine,
                                                          data: getLiveist(
                                                                  ConstanceData
                                                                      .matchLivelist)[
                                                              widget.index])
                                                      : SizedBox(),
                        ],
                      )
                    : getLiveBar(widget.list[widget.index]),
              ],
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  void fetchRoosters() {
    try {
      access_network()
          .fetchFantasyRoster(
            widget.list[widget.index].compition_id.toString(),
            widget.list[widget.index].match_id.toString(),
            widget.list[widget.index].teama.team_id.toString(),
            widget.list[widget.index].teamb.team_id.toString(),
          )
          .then((value) => {
                // Navigator.pop(context),
                Fluttertoast.showToast(
                    msg:
                        "${value == 'Failed' ? 'Ooops something went wrong' : 'Received'}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0),
                setData(value),
              });

      access_network()
          .fetchFantasyPoint(widget.list[widget.index].match_id.toString())
          .then((value) => {setPoints(value)});
      access_network()
          .get_selby(widget.list[widget.index].match_id.toString())
          .then((value) => {setSelby(value)});
    } catch (e) {
      print(e);
      try {
        // Navigator.pop(context);
      } catch (e) {
        print(e);
      }
      // Fluttertoast.showToast(
      //     msg: "not Received  def ",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
  }

  void fetchMatchSquad() {
    access_network()
        .fetchMatchSquad(
      widget.list[widget.index].match_id.toString(),
      widget.list[widget.index].teama.team_id.toString(),
      widget.list[widget.index].teamb.team_id.toString(),
    )
        .then((value) {
      if (value != 'Failed') {
        ConstanceData.setAnnouncedA(value['a']);
        ConstanceData.setAnnouncedB(value['b']);
      }
    });
  }

  void fetchInnings() {
    access_network()
        .fetchInnings(
      widget.list[widget.index].match_id.toString(),
    )
        .then((value) {
      if (value != 'Failed') {
        if (mounted) {
          setState(() {
            ConstanceData.setInnings(value);
          });
        } else {
          ConstanceData.setInnings(value);
        }
        for (var i = 0; i < value.length; i++) {
          fetchCommentry((i + 1).toString());
        }
      }
    });
  }

  void fetchCommentry(String innings) {
    if (mounted) {
      setState(() {
        access_network()
            .fetchCommentry(
                widget.list[widget.index].match_id.toString(), innings)
            .then((value) => {
                  innings == '1'
                      ? setState(() {
                          ConstanceData.setCommentariesA(value);
                        })
                      : setState(() {
                          ConstanceData.setCommentariesB(value);
                        })
                });
      });
    } else {}
  }

  void _launchURL() async {
    if (!await launch('https://fancode.com'))
      throw 'Could not launch ${'https://fancode.com'}';
  }

  List<Contest> filter(List<Contest> contests) {
    var list = new List<Contest>();
    if (ConstanceData.entry != null) {
      list = filterEntry(contests);
      if (ConstanceData.prize != null) {
        list = filterPrize(list);
        if (ConstanceData.teams != null) {
          list = filterTeams(list);
          if (ConstanceData.type != null) {
            return filterTypes(list);
          } else {
            return list;
          }
        } else {
          return list;
        }
      } else {
        if (ConstanceData.teams != null) {
          list = filterTeams(list);
          if (ConstanceData.type != null) {
            return filterTypes(list);
          } else {
            return list;
          }
        } else {
          if (ConstanceData.type != null) {
            return filterTypes(list);
          } else {
            return list;
          }
        }
      }
    } else {
      if (ConstanceData.prize != null) {
        list = filterPrize(contests);
        if (ConstanceData.teams != null) {
          list = filterTeams(list);
          if (ConstanceData.type != null) {
            return filterTypes(list);
          } else {
            return list;
          }
        } else {
          if (ConstanceData.type != null) {
            return filterTypes(list);
          } else {
            return list;
          }
        }
      } else {
        if (ConstanceData.teams != null) {
          list = filterTeams(contests);
          if (ConstanceData.type != null) {
            return filterTypes(list);
          } else {
            return list;
          }
        } else {
          if (ConstanceData.type != null) {
            return filterTypes(contests);
          } else {
            return contests;
          }
        }
      }
    }
  }

  setData(value) {
    ConstanceData.addTeamA(value['a']);
    ConstanceData.addTeamB(value['b']);
    ConstanceData.setTeam(value['a'], value['b']);
  }

  setPoints(value) {
    ConstanceData.addTeamA_point(value['a']);
    ConstanceData.addTeamB_point(value['b']);
    ConstanceData.setTeam_point(value['a'], value['b']);
  }

  List<Contest> filterEntry(List<Contest> contests) {
    var list = new List<Contest>();
    if (ConstanceData.entry == 0) {
      for (var i in contests) {
        if (int.parse(i.entry.toString()) <= 50) {
          list.add(i);
        }
      }
    } else if (ConstanceData.entry == 1) {
      for (var i in contests) {
        if (int.parse(i.entry.toString()) <= 100 &&
            int.parse(i.entry.toString()) > 50) {
          list.add(i);
        }
      }
    } else if (ConstanceData.entry == 2) {
      for (var i in contests) {
        if (int.parse(i.entry.toString()) <= 1000 &&
            int.parse(i.entry.toString()) > 100) {
          list.add(i);
        }
      }
    } else if (ConstanceData.entry == 3) {
      for (var i in contests) {
        if (int.parse(i.entry.toString()) >= 1000) {
          list.add(i);
        }
      }
    }
    return list;
  }

  List<Contest> filterPrize(List<Contest> contests) {
    var list = new List<Contest>();
    if (ConstanceData.prize == 0) {
      for (var i in contests) {
        if (i.prize <= 10000) {
          list.add(i);
        }
      }
    } else if (ConstanceData.prize == 1) {
      for (var i in contests) {
        if (i.prize <= 100000 && i.prize > 10000) {
          list.add(i);
        }
      }
    } else if (ConstanceData.prize == 2) {
      for (var i in contests) {
        if (i.prize <= 1000000 && i.prize > 100000) {
          list.add(i);
        }
      }
    } else if (ConstanceData.prize == 3) {
      for (var i in contests) {
        if (i.prize >= 1000000) {
          list.add(i);
        }
      }
    }
    return list;
  }

  List<Contest> filterTeams(List<Contest> contests) {
    var list = new List<Contest>();
    if (ConstanceData.teams == 0) {
      for (var i in contests) {
        if (int.parse(i.spots.toString()) <= 2) {
          list.add(i);
        }
      }
    } else if (ConstanceData.teams == 1) {
      for (var i in contests) {
        if (int.parse(i.spots.toString()) <= 10 &&
            int.parse(i.spots.toString()) >= 3) {
          list.add(i);
        }
      }
    } else if (ConstanceData.teams == 2) {
      for (var i in contests) {
        if (int.parse(i.spots.toString()) <= 100 &&
            int.parse(i.spots.toString()) > 11) {
          list.add(i);
        }
      }
    } else if (ConstanceData.teams == 3) {
      for (var i in contests) {
        if (int.parse(i.spots.toString()) >= 1000) {
          list.add(i);
        }
      }
    }
    return list;
  }

  List<Contest> filterTypes(List<Contest> contests) {
    var list = new List<Contest>();

    if (ConstanceData.type == 0) {
      for (var i in contests) {
        if (i.content_type == ConstanceData.teamTypes[0]) {
          list.add(i);
        }
      }
    } else if (ConstanceData.type == 1) {
      for (var i in contests) {
        if (i.content_type == ConstanceData.teamTypes[1]) {
          list.add(i);
        }
      }
    } else if (ConstanceData.type == 2) {
      for (var i in contests) {
        if (i.content_type == ConstanceData.teamTypes[2]) {
          list.add(i);
        }
      }
    } else if (ConstanceData.type == 3) {
      for (var i in contests) {
        if (i.content_type == ConstanceData.teamTypes[3]) {
          list.add(i);
        }
      }
    } else if (ConstanceData.type == 4) {
      for (var i in contests) {
        if (i.content_type == ConstanceData.teamTypes[4]) {
          list.add(i);
        }
      }
    }
    return list;
  }

  List<Contest> sortEntry(List<Contest> fileteredContests) {
    int high = fileteredContests.length - 1;
    int low = 0;
    List<Contest> result = quickSortEntry(fileteredContests, low, high);

    return result;
  }

  List<Contest> quickSortEntry(List list, int low, int high) {
    if (low < high) {
      int pi = partition(list, low, high);

      quickSortEntry(list, low, pi - 1);
      quickSortEntry(list, pi + 1, high);
    }
    return list;
  }

  int partition(List<Contest> list, low, high) {
    Contest pivot = list[high];

    int i = low - 1;
    for (int j = low; j < high; j++) {
      if (int.parse(list[j].entry) < int.parse(pivot.entry)) {
        i++;
        swap(list, i, j);
      }
    }
    swap(list, i + 1, high);
    return i + 1;
  }

  void swap(List list, int i, int j) {
    Contest temp = list[i];
    list[i] = list[j];
    list[j] = temp;
  }

  List<Contest> sortContestSize(List<Contest> fileteredContests) {
    int high = fileteredContests.length - 1;
    int low = 0;
    List<Contest> result = quickContestSize(fileteredContests, low, high);

    return result;
  }

  List<Contest> quickContestSize(List list, int low, int high) {
    if (low < high) {
      int pi = partitionContestSize(list, low, high);

      quickContestSize(list, low, pi - 1);
      quickContestSize(list, pi + 1, high);
    }
    return list;
  }

  int partitionContestSize(List list, int low, int high) {
    Contest pivot = list[high];

    int i = low - 1;
    for (int j = low; j < high; j++) {
      if (int.parse(list[j].spots) < int.parse(pivot.spots)) {
        i++;
        swap(list, i, j);
      }
    }
    swap(list, i + 1, high);
    return i + 1;
  }

  void showModel() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      context: context,
      builder: (BuildContext context) => Card(
        color: Theme.of(context).appBarTheme.color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Container(
          height: 230,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.color,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: StatefulBuilder(
            builder: (context, setstate) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Text(
                          AppLocalizations.of('Set Reminders'),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      AppLocalizations.of('Lineup Commentaries (if available)'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).textTheme.bodyText2.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of('Match - KXIP vs DC'),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                          ),
                          Expanded(child: SizedBox()),
                          Radio(
                            activeColor: Theme.of(context).primaryColor,
                            groupValue: current,
                            value: selected.first,
                            onChanged: (val) {
                              setstate(() {
                                current = val;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of('Tour - Fantanccy IPL'),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                          ),
                          Expanded(child: SizedBox()),
                          Radio(
                            activeColor: Theme.of(context).primaryColor,
                            groupValue: current,
                            value: selected.second,
                            onChanged: (val) {
                              setstate(() {
                                current = val;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Card(
                          child: Container(
                            height: 35,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4)),
                            child: Material(
                              color: Color(0xff0E2F56),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                radius: 100,
                                splashColor: Colors.white70,
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of('Done'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future showPayment() {
    return showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).appBarTheme.color,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      AppLocalizations.of('Total Balance'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).textTheme.bodyText2.color,
                            fontSize: 14,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "₹${ConstanceData.prof.balance == null ? 0 : ConstanceData.prof.balance}",
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).textTheme.headline6.color,
                            fontSize: 14,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    indent: 14,
                    endIndent: 14,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Theme.of(context).textTheme.bodyText2.color,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  getLiveBar(match_new data) {
    return data.status == 2
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).padding.top,
                color: Colors.black,
              ),
              Container(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: SizedBox(
                              width: 170,
                              child: Text(
                                AppLocalizations.of(
                                    '${widget.list[widget.index].title}'),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(
                            FontAwesomeIcons.trophy,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              showModel();
                            },
                            child: Icon(
                              FontAwesomeIcons.bell,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              showPayment();
                            },
                            child: Icon(
                              FontAwesomeIcons.wallet,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${data.teama.short_name}",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.grey.shade400,
                                      fontSize: 10,
                                    ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${data.teama.scores}",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.grey.shade400,
                                      fontSize: 16,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff0ebd01),
                                ),
                                height: 7,
                                width: 7,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Completed',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff0ebd01),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${data.teamb.short_name}",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${data.teamb.scores}",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '${data.status_note}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'For expert comments & stats',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 20,
                            color: Colors.red,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).disabledColor.withOpacity(0.1),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal, child: tabBar()),
              ),
              isContests && !isLive
                  ? Column(
                      children: [
                        Container(
                          child: secondRow(),
                        ),
                        Divider(
                          thickness: 1.5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  : SizedBox(),
              isContests
                  ? ContestsPage(
                      widget.time,
                      widget.list[widget.index].title,
                      ConstanceData.fileteredContests,
                      widget.list,
                      widget.index,
                      scrollController,
                      dataTeams)
                  : isMyContests
                      ? MyCompletedContestPage(
                          widget.time,
                          widget.list[widget.index].title,
                          () {
                            setState(() {
                              isContests = true;
                              isMyContests = false;
                            });
                          },
                          widget.list,
                          widget.index,
                          update_parent,
                          isLive,
                          dataTeams,
                          widget.list[widget.index],
                          changeToLeaderBoard,
                        )
                      : isWinners && isLive
                          ? winnersOutside()
                          // : isMyTeams
                          // ? MyTeamPage(
                          // widget.list[widget.index].Competition.cid,
                          // widget.list[widget.index].match_id,
                          // widget.type,
                          // widget.list[widget.index],
                          // widget.time,
                          // dataTeams,
                          // update_parent)
                          : isCommentaries
                              ? Commentary()
                              : isScoreCards
                                  ? Scorecard()
                                  : isStats
                                      ? stats(
                                          list: ConstanceData.teamCombine,
                                          data: ConstanceData
                                              .matchLivelist[widget.index])
                                      : SizedBox(),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).padding.top,
                color: Colors.black,
              ),
              Container(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: SizedBox(
                              width: 170,
                              child: Text(
                                AppLocalizations.of(
                                    '${widget.list[widget.index].title}'),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(
                            FontAwesomeIcons.trophy,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              showModel();
                            },
                            child: Icon(
                              FontAwesomeIcons.bell,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              showPayment();
                            },
                            child: Icon(
                              FontAwesomeIcons.wallet,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${data.teama.short_name}",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${getAScore(data.teama.team_id)}",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                              ),
                            ],
                          ),
                          data.status == 3
                              ? Flexible(
                                  child: CountdownTimer(
                                    endTime: widget.time.millisecondsSinceEpoch,
                                    endWidget: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xff0ebd01),
                                          ),
                                          height: 7,
                                          width: 7,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Completed',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff0ebd01),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    widgetBuilder:
                                        (_, CurrentRemainingTime time) {
                                      if (time == null) {
                                        return Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xff0ebd01),
                                              ),
                                              height: 7,
                                              width: 7,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Completed',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                      return Text(
                                        '${getTime(time)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                      );
                                    },
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff0ebd01),
                                      ),
                                      height: 7,
                                      width: 7,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Completed',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${data.teamb.short_name}",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${getAScore(data.teamb.team_id)}",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '${data.status_note}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ConstanceData.Innings == null ||
                              ConstanceData.Innings.isEmpty ||
                              ConstanceData.Innings[getIndex()].batsmen ==
                                  null ||
                              ConstanceData.Innings[getIndex()].batsmen.isEmpty
                          ? Container()
                          : Divider(
                              color: Colors.white,
                            ),
                      ConstanceData.Innings == null ||
                              ConstanceData.Innings[getIndex()].batsmen ==
                                  null ||
                              ConstanceData.Innings[getIndex()].batsmen.isEmpty
                          ? Container()
                          : batBowlStats(),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'For expert comments & stats',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {_launchURL()},
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Colors.grey.shade900,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Row(
                                children: [
                                  Text(
                                    'Open IN FANCODE',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.deepOrange,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).disabledColor.withOpacity(0.1),
                ),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal, child: tabBar()),
              ),
              isContests
                  ? Column(
                      children: [
                        Container(
                          child: secondRow(),
                        ),
                        Divider(
                          thickness: 1.5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  : SizedBox(),
              isContests
                  ? ContestsPage(
                      widget.time,
                      widget.list[widget.index].title,
                      ConstanceData.fileteredContests,
                      widget.list,
                      widget.index,
                      scrollController,
                      dataTeams)
                  : isMyContests
                      ? MyCompletedContestPage(
                          widget.time,
                          widget.list[widget.index].title,
                          () {
                            setState(() {
                              isContests = true;
                              isMyContests = false;
                            });
                          },
                          widget.list,
                          widget.index,
                          update_parent,
                          isLive,
                          dataTeams,
                          widget.list[widget.index],
                          changeToLeaderBoard,
                        )
                      : isleaderboard
                          ? leaderboard_completed_list(
                              widget.list[widget.index].match_id.toString(),
                              dataTeams,
                              widget.list[widget.index],
                widget.list[widget.index].compition_id.toString(),
                            )
                          : isMyTeams
                              ? MyCompleteTeam(
                                  widget.list[widget.index].match_id,
                                  widget.type,
                                  widget.list[widget.index],
                                  widget.time,
                                  dataTeams,
                                  update_parent)
                              : isWinners && isLive
                                  ? winnersOutside()
                                  : isCommentaries
                                      ? Commentary()
                                      : isScoreCards
                                          ? Scorecard()
                                          : isStats
                                              ? stats_completed(
                                                  list:
                                                      ConstanceData.teamCombine,
                                                  data: ConstanceData
                                                          .matchComplist[
                                                      widget.index])
                                              : SizedBox(),
            ],
          );
  }

  getIndex() {
    //ConstanceData.Innings.length-1
    return widget.list[widget.index].teamb.scores == 'null' ||
            widget.list[widget.index].teamb.scores == null
        ? 0
        : widget.list[widget.index].teama.scores == 'null' ||
                widget.list[widget.index].teama.scores == null
            ? 0
            : 1;
  }

  getBowler() {
    for (int i = 0;
        i <
            ConstanceData
                .Innings[ConstanceData.Innings != null &&
                        ConstanceData.Innings.length > 2
                    ? 1
                    : 0]
                .bowlers
                .length;
        i++) {
      if (ConstanceData
          .Innings[
              ConstanceData.Innings != null && ConstanceData.Innings.length > 2
                  ? 1
                  : 0]
          .bowlers[i]
          .bowling) {
        return i;
      }
    }
  }

  // void fetchLiveCompetition() {
  //   access_network().fetchMatches('3').then((value) => {
  //         for (var i in value)
  //           {
  //             if (mounted)
  //               {
  //                 setState(() {
  //                   ConstanceData.addLiveMatch(i);
  //                   ConstanceData.addLiveIDs(i.cid.toString());
  //                 })
  //               }
  //             else
  //               {
  //                 ConstanceData.addLiveMatch(i),
  //                 ConstanceData.addLiveIDs(i.cid.toString()),
  //               },
  //           },
  //       });
  // }

  void update_parent() {
    setState(() {
      access_network().getTeam().then((value) {
        if (value != null && value.length != 0) {
          setState(() {
            ConstanceData.setMyList(value);
            dataList = filterContent(
              ConstanceData.mylist,
              widget.list[widget.index].match_id,
            );
            dataTeams = filterContent(
              ConstanceData.mylist,
              widget.list[widget.index].match_id,
            );
          });
        } else {}
      });
      access_network()
          .user_contest_list(ConstanceData.id.toString())
          .then((value) {
        try {
          setState(() {
            ConstanceData.setMyContests(value);
          });
        } catch (e) {
          print(e);
        }
        // Navigator.pop(context);
      });
    });
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
      return true;
    } else {
      return true;
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
      return false;
    }
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

  Widget secondRow() {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 5, top: 12, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of('Sort by'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: Theme.of(context).textTheme.bodyText2.color,
                    fontSize: 12,
                  ),
            ),
            GestureDetector(
              onTap: () => {
                setState(() {
                  ConstanceData.fileteredContests =
                      sortEntry(ConstanceData.fileteredContests);
                })
              },
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    AppLocalizations.of('Entry Fee'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).textTheme.bodyText2.color,
                          fontSize: 12,
                        ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => {
                setState(() {
                  ConstanceData.fileteredContests =
                      sortContestSize(ConstanceData.fileteredContests);
                })
              },
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    AppLocalizations.of('Content Size'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).textTheme.bodyText2.color,
                          fontSize: 12,
                        ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FilterPage(
                              onTapEntry: (index) {
                                setState(() {
                                  ConstanceData.entry = index;
                                  ConstanceData.fileteredContests =
                                      filter(ConstanceData.contests);
                                });
                              },
                              onTapTeams: (index) {
                                setState(() {
                                  ConstanceData.teams = index;
                                  ConstanceData.fileteredContests =
                                      filter(ConstanceData.contests);
                                });
                              },
                              onTapPrize: (index) {
                                setState(() {
                                  ConstanceData.prize = index;
                                  ConstanceData.fileteredContests =
                                      filter(ConstanceData.contests);
                                });
                              },
                              onTapType: (index) {
                                setState(() {
                                  ConstanceData.type = index;
                                  ConstanceData.fileteredContests =
                                      filter(ConstanceData.contests);
                                });
                              },
                              onTapClear: () {
                                setState(() {
                                  ConstanceData.entry = null;
                                  ConstanceData.prize = null;
                                  ConstanceData.teams = null;
                                  ConstanceData.type = null;
                                  ConstanceData.fileteredContests =
                                      ConstanceData.contests;
                                });
                              },
                            )));
              },
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of('All Filters'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                          fontSize: 12,
                        ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.sort,
                    size: 14,
                  )
                ],
              ),
            )
          ],
        ));
  }

  void changeToLeaderBoard() {
    setState(() {
      isleaderboard = true;
      isContests = false;
      isMyTeams = false;
      isMyContests = false;
      isScoreCards = false;
      isCommentaries = false;
      isStats = false;
      isWinners = false;
    });
  }

  Widget tabBar() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 6,
          width: 10,
        ),
        InkWell(
          onTap: () {
            setState(() {
              isContests = false;
              isMyTeams = false;
              isMyContests = true;
              isScoreCards = false;
              isCommentaries = false;
              isStats = false;
              isWinners = false;
              isleaderboard = false;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(left: isLive ? 5 : 20),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: isMyContests == true
                    ? Border(
                        bottom: BorderSide(
                          color: Colors.red,
                          width: 3.0,
                        ),
                      )
                    : Border(),
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of(
                      'My Contests(${ConstanceData.specific_contests == null ? 0 : ConstanceData.specific_contests.length})'),
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: isMyContests == true
                            ? Theme.of(context).textTheme.headline6.color
                            : Colors.black38,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 6,
          width: 10,
        ),
        InkWell(
          onTap: () {
            // print('Caanfaoncjnajkocnajlocnl');
            setState(() {
              isleaderboard = false;
              isContests = false;
              isMyTeams = false;
              isMyContests = false;
              isScoreCards = false;
              isCommentaries = false;
              isStats = false;
              isWinners = true;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(left: isLive ? 5 : 20),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: isWinners == true
                    ? Border(
                  bottom: BorderSide(
                    color: Colors.red,
                    width: 3.0,
                  ),
                )
                    : Border(),
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of('Winnings'),
                  style: Theme.of(context).textTheme.caption.copyWith(
                    color: isWinners == true
                        ? Theme.of(context).textTheme.headline6.color
                        : Colors.black38,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 6,
          width: 10,
        ),
        InkWell(
          onTap: () {
            // print('Caanfaoncjnajkocnajlocnl');
            setState(() {
              isleaderboard = true;
              isContests = false;
              isMyTeams = false;
              isMyContests = false;
              isScoreCards = false;
              isCommentaries = false;
              isStats = false;
              isWinners = false;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(left: isLive ? 5 : 20),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: isleaderboard == true
                    ? Border(
                        bottom: BorderSide(
                          color: Colors.red,
                          width: 3.0,
                        ),
                      )
                    : Border(),
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of('Leaderboard'),
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: isleaderboard == true
                            ? Theme.of(context).textTheme.headline6.color
                            : Colors.black38,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 6,
          width: 10,
        ),
        InkWell(
          onTap: () {
            setState(() {
              isContests = false;
              isMyTeams = true;
              isMyContests = false;
              isScoreCards = false;
              isCommentaries = false;
              isStats = false;
              isleaderboard=false;
              isWinnings=false;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(left: isLive ? 5 : 20),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: isMyTeams == true
                    ? Border(
                        bottom: BorderSide(
                          color: Colors.red,
                          width: 3.0,
                        ),
                      )
                    : Border(),
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of('My Teams (${dataTeams.length})'),
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: isMyTeams == true
                            ? Theme.of(context).textTheme.headline6.color
                            : Colors.black38,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                ),
              ),
            ),
          ),
        ),
        // isLive ? Expanded(child: SizedBox()) : Container(),
        isLive
            ? SizedBox(
                height: 6,
                width: 10,
              )
            : Container(),
        isLive
            ? InkWell(
                onTap: () {
                  setState(() {
                    isContests = false;
                    isMyTeams = false;
                    isMyContests = false;
                    isScoreCards = false;
                    isCommentaries = true;
                    isStats = false;
                    isleaderboard = false;
                    isWinners = false;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(left: isLive ? 5 : 20),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: isCommentaries == true
                          ? Border(
                              bottom: BorderSide(
                                color: Colors.red,
                                width: 3.0,
                              ),
                            )
                          : Border(),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of('Commentary'),
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: isCommentaries == true
                                  ? Theme.of(context).textTheme.headline6.color
                                  : Colors.black38,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
        isLive
            ? SizedBox(
                height: 6,
                width: 10,
              )
            : Container(),
        isLive
            ? InkWell(
                onTap: () {
                  setState(() {
                    isContests = false;
                    isMyTeams = false;
                    isMyContests = false;
                    isScoreCards = true;
                    isCommentaries = false;
                    isStats = false;
                    isleaderboard = false;
                    isWinners = false;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(left: isLive ? 5 : 20),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: isScoreCards == true
                          ? Border(
                              bottom: BorderSide(
                                color: Colors.red,
                                width: 3.0,
                              ),
                            )
                          : Border(),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of('Scorecard'),
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: isScoreCards == true
                                  ? Theme.of(context).textTheme.headline6.color
                                  : Colors.black38,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
        // isLive ? Expanded(child: SizedBox()) : Container(),
        isLive
            ? SizedBox(
                height: 6,
                width: 10,
              )
            : Container(),
        isLive
            ? InkWell(
                onTap: () {
                  setState(() {
                    isContests = false;
                    isMyTeams = false;
                    isMyContests = false;
                    isScoreCards = false;
                    isCommentaries = false;
                    isStats = true;
                    isleaderboard = false;
                    isWinners = false;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(left: isLive ? 5 : 20),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: isStats == true
                          ? Border(
                              bottom: BorderSide(
                                color: Colors.red,
                                width: 3.0,
                              ),
                            )
                          : Border(),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of('Stats'),
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: isStats == true
                                  ? Theme.of(context).textTheme.headline6.color
                                  : Colors.black38,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  notNull() {
    if (ConstanceData
                .Innings[ConstanceData.Innings != null &&
                        ConstanceData.Innings.length > 2
                    ? 1
                    : 0]
                .bowlers[getBowler()]
                .name ==
            null ||
        ConstanceData
                .Innings[ConstanceData.Innings != null &&
                        ConstanceData.Innings.length > 2
                    ? 1
                    : 0]
                .bowlers[getBowler()]
                .name ==
            'null') {
      return '';
    }
    return ConstanceData
        .Innings[
            ConstanceData.Innings != null && ConstanceData.Innings.length > 2
                ? 1
                : 0]
        .bowlers[getBowler()]
        .name;
  }

  getTheCurrentBowler() {
    for (var i in ConstanceData.Innings[whichSideBatting()].bowlers) {
      if (i.bowling) {
        return i.name;
      }
    }
  }

  LiveStatus() {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).disabledColor.withOpacity(0.1),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, child: tabBar()),
    );
  }

  BowlStats() {
    return Expanded(
      flex: 2,
      child: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '${getTheCurrentBowler()}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ConstanceData.Innings == null ||
                    ConstanceData.Innings.length < 1 ||
                    ConstanceData.CommentariesCombo == null ||
                    ConstanceData.CommentariesCombo.isEmpty
                ? Container(
                    child: Text(
                      '',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : RunsPerBowlScoreCard(getBowlsBowled(), runs)
          ],
        ),
      ),
    );
  }

  batBowlStats() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BatsScoreCard(whichSideBatting()),
          getTheCurrentBowler() != null && getTheCurrentBowler() != 'null'
              ? BowlStats()
              : Container(),
        ],
      ),
    );
  }

  getRun(index) {
    return int.parse(ConstanceData.CommentariesCombo.last.ball == null ||
                    ConstanceData.CommentariesCombo.last.ball == 'null'
                ? '0'
                : ConstanceData.CommentariesCombo.last.ball) >=
            index
        ? ConstanceData
            .CommentariesCombo[
                ConstanceData.CommentariesCombo.length - (6 - (index + 1))]
            .run
        : '';
  }

  getBowlsBowled() {
    runs = new List<String>();
    balls = new List<String>();

    int count = 0;
    for (int i = ConstanceData.CommentariesCombo.length - 1; i >= 0; i--) {
      if (ConstanceData.CommentariesCombo[i].event != 'overend') {
        runs.add(ConstanceData.CommentariesCombo[i].run.toString());
        balls.add(ConstanceData.CommentariesCombo[i].ball.toString());
        count++;
      } else {
        return count;
      }
    }
  }

  getAScore(int team_id) {
    if (team_id == ConstanceData.Innings[0].batting_team_id) {
      return ConstanceData.Innings == null ||
              ConstanceData.Innings.isEmpty ||
              ConstanceData.Innings[0] == null ||
              ConstanceData.Innings[0].scores == 'null' ||
              ConstanceData.Innings[0].scores == null
          ? 'Yet to Bat'
          : ConstanceData.Innings[0].scores;
    } else if (ConstanceData.Innings.length < 2) {
      return 'Yet to Bat';
    } else {
      return ConstanceData.Innings == null ||
              ConstanceData.Innings.isEmpty ||
              ConstanceData.Innings[0] == null ||
              ConstanceData.Innings[0].scores == 'null' ||
              ConstanceData.Innings[1].scores == null
          ? 'Yet to Bat'
          : ConstanceData.Innings[1].scores;
    }
  }

  int whichSideBatting() {
    if (ConstanceData.Innings.length < 2) {
      return 0;
    } else {
      return 1;
    }
  }

  showLoaderDialog(BuildContext context) {
    alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void fetchUserContest() {
    access_network()
        .user_contest_list(ConstanceData.id.toString())
        .then((value) {
      ConstanceData.setMyContests(value);
    });
  }

  void getTeams() {
    if (mounted) {
      setState(() {
        try {
          dataTeams = filterContent(
            ConstanceData.mylist,
            widget.list[widget.index].match_id,
          );
        } catch (e) {
          print(e);
        }
      });
    } else {
      try {
        dataTeams = filterContent(
          ConstanceData.mylist,
          widget.list[widget.index].match_id,
        );
      } catch (e) {
        print(e);
      }
    }
  }

  List<GetTeam> filterContent(List<GetTeam> mylist, match_id) {
    List<GetTeam> list = new List<GetTeam>();
    for (var i in mylist) {
      if (i.match_id.toString() == match_id.toString()) {
        list.add(i);
        print(i.match_id);
      } else {}
    }
    return list;
  }

  List<Contest> getList() {
    List<Contest> list = new List<Contest>();
    for (var i in ConstanceData.Mycontests) {
      if (i.user_id != null) {
        if (i.user_id.toString() == ConstanceData.prof.id.toString()) {
          list.add(i);
        }
      }
    }
    return list;
  }

  void getcontests() {
    contests = getList();
  }

  discounted(List<Contest> list) {
    List<Contest> list1 = new List<Contest>();
    for (var i in list) {
      if (i.category_id == 0) {
        list1.add(i);
      }
    }
    return list1;
  }

  beginners(List<Contest> list) {
    List<Contest> list1 = new List<Contest>();
    for (var i in list) {
      if (i.category_id == 1) {
        list1.add(i);
      }
    }
    return list1;
  }

  head_to_head(List<Contest> list) {
    List<Contest> list1 = new List<Contest>();
    for (var i in list) {
      if (i.category_id == 2) {
        list1.add(i);
      }
    }
    return list1;
  }

  low_entry(List<Contest> list) {
    List<Contest> list1 = new List<Contest>();
    for (var i in list) {
      if (i.category_id == 3) {
        list1.add(i);
      }
    }
    return list1;
  }

  mega(List<Contest> list) {
    List<Contest> list1 = new List<Contest>();
    for (var i in list) {
      if (i.category_id == 4) {
        list1.add(i);
      }
    }
    return list1;
  }

  combine() {
    List<Contest> list = new List<Contest>();
    list.addAll(discounted(ConstanceData.fileteredContests));
    list.addAll(head_to_head(ConstanceData.fileteredContests));
    list.addAll(beginners(ConstanceData.fileteredContests));
    list.addAll(low_entry(ConstanceData.fileteredContests));
    return list;
  }

  getLength() {
    int i = 0;
    if (discounted(ConstanceData.fileteredContests).length > 0) {
      i++;
    }
    if (head_to_head(ConstanceData.fileteredContests).length > 0) {
      i++;
    }
    if (beginners(ConstanceData.fileteredContests).length > 0) {
      i++;
    }
    if (low_entry(ConstanceData.fileteredContests).length > 0) {
      i++;
    }
  }

  setSelby(value) {
    setState(() {
      ConstanceData.setselby_Player(value);
    });
  }

  getLiveist(List<match> matchLivelist) {
    List<match> list = new List<match>();
    for (var i in matchLivelist) {
      if (i.status == 1) {
        list.add(i);
      }
    }
    return list;
  }
}
