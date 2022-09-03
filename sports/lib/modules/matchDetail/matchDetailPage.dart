import 'dart:async';
import 'dart:math';

import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/Commentaries/commentary.dart';
import 'package:fantacySports/Model/Matche.dart';
import 'package:fantacySports/Model/Scorecard/Innings.dart';
import 'package:fantacySports/Model/contest.dart';
import 'package:fantacySports/Networking/AccessNetwork.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/modules/createTeam/createTeam.dart';
import 'package:fantacySports/modules/filter/filter.dart';
import 'package:fantacySports/modules/matchDetail/contestDetail/addCash.dart';
import 'package:fantacySports/modules/matchDetail/contests.dart';
import 'package:fantacySports/modules/matchDetail/myContests.dart';
import 'package:fantacySports/modules/matchDetail/myTeam.dart';
import 'package:fantacySports/modules/matchDetail/scoreCard.dart';
import 'package:fantacySports/modules/matchDetail/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fantacySports/constance/constance.dart' as constance;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Model/GetTeam.dart';
import '../home/contests/contest_join.dart';
import '../home/contests/create_contest.dart';
import 'Leaderboard_outside_list.dart';
import 'WinnerOutside.dart';
import 'commentary.dart';
import 'mathDetailsPageWidgets/batStatusScoreCard.dart';
import 'mathDetailsPageWidgets/runsPerBowlScoreCard.dart';

class MatchDetailPage extends StatefulWidget {
  final list, index, type;
  final DateTime time;
  Function onTapEntry;
  Function onTapTeams;

  MatchDetailPage(this.list, this.index, this.type, this.time);

  @override
  _MatchDetailPageState createState() => _MatchDetailPageState();
}

enum selected { first, second }

