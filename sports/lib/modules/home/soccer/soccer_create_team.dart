import 'package:fantacySports/Model/Soccer/soccer_match.dart';
import 'package:fantacySports/modules/home/soccer/soccer_choose_captain.dart';
import 'package:fantacySports/modules/home/soccer/soccer_team_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Language/appLocalizations.dart';
import '../../../Model/Soccer/soccer_player.dart';
import '../../../Model/player_point.dart';
import '../../../constance/constance.dart';
import '../../../widget/teamCardView.dart';

enum selectedTeam { TeamA, TeamB, Both }

class SoccerCreateTeam extends StatefulWidget {
  final SoccerMatch match;
  final DateTime time;

  SoccerCreateTeam(this.match, this.time);

  @override
  State<SoccerCreateTeam> createState() => _SoccerCreateTeamState();
}

class _SoccerCreateTeamState extends State<SoccerCreateTeam> {
  bool isGK = true;
  bool isDEF = false;
  bool isMID = false;
  bool isST = false;
  List<SoccerPlayer> gks = [], defs = [], mids = [], sts = [];
  int GK = 0, DEF = 0, MID = 0, ST = 0;
  int teama = 0, teamb = 0;
  double totalCredit = 100.0;
  List<int> vals = [0, 1, 2];
  bool creditDeceandWk = false;
  List<player_point> Pointlist = [];
  selectedTeam _currentFilter = selectedTeam.Both;

