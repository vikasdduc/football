import 'package:fantacySports/Networking/AccessNetwork.dart';
import 'package:fantacySports/constance/DataStorage.dart';
import 'package:fantacySports/modules/home/soccer/soccer_create_team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:fantacySports/constance/constance.dart' as constance;
import '../../../Language/appLocalizations.dart';
import '../../../Model/GetTeam.dart';
import '../../../Model/Soccer/soccer_match.dart';
import '../../../Model/contest.dart';
import '../../../constance/constance.dart';
import '../../filter/filter.dart';
import '../../matchDetail/Leaderboard_outside_list.dart';
import '../../matchDetail/WinnerOutside.dart';
import '../../matchDetail/commentary.dart';
import '../../matchDetail/contests.dart';
import '../../matchDetail/myContests.dart';
import '../../matchDetail/myTeam.dart';
import '../../matchDetail/scoreCard.dart';
import '../../matchDetail/stats.dart';
import '../contests/contest_join.dart';
import '../contests/create_contest.dart';

class SoccerMatchDetails extends StatefulWidget {
  final SoccerMatch match;
  final DateTime time;
  final List<SoccerMatch> matches;
  final int index;

  SoccerMatchDetails(this.match, this.time, this.matches, this.index);

  @override
  State<SoccerMatchDetails> createState() => _SoccerMatchDetailsState();
}

class _SoccerMatchDetailsState extends State<SoccerMatchDetails> {
  List<GetTeam> dataList = [];
  List<GetTeam> dataTeams = [];
  List<Contest> contests = [];
  bool isContests = true,
      isMyContests = false,
      isMyTeams = false,
      isScoreCards = false,
      isCommentaries = false,
      isleaderboard = false,
      isWinners = false,
      isWinnings = false,
      isLive = false,
      isStats = false;
  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
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
                  padding: const EdgeInsets.only(left: 20, right: 20),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 270,
                              child: Text(
                                AppLocalizations.of(
                                    '${widget.match.teams.home.abbr} vs ${widget.match.teams.away.abbr}'),
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
                                endTime: widget.time.millisecondsSinceEpoch,
                                endWidget: Text(
                                  'Live',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff0ebd01),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                widgetBuilder: (_, CurrentRemainingTime time) {
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
                      widget.match.competition.cname,
                      ConstanceData.fileteredContests,
                      widget.matches,
                      widget.index,
                      scrollController,
                      dataTeams)
                  : isMyContests
                      ? MyContestsPage(widget.time, widget.match.title, () {
                          setState(() {
                            isContests = true;
                            isMyContests = false;
                          });
                        }, widget.matches, widget.index, update_parent, isLive,
                          dataTeams)
                      : isleaderboard && isLive
                          ? Leaderboard_Outside_List(
                              widget.match.mid.toString(),
                              widget.match,
                              isLive,
                              widget.match.competition.cid.toString(),
                            )
                          : isMyTeams
                              ? MyTeamPage(
                                  widget.match.competition.cid,
                                  widget.match.mid,
                                  constance.CompetitionType.live,
                                  widget.match,
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
                                                  list:
                                                      ConstanceData.teamCombine,
                                                  data: getLiveist(ConstanceData
                                                          .soccerLivelist)[
                                                      widget.index])
                                              : SizedBox(),
            ],
          ),
          getFloatingButton()
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchFantasy();
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

  getCreateTeamButton() {
    return InkWell(
      onTap: () {
        if (Provider.of<Data>(context, listen: false).home.length> 0) {
          send(widget.match);
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
                          // Navigator.pop(context);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => CreateContest(widget.matches,
                          //         widget.index, widget.time, dataTeams),
                          //   ),
                          // ).then((_) {
                          //   showLoaderDialog(context);
                          //   access_network()
                          //       .user_contest_list(
                          //       ConstanceData.prof.id.toString())
                          //       .then((value) {
                          //     setState(() {
                          //       ConstanceData.setMyContests(value);
                          //       contests = getList();
                          //     });
                          //     Navigator.pop(context);
                          //   });
                          // });
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
                          // Navigator.pop(context);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ContestJoin(widget.list,
                          //         widget.index, widget.time, dataTeams),
                          //   ),
                          // ).then((_) {
                          //   showLoaderDialog(context);
                          //   access_network()
                          //       .user_contest_list(
                          //       ConstanceData.prof.id.toString())
                          //       .then((value) {
                          //     setState(() {
                          //       ConstanceData.setMyContests(value);
                          //       contests = getList();
                          //     });
                          //     Navigator.pop(context);
                          //   });
                          // });
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
                          // setState(() {
                          //   // scrollController.jumpTo(0);
                          //   if (custom_contest(ConstanceData.fileteredContests)
                          //       .length >=
                          //       1) {
                          //     Scrollable.ensureVisible(
                          //         ConstanceData.discounted.currentContext,
                          //         alignment: 0.1);
                          //     Navigator.pop(context);
                          //   }
                          // });
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

  getLiveist(List<SoccerMatch> matchLivelist) {
    List<SoccerMatch> list = [];
    for (var i in matchLivelist) {
      if (i.status == 1) {
        list.add(i);
      }
    }
    return list;
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

  getTotalHours(CurrentRemainingTime time) {
    if (time.days != null && time.days > 0) {
      return time.hours + (time.days * 24);
    }
    return time.hours == null ? 0 : time.hours;
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
          if (getTotalHours(time) > 24) {
            return '${double.parse((getTotalHours(time) / 24).toString()).floor()} days';
          } else {
            if (getTotalHours(time) <= 9) {
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
        isLive
            ? InkWell(
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
                  // print('before ${ConstanceData.fileteredContests[0].entry}');
                  ConstanceData.fileteredContests =
                      sortEntry(ConstanceData.fileteredContests);
                  // print('clicked ${ConstanceData.fileteredContests[0].entry}');
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

  void fetchFantasy() async {
    final response = await access_network().getSoccerPlayers(widget.match.mid);
    if (response.status) {
      Provider.of<Data>(context, listen: false).setSoccerTeams(response);
    }
  }

  update_parent() {}

  void send(SoccerMatch match) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SoccerCreateTeam(
            widget.match,
            // widget.index,
            // data.Competition.cid,
            // data.match_id,
            widget.time),
      ),
    ).then(
          (_) {
        // showLoaderDialog(context);
        // access_network().getTeam().then((value) {
        //   if (value != null && value.length != 0) {
        //     setState(() {
        //       ConstanceData.setMyList(value);
        //       dataList = filterContent(
        //         ConstanceData.mylist,
        //         widget.list[widget.index].Competition.cid,
        //         widget.list[widget.index].match_id,
        //       );
        //       dataTeams = filterContent(
        //         ConstanceData.mylist,
        //         widget.list[widget.index].Competition.cid,
        //         widget.list[widget.index].match_id,
        //       );
        //     });
        //     Navigator.pop(context);
        //   } else {
        //     Navigator.pop(context);
        //   }
        // });
      },
    );
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

  high_reward(List<Contest> list) {
    List<Contest> list1 = new List<Contest>();
    for (var i in list) {
      if (i.category_id == 8) {
        list1.add(i);
      }
    }
    return list1;
  }
}