class _MatchDetailPageState extends State<MatchDetailPage> {
  List<GetTeam> dataList = new List<GetTeam>();
  bool isContests = true;
  bool isMyContests = false;
  bool isMyTeams = false;
  bool isScoreCards = false;
  bool isCommentaries = false;
  bool isleaderboard = false;
  bool isWinners = false;
  bool isWinnings = false;
  bool isLive = false;
  bool isStats = false;
  bool first = true;
  bool second = false;
  bool shouldRun = false;
  selected current = selected.first;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  match currentMatch;
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
    fetchIt();
    Future.delayed(Duration.zero).then((value) => {showLoaderDialog(context)});
    // fetchLiveCompetition();
    fetchContest();
    fetchRoosters();
    fetchMatchSquad();
    fetchInnings();
    fetchUserContest();
    shouldRun = true;
    periodicTimer = Timer.periodic(
      Duration(seconds: 5),
      (timer) {
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
    periodicTimer.cancel();
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
                            color: Colors.grey.shade900,
                          ),
                          //Red space
                          Container(
                            height: AppBar().preferredSize.height,
                            color: Colors.grey.shade900,
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
                                            endWidget: Text(
                                              'Live',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff0ebd01),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            widgetBuilder:
                                                (_, CurrentRemainingTime time) {
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
                                  ? MyContestsPage(widget.time,
                                      widget.list[widget.index].title, () {
                                      setState(() {
                                        isContests = true;
                                        isMyContests = false;
                                      });
                                    }, widget.list, widget.index, update_parent,
                                      isLive, dataTeams)
                                  : isleaderboard&& isLive
                                      ? Leaderboard_Outside_List(
                                          widget.list[widget.index].match_id
                                              .toString(),
                                          widget.list[widget.index],
                                          isLive,
                            widget.list[widget.index].cid.toString(),
                                        )
                                      : isMyTeams
                                          ? MyTeamPage(
                                              widget.list[widget.index]
                                                  .Competition.cid,
                                              widget
                                                  .list[widget.index].match_id,
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
                                                          ? stats(
                                                              list: ConstanceData
                                                                  .teamCombine,
                                                              data: getLiveist(
                                                                  ConstanceData
                                                                      .matchLivelist)[widget
                                                                  .index])
                                                          : SizedBox(),
                        ],
                      )
                    : getLiveBar(widget.list[widget.index]),
                isMyContests == false && !isLive
                    ? getFloatingButton()
                    : SizedBox(),
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

  void update_parent() {
    access_network().getTeam().then((value) {
      if (value != null && value.length != 0) {
        setState(() {
          ConstanceData.setMyList(value);
          dataList = filterContent(
            ConstanceData.mylist,
            widget.list[widget.index].Competition.cid,
            widget.list[widget.index].match_id,
          );
          dataTeams = filterContent(
            ConstanceData.mylist,
            widget.list[widget.index].Competition.cid,
            widget.list[widget.index].match_id,
          );
        });
      } else {}
    });
    access_network()
        .user_contest_list(ConstanceData.prof.id.toString())
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
    setState(() {});
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
                  print('before ${ConstanceData.fileteredContests[0].entry}');
                  ConstanceData.fileteredContests =
                      sortEntry(ConstanceData.fileteredContests);
                  print('clicked ${ConstanceData.fileteredContests[0].entry}');
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

  Widget tabBar() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 6,
          width: 10,
        ),
        !isLive
            ? InkWell(
                onTap: () {
                  setState(() {
                    isContests = true;
                    isMyTeams = false;
                    isMyContests = false;
                    isScoreCards = false;
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
                      border: isContests == true
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
                        AppLocalizations.of('Contests'),
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: isContests == true
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
        // Expanded(child: SizedBox()),
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
              isleaderboard = false;
              isWinners = false;
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
        // Expanded(child: SizedBox()),
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
              isleaderboard = false;
              isWinners = false;
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
        SizedBox(
          height: 6,
          width: 10,
        ),
        isLive
            ? InkWell(
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
              )
            : Container(),
        isLive
            ? SizedBox(
                height: 6,
                width: 10,
              )
            : Container(),
        isLive?InkWell(
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
        ):Container(),
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

  Widget row(String txt1, String txt2) {
    return Column(
      children: [
        Container(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      txt1,
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).textTheme.bodyText2.color,
                            fontSize: 12,
                          ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      txt2,
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).textTheme.bodyText2.color,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Icon(
                  Icons.error_outline,
                  color: Colors.blue,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
        Divider(
          indent: 14,
          endIndent: 14,
        ),
      ],
    );
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

  void fetchRoosters() {
    try {
      access_network()
          .fetchFantasyRoster(
            widget.list[widget.index].Competition.cid.toString(),
            widget.list[widget.index].match_id.toString(),
            widget.list[widget.index].teama.team_id.toString(),
            widget.list[widget.index].teamb.team_id.toString(),
          )
          .then((value) => {
                Navigator.pop(context),
                setData(value),
              });

      access_network()
          .fetchFantasyPoint(widget.list[widget.index].match_id.toString())
          .then((value){

            setPoints(value);
          });
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

  void send(data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTeamPage(
            widget.list,
            widget.index,
            data.Competition.cid,
            data.match_id,
            widget.time.millisecondsSinceEpoch),
      ),
    ).then(
      (_) {
        showLoaderDialog(context);
        access_network().getTeam().then((value) {
          if (value != null && value.length != 0) {
            setState(() {
              ConstanceData.setMyList(value);
              dataList = filterContent(
                ConstanceData.mylist,
                widget.list[widget.index].Competition.cid,
                widget.list[widget.index].match_id,
              );
              dataTeams = filterContent(
                ConstanceData.mylist,
                widget.list[widget.index].Competition.cid,
                widget.list[widget.index].match_id,
              );
            });
            Navigator.pop(context);
          } else {
            Navigator.pop(context);
          }
        });
      },
    );
  }

  setData(value) {
    ConstanceData.addTeamA(value['a']);
    ConstanceData.addTeamB(value['b']);
    ConstanceData.setTeam(value['a'], value['b']);
  }

  getComp() {
    if (widget.type == constance.CompetitionType.def) {
      return ConstanceData.competitionIds[widget.index];
    } else if (widget.type == constance.CompetitionType.live) {
      return ConstanceData.LivecompetitionIds[widget.index];
    } else if (widget.type == constance.CompetitionType.upcoming) {
      return ConstanceData.SchedcompetitionIds[widget.index];
    } else {
      return ConstanceData.CompcompetitionIds[widget.index];
    }
  }

  getMatch() {
    if (widget.type == constance.CompetitionType.def) {
      return ConstanceData.matchlist[widget.index];
    } else if (widget.type == constance.CompetitionType.live) {
      return widget.list[widget.index];
    } else if (widget.type == constance.CompetitionType.upcoming) {
      return ConstanceData.matchSchedlist[widget.index];
    } else {
      return ConstanceData.matchComplist[widget.index];
    }
  }

  setPoints(value) {
    ConstanceData.teamA_points=[];
    ConstanceData.teamB_points=[];
    ConstanceData.teamCombine_points=[];
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
      if (int.parse(list[j].entry.toString()) <
          int.parse(pivot.entry.toString())) {
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
      if (int.parse(list[j].spots.toString()) <
          int.parse(pivot.spots.toString())) {
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddCashPage(),
                        ),
                      );
                    },
                    child: Center(
                      child: Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of('Add cash'),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    indent: 14,
                    endIndent: 14,
                  ),
                  row(AppLocalizations.of('Amount Added'), "₹0"),
                  row(AppLocalizations.of('Winnings'), "₹31"),
                  row(AppLocalizations.of('Cash Bonus'), "₹0"),
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

  getLiveBar(match data) {
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
                          data.status == 2
                              ? Flexible(
                                  child: CountdownTimer(
                                    endTime: widget.time.millisecondsSinceEpoch,
                                    endWidget: Text(
                                      'Live',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff0ebd01),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    widgetBuilder:
                                        (_, CurrentRemainingTime time) {
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
                              : Text(
                                  'Completed',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff0ebd01),
                                    fontWeight: FontWeight.bold,
                                  ),
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
                      ? MyContestsPage(
                          widget.time, widget.list[widget.index].title, () {
                          setState(() {
                            isContests = true;
                            isMyContests = false;
                          });
                        }, widget.list, widget.index, update_parent, isLive,
                          dataTeams)
                  : isleaderboard&& isLive
                          ? Leaderboard_Outside_List(
                              widget.list[widget.index].match_id.toString(),
                              widget.list[widget.index],
                              isLive,
                widget.list[widget.index].cid.toString(),
                            )
                          : isWinners && isLive
                              ? winnersOutside()
                              : isMyTeams
                                  ? MyTeamPage(
                                      widget.list[widget.index].Competition.cid,
                                      widget.list[widget.index].match_id,
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
                                                  list:
                                                      ConstanceData.teamCombine,
                                                  data: ConstanceData
                                                          .matchLivelist[
                                                      widget.index])
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
                                    endWidget: Text(
                                      'Live',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff0ebd01),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    widgetBuilder:
                                        (_, CurrentRemainingTime time) {
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
                              : Text(
                                  data.status == 2 ? 'Completed' : 'Live',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff0ebd01),
                                    fontWeight: FontWeight.bold,
                                  ),
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
                      ? MyContestsPage(
                          widget.time, widget.list[widget.index].title, () {
                          setState(() {
                            isContests = true;
                            isMyContests = false;
                          });
                        }, widget.list, widget.index, update_parent, isLive,
                          dataTeams)
                  : isleaderboard&& isLive
                          ? Leaderboard_Outside_List(
                              widget.list[widget.index].match_id.toString(),
                              widget.list[widget.index],
                              isLive,
                widget.list[widget.index].cid.toString(),
                            )
                          : isWinners && isLive
                              ? winnersOutside()
                              : isMyTeams
                                  ? MyTeamPage(
                                      widget.list[widget.index].Competition.cid,
                                      widget.list[widget.index].match_id,
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
                                                  list:
                                                      ConstanceData.teamCombine,
                                                  data: ConstanceData
                                                          .matchLivelist[
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
      // print('${hour} ${int.parse(Time[0])}');
      // if (hour > int.parse(Time[0])) {
      //   return true;
      // } else {
      //   if (hour == int.parse(Time[0]) &&
      //       int.parse(time[1]) > int.parse(Time[0])) {
      //     return true;
      //   } else {
      //     return false;
      //   }
      // }
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

  getCreateTeamButton() {
    return InkWell(
      onTap: () {
        if (ConstanceData.teamCombine.length > 0) {
          send(widget.list[widget.index]);
        } else {
          Fluttertoast.showToast(
              msg:
                  "No Player Data Available for this match.\n Please try again or try another match",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: Container(
        height: 30,
        // width: 160,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          // borderRadius: BorderRadius.circular(6),
          // border: Border.all(
          //   color: Colors.grey.shade900,
          // ),
        ),
        child: Center(
          child: Text(
            AppLocalizations.of('Create Team'),
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
          ),
        ),
      ),
    );
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

  getFloatingButton() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 10,
        right: 3,
        left: 3,
      ),
      child: Container(
        width: 300,
        decoration: BoxDecoration(),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            padding: EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.grey.shade900,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              // children: [getCreateContestButton(), getCreateTeamButton()],
              children: [
                Expanded(
                  child: getCreateContestButton(),
                ),
                SizedBox(
                  child: Container(
                    color: Colors.white,
                  ),
                  height: 30,
                  width: 0.5,
                ),
                Expanded(
                  child: getCreateTeamButton(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getCreateContestButton() {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => Card(
            color: Theme.of(context).appBarTheme.color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.color,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateContest(widget.list,
                                  widget.index, widget.time, dataTeams),
                            ),
                          ).then((_) {
                            showLoaderDialog(context);
                            access_network()
                                .user_contest_list(
                                    ConstanceData.prof.id.toString())
                                .then((value) {
                              setState(() {
                                ConstanceData.setMyContests(value);
                                contests = getList();
                              });
                              Navigator.pop(context);
                            });
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              child: Icon(
                                Icons.add_box,
                                // fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Create Contest",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 14,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContestJoin(widget.list,
                                  widget.index, widget.time, dataTeams),
                            ),
                          ).then((_) {
                            showLoaderDialog(context);
                            access_network()
                                .user_contest_list(
                                    ConstanceData.prof.id.toString())
                                .then((value) {
                              setState(() {
                                ConstanceData.setMyContests(value);
                                contests = getList();
                              });
                              Navigator.pop(context);
                            });
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              child: Icon(
                                Icons.code_rounded,
                                // fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Join Contest",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 14,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 15,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text('Contests'),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            // scrollController.jumpTo(0);
                            if (custom_contest(ConstanceData.fileteredContests)
                                    .length >=
                                1) {
                              Scrollable.ensureVisible(
                                  ConstanceData.discounted.currentContext,
                                  alignment: 0.1);
                              Navigator.pop(context);
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              "Custom Contest",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 14,
                                      ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                              ),
                            ),
                            Text(
                              "${custom_contest(ConstanceData.fileteredContests).length}",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 14,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (beginners(ConstanceData.fileteredContests)
                                  .length >=
                              1) {
                            Scrollable.ensureVisible(
                                ConstanceData.beginners.currentContext,
                                alignment: 0.1);
                            Navigator.pop(context);
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              "Beginners",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 14,
                                      ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                              ),
                            ),
                            Text(
                              "${beginners(ConstanceData.fileteredContests).length}",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 14,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (head_to_head(ConstanceData.fileteredContests)
                                  .length >=
                              1) {
                            Scrollable.ensureVisible(
                                ConstanceData.headtohead.currentContext,
                                alignment: 0.1);
                            Navigator.pop(context);
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              "Head to Head",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 14,
                                      ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                              ),
                            ),
                            Text(
                              "${head_to_head(ConstanceData.fileteredContests).length}",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 14,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (low_entry(ConstanceData.fileteredContests)
                                  .length >=
                              1) {
                            Scrollable.ensureVisible(
                                ConstanceData.low_entry.currentContext,
                                alignment: 0.1);
                            Navigator.pop(context);
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              "Low Entry",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 14,
                                      ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                              ),
                            ),
                            Text(
                              "${low_entry(ConstanceData.fileteredContests).length}",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 14,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (mega(ConstanceData.fileteredContests).length >=
                              1) {
                            Scrollable.ensureVisible(
                                ConstanceData.mega.currentContext,
                                alignment: 0.1);
                            Navigator.pop(context);
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              "Mega Contests",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 14,
                                      ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                              ),
                            ),
                            Text(
                              "${mega(ConstanceData.fileteredContests).length}",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 14,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (high_reward(ConstanceData.fileteredContests)
                                  .length >=
                              1) {
                            Scrollable.ensureVisible(
                                ConstanceData.high_reward.currentContext,
                                alignment: 0.1);
                            Navigator.pop(context);
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              "High Rewards",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 14,
                                      ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                              ),
                            ),
                            Text(
                              "${high_reward(ConstanceData.fileteredContests).length}",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: 14,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        Fluttertoast.showToast(
          msg: "Create Contest",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      },
      child: Container(
        height: 30,
        // width: 160,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          // borderRadius: BorderRadius.circular(6),
          // border: Border.all(
          //   color: Colors.grey.shade900,
          // ),
        ),
        child: Center(
          child: Text(
            AppLocalizations.of('Contest'),
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
          ),
        ),
      ),
    );
  }

  high_reward(List<Contest> list) {
    List<Contest> list1 = new List<Contest>();
    for (var i in list) {
      if (i.category_id == 8) {
        list1.add(i);
      }
    }
    return list1;
  }

  void fetchUserContest() {
    try {
      access_network()
          .user_contest_list(ConstanceData.prof.id.toString())
          .then((value) {
        if (mounted) {
          setState(() {
            ConstanceData.setMyContests(value);
          });
        } else {
          print('sel by');
          ConstanceData.setselby_Player(value);
        }
      });
    } catch (e) {
      print(e);
    }
    access_network()
        .user_contest_by_list(ConstanceData.prof.id.toString(),
            widget.list[widget.index].match_id.toString())
        .then((value) {
      if (mounted) {
        setState(() {
          ConstanceData.setSpecific_contests(value);
        });
      } else {
        ConstanceData.setSpecific_contests(value);
      }
    });
  }

  void getTeams() {
    if (mounted) {
      setState(() {
        try {
          dataTeams = filterContent(
            ConstanceData.mylist,
            widget.list[widget.index].Competition.cid,
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
          widget.list[widget.index].Competition.cid,
          widget.list[widget.index].match_id,
        );
      } catch (e) {
        print(e);
      }
    }
  }

  List<GetTeam> filterContent(List<GetTeam> mylist, competition_id, match_id) {
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

  custom_contest(List<Contest> list) {
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
    list.addAll(custom_contest(ConstanceData.fileteredContests));
    list.addAll(head_to_head(ConstanceData.fileteredContests));
    list.addAll(beginners(ConstanceData.fileteredContests));
    list.addAll(low_entry(ConstanceData.fileteredContests));
    return list;
  }

  getLength() {
    int i = 0;
    if (custom_contest(ConstanceData.fileteredContests).length > 0) {
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

  void fetchContest() {
    access_network()
        .getCompletions(widget.list[widget.index].match_id.toString())
        .then((value) => {
              setState(() {
                ConstanceData.setContests(value);
              })
            });
  }

  void fetchIt() async {
    access_network()
        .getleaderboard_outside(ConstanceData.prof.id.toString(),
            widget.list[widget.index].match_id.toString(),widget.list[widget.index].cid.toString(),0)
        .then((_) {
      setState(() {
        print('bcvxzbvx');
        ConstanceData.leaderboardoutside = _;
      });
    });
  }

  setSelby(value) {
    if (mounted) {
      setState(() {
        print('sel by');
        ConstanceData.setselby_Player(value);
      });
    } else {
      print('sel by');
      ConstanceData.setselby_Player(value);
    }
  }
}