  @override
  void initState() {
    super.initState();
    totalCredit = double.parse(ConstanceData.prof.credit.toString());
    if (ConstanceData.soccerSelectedPlayers.isNotEmpty ||
        ConstanceData.soccerSelectedPlayers.length > 0) {
      double cal = 0.0;
      for (var i in ConstanceData.soccerSelectedPlayers) {
        cal += double.parse(i.fantasy_player_rating ?? "0");
        addTeam(i.pid.toString());
      }
      totalCredit -= cal;
      GK = filterGK(ConstanceData.soccerSelectedPlayers).length;
      DEF = filterDEF(ConstanceData.soccerSelectedPlayers).length;
      MID = filterMID(ConstanceData.soccerSelectedPlayers).length;
      ST = filterST(ConstanceData.soccerSelectedPlayers).length;
      gks = filterGK(ConstanceData.soccerTeamCombine);
      defs = filterDEF(ConstanceData.soccerTeamCombine);
      mids = filterMID(ConstanceData.soccerTeamCombine);
      sts = filterST(ConstanceData.soccerTeamCombine);
      if (mounted) {
        setState(() {});
      }
    } else {
      gks = filterGK(ConstanceData.soccerTeamCombine);
      defs = filterDEF(ConstanceData.soccerTeamCombine);
      mids = filterMID(ConstanceData.soccerTeamCombine);
      sts = filterST(ConstanceData.soccerTeamCombine);
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Container(
                  height: 30,
                  child: tabBar(),
                ),
                Container(
                  height: 40,
                  color: Theme.of(context).disabledColor.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of('Select players'),
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.6,
                                fontSize: 12,
                              ),
                        ),
                        Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20))),
                              context: context,
                              builder: (context) => StatefulBuilder(
                                builder: (cont, setIt) {
                                  return Container(
                                    height: 250,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                          child: Text(
                                            AppLocalizations.of(
                                                'Filter By teams'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  letterSpacing: 0.6,
                                                  fontSize: 18,
                                                ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Card(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: selectedTeam.TeamA,
                                                  groupValue: _currentFilter,
                                                  onChanged: (value) {
                                                    sortThem(value, setIt);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                Text(
                                                    '${widget.match.teams.home.abbr}')
                                              ],
                                            ),
                                          ),
                                        ),
                                        Card(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: selectedTeam.TeamB,
                                                  groupValue: _currentFilter,
                                                  onChanged: (value) {
                                                    sortThem(value, setIt);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                Text(
                                                    '${widget.match.teams.away.abbr}')
                                              ],
                                            ),
                                          ),
                                        ),
                                        Card(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: selectedTeam.Both,
                                                  groupValue: _currentFilter,
                                                  onChanged: (value) {
                                                    sortThem(value, setIt);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                Text('BOTH')
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          child: Icon(
                            Icons.sort,
                            color: Theme.of(context).textTheme.headline6.color,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  color: Theme.of(context).disabledColor.withOpacity(0.05),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 100, right: 20),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of('SELECTE BY'),
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.6,
                                fontSize: 10,
                              ),
                        ),
                        Expanded(child: SizedBox()),
                        Text(
                          AppLocalizations.of('POINTS'),
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.6,
                                fontSize: 10,
                              ),
                        ),
                        Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              creditDeceandWk = !creditDeceandWk;
                              if (creditDeceandWk) {
                                gks = quickSort(gks, 0, gks.length - 1);
                                defs = quickSort(defs, 0, defs.length - 1);
                                mids = quickSort(mids, 0, mids.length - 1);
                                sts = quickSort(sts, 0, sts.length - 1);
                              } else {
                                gks = quickSort(gks, 0, gks.length - 1)
                                    .reversed
                                    .toList(growable: false);
                                defs = quickSort(defs, 0, defs.length - 1)
                                    .reversed
                                    .toList(growable: false);
                                mids = quickSort(mids, 0, mids.length - 1)
                                    .reversed
                                    .toList(growable: false);
                                sts = quickSort(sts, 0, sts.length - 1)
                                    .reversed
                                    .toList(growable: false);
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of('CREDITS'),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.6,
                                      fontSize: 10,
                                    ),
                              ),
                              Icon(
                                creditDeceandWk
                                    ? Icons.arrow_downward
                                    : Icons.arrow_upward,
                                size: 14,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isGK == true
                    ? gk()
                    : isDEF == true
                        ? def()
                        : isMID == true
                            ? mid()
                            : isST == true
                                ? st()
                                : SizedBox(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SoccerTeamPreview(
                          0,
                          0,
                          widget.match.teams.home.abbr,
                          widget.match.teams.away.abbr,
                          ConstanceData.soccerSelectedPlayers,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Container(
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of('Team Preview'),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Color(0xff0ebd01),
                                  letterSpacing: 0.6,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (GK == 1) {
                      if (DEF >= 3 && DEF <= 5) {
                        if (MID >= 3 && MID <= 5) {
                          if (ST >= 1 && ST <= 3) {
                            if (ConstanceData.soccerSelectedPlayers.length ==
                                11) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SoccerChooseCaptain(
                                    ConstanceData.soccerSelectedPlayers,
                                    widget.match.competition.cid,
                                    widget.match.mid,
                                    widget.match.teams.home.abbr,
                                    widget.match.teams.away.abbr,
                                    widget.time.millisecondsSinceEpoch,
                                  ),
                                ),
                              );
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Add 11 players to continue",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Add at least one Forward",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Add at least three Mid-Fielder",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Add at least three Defenders",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Add one GoalKeeper",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Container(
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of('Continue'),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color:
                                      Theme.of(context).textTheme.caption.color,
                                  letterSpacing: 0.6,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget tabBar() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isGK = true;
              isDEF = false;
              isMID = false;
              isST = false;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5, left: 20),
            child: Text(
              AppLocalizations.of('GK($GK)'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: isGK ? Theme.of(context).primaryColor : Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6,
                    fontSize: 12,
                  ),
            ),
          ),
        ),
        Expanded(child: SizedBox()),
        InkWell(
          onTap: () {
            setState(() {
              isGK = false;
              isDEF = true;
              isMID = false;
              isST = false;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              AppLocalizations.of('DEF(${DEF})'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: isDEF ? Theme.of(context).primaryColor : Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6,
                    fontSize: 12,
                  ),
            ),
          ),
        ),
        Expanded(child: SizedBox()),
        InkWell(
          onTap: () {
            setState(() {
              isGK = false;
              isDEF = false;
              isMID = true;
              isST = false;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5, right: 20),
            child: Text(
              AppLocalizations.of('MID($MID)'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: isMID ? Theme.of(context).primaryColor : Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6,
                    fontSize: 12,
                  ),
            ),
          ),
        ),
        Expanded(child: SizedBox()),
        InkWell(
          onTap: () {
            setState(() {
              isGK = false;
              isDEF = false;
              isMID = false;
              isST = true;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5, right: 20),
            child: Text(
              AppLocalizations.of('ST($ST)'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: isST ? Theme.of(context).primaryColor : Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6,
                    fontSize: 12,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey.shade900,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(
                '${widget.match.teams.home.abbr} vs ${widget.match.teams.away.abbr}'),
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
          ),
          CountdownTimer(
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
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
              );
            },
            textStyle: Theme.of(context).textTheme.caption.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                ),
          ),
        ],
      ),
      centerTitle: false,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: Center(
          child: Container(
            // height: MediaQuery.of(context).padding.top,
            color: Colors.grey.shade900,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  AppLocalizations.of('Max 7 players from a team'),
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Colors.grey.shade300,
                        letterSpacing: 0.6,
                        fontSize: 14,
                      ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of('Players'),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.grey.shade300,
                                  letterSpacing: 0.6,
                                  fontSize: 12,
                                ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "${ConstanceData.soccerSelectedPlayers.length}",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.white,
                                      letterSpacing: 0.6,
                                      fontSize: 16,
                                    ),
                              ),
                              Text(
                                "/11",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.white,
                                      letterSpacing: 0.6,
                                      fontSize: 16,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        child: Image.network(
                          widget.match.teams.home.logo,
                          fit: BoxFit.cover,
                          errorBuilder: (cont, s, d) => Center(
                            child: Icon(
                              Icons.image,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.match.teams.home.abbr}",
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.grey.shade300,
                                  letterSpacing: 0.6,
                                  fontSize: 10,
                                ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${teama}",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.white,
                                  letterSpacing: 0.6,
                                  fontSize: 18,
                                ),
                          ),
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.match.teams.away.abbr}",
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.grey.shade300,
                                  letterSpacing: 0.6,
                                  fontSize: 12,
                                ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${teamb}",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.white,
                                  letterSpacing: 0.6,
                                  fontSize: 18,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        child: Image.network(
                          widget.match.teams.away.logo,
                          fit: BoxFit.cover,
                          errorBuilder: (cont, s, d) => Center(
                            child: Icon(
                              Icons.image,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of('Credits'),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.grey.shade300,
                                  letterSpacing: 0.6,
                                  fontSize: 12,
                                ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${totalCredit}",
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.white,
                                  letterSpacing: 0.6,
                                  fontSize: 16,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      customContainer(
                          ConstanceData.soccerSelectedPlayers.length >= 1
                              ? Color(0xff0ebd01)
                              : Colors.white),
                      SizedBox(
                        width: 3,
                      ),
                      customContainer(
                          ConstanceData.soccerSelectedPlayers.length >= 2
                              ? Color(0xff0ebd01)
                              : Colors.white),
                      SizedBox(
                        width: 3,
                      ),
                      customContainer(
                          ConstanceData.soccerSelectedPlayers.length >= 3
                              ? Color(0xff0ebd01)
                              : Colors.white),
                      SizedBox(
                        width: 3,
                      ),
                      customContainer(
                          ConstanceData.soccerSelectedPlayers.length >= 4
                              ? Color(0xff0ebd01)
                              : Colors.white),
                      SizedBox(
                        width: 3,
                      ),
                      customContainer(
                          ConstanceData.soccerSelectedPlayers.length >= 5
                              ? Color(0xff0ebd01)
                              : Colors.white),
                      SizedBox(
                        width: 3,
                      ),
                      customContainer(
                          ConstanceData.soccerSelectedPlayers.length >= 6
                              ? Color(0xff0ebd01)
                              : Colors.white),
                      SizedBox(
                        width: 3,
                      ),
                      customContainer(
                          ConstanceData.soccerSelectedPlayers.length >= 7
                              ? Color(0xff0ebd01)
                              : Colors.white),
                      SizedBox(
                        width: 3,
                      ),
                      customContainer(
                          ConstanceData.soccerSelectedPlayers.length >= 8
                              ? Color(0xff0ebd01)
                              : Colors.white),
                      SizedBox(
                        width: 3,
                      ),
                      customContainer(
                          ConstanceData.soccerSelectedPlayers.length >= 9
                              ? Color(0xff0ebd01)
                              : Colors.white),
                      SizedBox(
                        width: 3,
                      ),
                      customContainer(
                          ConstanceData.soccerSelectedPlayers.length >= 10
                              ? Color(0xff0ebd01)
                              : Colors.white),
                      SizedBox(
                        width: 3,
                      ),
                      customContainer(
                          ConstanceData.soccerSelectedPlayers.length >= 11
                              ? Color(0xff0ebd01)
                              : Colors.white),
                      Expanded(child: SizedBox()),
                      IconButton(
                        onPressed: () {
                          mainReduce();
                        },
                        splashRadius: 20,
                        splashColor: Colors.grey.shade300,
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.grey.shade300,
                          size: 29,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
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

  List<SoccerPlayer> filterGK(List<SoccerPlayer> teamCombine) {
    List<SoccerPlayer> list = [];
    for (var i in teamCombine) {
      if (i.positiontype.toString().trim() == "G") {
        list.add(i);
      }
    }

    return list;
  }

  List<SoccerPlayer> filterDEF(List<SoccerPlayer> teamCombine) {
    List<SoccerPlayer> list = [];
    for (var i in teamCombine) {
      if (i.positiontype.toString().trim() == "D") {
        list.add(i);
      }
    }

    return list;
  }

  List<SoccerPlayer> filterMID(List<SoccerPlayer> teamCombine) {
    List<SoccerPlayer> list = [];
    for (var i in teamCombine) {
      if (i.positiontype.toString().trim() == "M") {
        list.add(i);
      }
    }

    return list;
  }

  List<SoccerPlayer> filterST(List<SoccerPlayer> teamCombine) {
    List<SoccerPlayer> list = [];
    for (var i in teamCombine) {
      if (i.positiontype.toString().trim() == "F") {
        list.add(i);
      }
    }

    return list;
  }

  filterTeamA(List<SoccerPlayer> wks) {
    List<SoccerPlayer> list = [];
    for (var i in wks) {
      for (var j in ConstanceData.soccerTeamA) {
        if (i.pid.toString() == j.pid) {
          list.add(i);
        }
      }
    }
    return list;
  }

  filterTeamB(List<SoccerPlayer> wks) {
    List<SoccerPlayer> list = [];
    for (var i in wks) {
      for (var j in ConstanceData.soccerTeamB) {
        if (i.pid.toString() == j.pid.toString()) {
          list.add(i);
        }
      }
    }
    return list;
  }

  filterTeams(List<SoccerPlayer> wks) {
    List<SoccerPlayer> list = [];
    for (var i in wks) {
      for (var j in ConstanceData.soccerTeamA) {
        if (i.pid.toString() == j.pid.toString()) {
          list.add(i);
        }
      }
      for (var k in ConstanceData.soccerTeamB) {
        if (i.pid.toString() == k.pid.toString()) {
          list.add(i);
        }
      }
    }
    return list;
  }

  List<SoccerPlayer> quickSort(List<SoccerPlayer> list, int low, int high) {
    if (low < high) {
      int pi = partition(list, low, high);
      print("pivot: ${list[pi]} now at index $pi");

      quickSort(list, low, pi - 1);
      quickSort(list, pi + 1, high);
    }
    return list;
  }

  int partition(List<SoccerPlayer> list, low, high) {
    // Base check
    if (list.isEmpty) {
      return 0;
    }
    // Take our last element as pivot and counter i one less than low
    SoccerPlayer pivot = list[high];

    int i = low - 1;
    for (int j = low; j < high; j++) {
      // When j is < than pivot element we increment i and swap arr[i] and arr[j]
      if (double.parse(list[j].fantasy_player_rating) <
          double.parse(pivot.fantasy_player_rating)) {
        i++;
        swap(list, i, j);
      }
    }
    // Swap the last element and place in front of the i'th element
    swap(list, i + 1, high);
    return i + 1;
  }

// Swapping using a temp variable
  void swap(List<SoccerPlayer> list, int i, int j) {
    SoccerPlayer temp = list[i];
    list[i] = list[j];
    list[j] = temp;
  }

  addTeam(pid) {
    if (whichTeam(pid) == 'a') {
      setState(() {
        teama++;
      });
    } else {
      setState(() {
        teamb++;
      });
    }
  }

  String whichTeam(pid) {
    for (var a in ConstanceData.soccerTeamA) {
      if (a.pid.toString() == pid.toString()) {
        return 'a';
      }
    }
    for (var b in ConstanceData.soccerTeamB) {
      if (b.pid.toString() == pid.toString()) {
        return 'b';
      }
    }
  }

  void sortThem(value, setIt) {
    setState(() {
      setIt(() {
        _currentFilter = value;
        gks = filterTeamA(
          filterGK(ConstanceData.soccerTeamCombine),
        );
        defs = filterTeamA(
          filterDEF(ConstanceData.soccerTeamCombine),
        );
        mids = filterTeamA(
          filterMID(ConstanceData.soccerTeamCombine),
        );
        sts = filterTeamA(
          filterST(ConstanceData.soccerTeamCombine),
        );
        if (creditDeceandWk) {
          gks = quickSort(gks, 0, gks.length - 1);
          defs = quickSort(defs, 0, defs.length - 1);
          mids = quickSort(mids, 0, mids.length - 1);
          sts = quickSort(sts, 0, sts.length - 1);
        } else {
          gks = quickSort(gks, 0, gks.length - 1)
              .reversed
              .toList(growable: false);
          defs = quickSort(defs, 0, defs.length - 1)
              .reversed
              .toList(growable: false);
          mids = quickSort(mids, 0, mids.length - 1)
              .reversed
              .toList(growable: false);
          sts = quickSort(sts, 0, sts.length - 1)
              .reversed
              .toList(growable: false);
        }
      });
    });
  }

  gk() {
    print(ConstanceData.soccerTeamCombine.length);
    return Expanded(
      child: ConstanceData.soccerTeamCombine.isEmpty ||
              ConstanceData.soccerTeamCombine.length <= 0
          ? Container()
          : ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(0.0),
              itemCount: gks.length,
              itemBuilder: (contx, index) {
                SoccerPlayer data = gks[index];
                return InkWell(
                  onTap: () {
                    Add_remove(data, () {
                      if (GK >= 0 && GK < 1) {
                        setState(() {
                          ConstanceData.soccerSelectedPlayers.add(data);
                          totalCredit -=
                              double.parse(data.fantasy_player_rating);
                          GK++;
                          addTeam(data.pid.toString());
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Only One Goalkeeper allowed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }, () {
                      removeIT(data);
                      minusTeam(data.pid);
                      setState(() {
                        totalCredit += double.parse(data.fantasy_player_rating);
                        GK--;
                      });
                    });
                  },
                  child: TeamCardView(
                    txt1:
                        "${whichTeam(data.pid.toString()) == 'a' ? widget.match.teams.home.abbr : widget.match.teams.away.abbr}",
                    txt2: AppLocalizations.of('${data.name}'),
                    txt3: AppLocalizations.of(
                        'Sel by ${getSelby(data.pid.toString())}%'),
                    txt4: checkIfAnounced(data.pid.toString())
                        ? AppLocalizations.of('Announced')
                        : lastMatchPlayed(data.pid.toString()),
                    txt5:
                        "${getPoint(data.pid) == null ? 0 : getPoint(data.pid)}",
                    txt6: "${data.fantasy_player_rating.toString()}",
                    txt7: whichTeam(data.pid.toString()),
                    image1: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.asset(
                        'assets/images/${data.name.toString().trim().toLowerCase()}.webp',
                        fit: BoxFit.fill,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace stackTrace) {
                          return Image.asset(ConstanceData.defaultPlayer);
                        },
                      ),
                    ),
                    selected: !contains(data),
                  ),
                );
              }),
    );
  }

  void Add_remove(
      SoccerPlayer data, void Function() param1, void Function() param2) {
    if (contains(data)) {
      if (ConstanceData.selectedPlayers != null &&
          ConstanceData.selectedPlayers.length >= 0) {
        if (ConstanceData.selectedPlayers.length < 11) {
          if (totalCredit >= double.parse(data.fantasy_player_rating)) {
            if (getWhichTeam(data.pid.toString())) {
              param1();
            } else {
              Fluttertoast.showToast(
                  msg: "Select players from the other team",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          } else {
            Fluttertoast.showToast(
                msg: "Not enough credit available",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else {
          Fluttertoast.showToast(
              msg: "List is full",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    } else {
      param2();
    }
  }

  bool getWhichTeam(pid) {
    if (whichTeam(pid) == 'a') {
      if (teama < 7 && teama >= 0) {
        return true;
      } else {
        return false;
      }
    } else {
      if (teamb < 7 && teamb >= 0) {
        return true;
      } else {
        return false;
      }
    }
  }

  bool contains(SoccerPlayer wk) {
    if (ConstanceData.soccerSelectedPlayers.length <= 0) {
      return true;
    }
    for (var i in ConstanceData.soccerSelectedPlayers) {
      if (i.pid == wk.pid) {
        return false;
      }
    }
    return true;
  }

  void removeIT(SoccerPlayer wk) {
    for (int i = 0; i < ConstanceData.soccerSelectedPlayers.length; i++) {
      if (ConstanceData.soccerSelectedPlayers[i].pid == wk.pid) {
        setState(() {
          ConstanceData.soccerSelectedPlayers.removeAt(i);
        });
      }
    }
  }

  minusTeam(pid) {
    if (whichTeam(pid) == 'a') {
      setState(() {
        teama--;
      });
    } else {
      setState(() {
        teamb--;
      });
    }
  }

  getSelby(String string) {
    for (var i in ConstanceData.selby_Player_list) {
      if (i.player_id.toString() == string) {
        return double.parse(i.select_ratio.toString()).toInt();
      }
    }
    return 0;
  }

  checkIfAnounced(String id) {
    try {
      for (var i in ConstanceData.anouncedTeamA) {
        if (id == i.player_id.toString() && i.playing11) {
          // print(i.name);
          return true;
        }
      }
      for (var i in ConstanceData.anouncedTeamB) {
        if (id == i.player_id.toString() && i.playing11) {
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  lastMatchPlayed(pid) {
    for (var i in Pointlist) {
      if (pid.toString() == i.pid.toString()) {
        return i.lastMatchPlayed ? "Played last match" : "";
      }
    }
    return "";
  }

  getPoint(pid) {
    for (var i in Pointlist) {
      if (pid.toString() == i.pid.toString()) {
        return i.total_point;
      }
    }
    return null;
  }

  def() {
    return Expanded(
      child: ConstanceData.soccerTeamCombine.isEmpty ||
              ConstanceData.soccerTeamCombine.length <= 0
          ? Container()
          : ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: defs.length,
              itemBuilder: (contx, index) {
                SoccerPlayer data = defs[index];

                return InkWell(
                  onTap: () {
                    Add_remove(data, () {
                      if (DEF >= 0 && DEF < 5) {
                        setState(() {
                          ConstanceData.soccerSelectedPlayers.add(data);
                          totalCredit -=
                              double.parse(data.fantasy_player_rating);
                          DEF++;
                          addTeam(data.pid.toString());
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Minimum 3 and maximum 5 Defenders allowed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }, () {
                      removeIT(data);
                      minusTeam(data.pid);
                      setState(() {
                        totalCredit += double.parse(data.fantasy_player_rating);
                        DEF--;
                      });
                    });
                  },
                  child: TeamCardView(
                    txt1:
                        "${whichTeam(data.pid.toString()) == 'a' ? widget.match.teams.home.abbr : widget.match.teams.away.abbr}",
                    txt2: AppLocalizations.of('${data.name}'),
                    txt3: AppLocalizations.of(
                        'Sel by ${getSelby(data.pid.toString())}%'),
                    txt4: checkIfAnounced(data.pid.toString())
                        ? AppLocalizations.of('Announced')
                        : lastMatchPlayed(data.pid.toString()),
                    txt5:
                        "${getPoint(data.pid) == null ? 0 : getPoint(data.pid)}",
                    txt6: "${data.fantasy_player_rating.toString()}",
                    txt7: whichTeam(data.pid.toString()),
                    image1: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.asset(
                        'assets/images/${data.name.toString().trim().toLowerCase()}.webp',
                        fit: BoxFit.fill,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace stackTrace) {
                          return Image.asset(ConstanceData.defaultPlayer);
                        },
                      ),
                    ),
                    selected: !contains(data),
                  ),
                );
              }),
    );
  }

  mid() {
    return Expanded(
      child: ConstanceData.soccerTeamCombine.isEmpty ||
              ConstanceData.soccerTeamCombine.length <= 0
          ? Container()
          : ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: mids.length,
              itemBuilder: (contx, index) {
                SoccerPlayer data = mids[index];

                return InkWell(
                  onTap: () {
                    Add_remove(data, () {
                      if (MID >= 0 && MID < 5) {
                        setState(() {
                          ConstanceData.soccerSelectedPlayers.add(data);
                          totalCredit -=
                              double.parse(data.fantasy_player_rating);
                          MID++;
                          addTeam(data.pid.toString());
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Minimum 3 and maximum 5 Mid-Fielders allowed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }, () {
                      removeIT(data);
                      minusTeam(data.pid);
                      setState(() {
                        totalCredit += double.parse(data.fantasy_player_rating);
                        MID--;
                      });
                    });
                  },
                  child: TeamCardView(
                    txt1:
                        "${whichTeam(data.pid.toString()) == 'a' ? widget.match.teams.home.abbr : widget.match.teams.away.abbr}",
                    txt2: AppLocalizations.of('${data.name}'),
                    txt3: AppLocalizations.of(
                        'Sel by ${getSelby(data.pid.toString())}%'),
                    txt4: checkIfAnounced(data.pid.toString())
                        ? AppLocalizations.of('Announced')
                        : lastMatchPlayed(data.pid.toString()),
                    txt5:
                        "${getPoint(data.pid) == null ? 0 : getPoint(data.pid)}",
                    txt6: "${data.fantasy_player_rating.toString()}",
                    txt7: whichTeam(data.pid.toString()),
                    image1: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.asset(
                        'assets/images/${data.name.toString().trim().toLowerCase()}.webp',
                        fit: BoxFit.fill,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace stackTrace) {
                          return Image.asset(ConstanceData.defaultPlayer);
                        },
                      ),
                    ),
                    selected: !contains(data),
                  ),
                );
              }),
    );
  }

  st() {
    return Expanded(
      child: ConstanceData.soccerTeamCombine.isEmpty ||
              ConstanceData.soccerTeamCombine.length <= 0
          ? Container()
          : ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: sts.length,
              itemBuilder: (contx, index) {
                SoccerPlayer data = sts[index];

                return InkWell(
                  onTap: () {
                    Add_remove(data, () {
                      if (ST >= 0 && ST < 3) {
                        setState(() {
                          ConstanceData.soccerSelectedPlayers.add(data);
                          totalCredit -=
                              double.parse(data.fantasy_player_rating);
                          ST++;
                          addTeam(data.pid.toString());
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Minimum 3 and maximum 5 Mid-Fielders allowed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }, () {
                      removeIT(data);
                      minusTeam(data.pid);
                      setState(() {
                        totalCredit += double.parse(data.fantasy_player_rating);
                        ST--;
                      });
                    });
                  },
                  child: TeamCardView(
                    txt1:
                        "${whichTeam(data.pid.toString()) == 'a' ? widget.match.teams.home.abbr : widget.match.teams.away.abbr}",
                    txt2: AppLocalizations.of('${data.name}'),
                    txt3: AppLocalizations.of(
                        'Sel by ${getSelby(data.pid.toString())}%'),
                    txt4: checkIfAnounced(data.pid.toString())
                        ? AppLocalizations.of('Announced')
                        : lastMatchPlayed(data.pid.toString()),
                    txt5:
                        "${getPoint(data.pid) == null ? 0 : getPoint(data.pid)}",
                    txt6: "${data.fantasy_player_rating.toString()}",
                    txt7: whichTeam(data.pid.toString()),
                    image1: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.asset(
                        'assets/images/${data.name.toString().trim().toLowerCase()}.webp',
                        fit: BoxFit.fill,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace stackTrace) {
                          return Image.asset(ConstanceData.defaultPlayer);
                        },
                      ),
                    ),
                    selected: !contains(data),
                  ),
                );
              }),
    );
  }

  Widget customContainer(Color color) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: color,
      ),
    );
  }
  void mainReduce() {
    setState(() {
      reduce(ConstanceData
          .soccerSelectedPlayers[ConstanceData.soccerSelectedPlayers.length - 1]);
      totalCredit += double.parse(ConstanceData
          .soccerSelectedPlayers[ConstanceData.soccerSelectedPlayers.length - 1]
          .fantasy_player_rating);
      ConstanceData.soccerSelectedPlayers.removeLast();
    });

  }
  void reduce(SoccerPlayer selectedPlayer) {
    if (selectedPlayer.positiontype.toString().trim() == 'G') {
      setState(() {
        GK--;
        minusTeam(selectedPlayer.pid.toString());
      });
    } else if (selectedPlayer.positiontype.toString().trim() == "D") {
      setState(() {
        DEF--;
        minusTeam(selectedPlayer.pid.toString());
      });
    } else if (selectedPlayer.positiontype.toString().trim() == "M") {
      setState(() {
        MID--;
        minusTeam(selectedPlayer.pid.toString());
      });
    } else {
      setState(() {
        ST--;
        minusTeam(selectedPlayer.pid.toString());
      });
    }
  }
}
