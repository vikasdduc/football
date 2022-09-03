import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/GetTeam.dart';
import 'package:fantacySports/Model/Players.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/constance/constance.dart' as constance;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Networking/AccessNetwork.dart';
import '../Live/Team_points_preview.dart';
import '../createTeam/teamPreview.dart';
import 'copyTeam.dart';
import 'editTeam.dart';

class MyTeamPage extends StatefulWidget {
  final competition_Id, match_id, type, match, time;
  List<GetTeam> data;
  Function onTap;

  MyTeamPage(this.competition_Id, this.match_id, this.type, this.match,
      this.time, this.data, this.onTap);

  @override
  _MyTeamPageState createState() => _MyTeamPageState();
}

class _MyTeamPageState extends State<MyTeamPage> {
  // List<GetTeam> data;
  bool isLive = false;
  DateTime currentTime;

  var totalpoint = 0.0;

  var countA = 0, countB = 0;

  AlertDialog alert;
  List<double> total_points = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: widget.data != null && widget.data.length > 0
            ? ListView.builder(
                padding: EdgeInsets.only(top: 15.0),
                itemCount: widget.data.length,
                itemBuilder: (cont, count) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Card(
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // image: DecorationImage(
                          //   image: AssetImage(ConstanceData.cricketGround),
                          // ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        height: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  // color: Color(0xff0b8f01),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      ConstanceData.cricketGround,
                                    ),
                                    fit: BoxFit.cover,
                                    opacity: 0.9,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4),
                                          topRight: Radius.circular(4),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(
                                                  '${ConstanceData.prof.team_name} (T${count + 1})'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ),
                                            ),
                                            Expanded(child: SizedBox()),
                                            !isLive
                                                ? GestureDetector(
                                                    onTap: () => {
                                                      if (!isLive)
                                                        {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => EditTeamPage(
                                                                  widget.match,
                                                                  widget.time
                                                                      .millisecondsSinceEpoch,
                                                                  ConstanceData
                                                                      .mylist,
                                                                  getTeamA(
                                                                      count),
                                                                  getTeamB(
                                                                      count),
                                                                  widget
                                                                      .data[
                                                                          count]
                                                                      .id
                                                                      .toString()),
                                                            ),
                                                          ).then((_) => {
                                                                showLoaderDialog(
                                                                    context),
                                                                access_network()
                                                                    .getTeam()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              setValues(value),
                                                                            }),
                                                              }),
                                                        }
                                                      else
                                                        {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "The match is about to start",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .CENTER,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 16.0),
                                                        }
                                                    },
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                  )
                                                : Container(),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            !isLive
                                                ? GestureDetector(
                                                    onTap: () {
                                                      if (!isLive) {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                CopyTeamPage(
                                                              widget.match,
                                                              widget
                                                                  .competition_Id,
                                                              widget.match_id,
                                                              widget.time
                                                                  .millisecondsSinceEpoch,
                                                              ConstanceData
                                                                  .mylist,
                                                              getTeamA(count),
                                                              getTeamB(count),
                                                              widget.data[count]
                                                                  .id
                                                                  .toString(),
                                                            ),
                                                          ),
                                                        ).then((_) => {
                                                              showLoaderDialog(
                                                                  context),
                                                              access_network()
                                                                  .getTeam()
                                                                  .then(
                                                                      (value) =>
                                                                          {
                                                                            setValues(value),
                                                                          })
                                                            });
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "The match is about to start",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .CENTER,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.copy,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                  )
                                                : Container(),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            !isLive
                                                ? GestureDetector(
                                                    onTap: () {
                                                      if (!isLive) {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                TeamPreViewPage(
                                                                    getTeamA(
                                                                        count),
                                                                    getTeamB(count)[
                                                                            0]
                                                                        .pid,
                                                                    getTeamB(count)[
                                                                            1]
                                                                        .pid,
                                                                    widget
                                                                        .match
                                                                        .teama
                                                                        .short_name,
                                                                    widget
                                                                        .match
                                                                        .teamb
                                                                        .short_name),
                                                          ),
                                                        );
                                                      } else {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => team_points_preview(
                                                                getTeamB(count)[
                                                                        0]
                                                                    .pid,
                                                                getTeamB(count)[
                                                                        1]
                                                                    .pid,
                                                                getTeamA(count),
                                                                total_points
                                                                        .isNotEmpty
                                                                    ? total_points[
                                                                        count]
                                                                    : 0,
                                                                widget
                                                                    .match
                                                                    .teama
                                                                    .short_name,
                                                                widget
                                                                    .match
                                                                    .teamb
                                                                    .short_name,
                                                                "",
                                                                widget
                                                                    .data[count]
                                                                    .id),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.folder,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          !isLive ||
                                                  !findthismatch(
                                                      widget.data[count])
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${widget.match.teama.short_name}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption
                                                          .copyWith(
                                                            color: Colors.white,
                                                            letterSpacing: 0.6,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10,
                                                          ),
                                                    ),
                                                    Text(
                                                      "${getTeamAcount(count)}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption
                                                          .copyWith(
                                                            color: Colors.white,
                                                            letterSpacing: 0.6,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ),
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                          isLive &&
                                                  findthismatch(
                                                      widget.data[count])
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 100,
                                                      child: Text(
                                                        "${widget.match.short_title}",
                                                        softWrap: true,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption
                                                            .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              letterSpacing:
                                                                  0.6,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 10,
                                                            ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => team_points_preview(
                                                                getTeamB(count)[
                                                                        0]
                                                                    .pid,
                                                                getTeamB(count)[
                                                                        1]
                                                                    .pid,
                                                                getTeamA(count),
                                                                total_points
                                                                        .isNotEmpty
                                                                    ? total_points[
                                                                        count]
                                                                    : 0,
                                                                widget
                                                                    .match
                                                                    .teama
                                                                    .short_name,
                                                                widget
                                                                    .match
                                                                    .teamb
                                                                    .short_name,
                                                                "",
                                                                widget
                                                                    .data[count]
                                                                    .id),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        "${total_points.isNotEmpty ? total_points[count] : 0}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption
                                                            .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              letterSpacing:
                                                                  0.6,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          !isLive ||
                                                  !findthismatch(
                                                      widget.data[count])
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${widget.match.teamb.short_name}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption
                                                          .copyWith(
                                                            color: Colors.white,
                                                            letterSpacing: 0.6,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10,
                                                          ),
                                                    ),
                                                    Text(
                                                      "${getTeamBCount(count)}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption
                                                          .copyWith(
                                                            color: Colors.white,
                                                            letterSpacing: 0.6,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ),
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                          Expanded(child: SizedBox()),
                                          playerDetail(
                                            AppLocalizations.of(
                                                '${getCap(count) != null ? short_the_name(getCap(count).title) : ''}'),
                                            "C",
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              child: Image.asset(
                                                'assets/images/${getCap(count).title.toString().trim().toLowerCase()}.webp',
                                                fit: BoxFit.fill,
                                                height: 25,
                                                width: 25,
                                                errorBuilder:
                                                    (BuildContext context,
                                                        Object exception,
                                                        StackTrace stackTrace) {
                                                  return Image.asset(
                                                      ConstanceData
                                                          .defaultPlayer);
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          playerDetail(
                                            AppLocalizations.of(
                                                '${getVice(count) != null ? short_the_name(getVice(count).title) : ''}'),
                                            "VC",
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              child: Image.asset(
                                                'assets/images/${getVice(count).title.toString().trim().toLowerCase()}.webp',
                                                fit: BoxFit.fill,
                                                errorBuilder:
                                                    (BuildContext context,
                                                        Object exception,
                                                        StackTrace stackTrace) {
                                                  return Image.asset(
                                                      ConstanceData
                                                          .defaultPlayer);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .color
                                      .withOpacity(0.5),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(4),
                                    bottomRight: Radius.circular(4),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of('WK'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                              color: Colors.black45,
                                              letterSpacing: 0.6,
                                              fontSize: 12,
                                            ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${wks(count)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .color,
                                              letterSpacing: 0.6,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                      ),
                                      Expanded(child: SizedBox()),
                                      Text(
                                        AppLocalizations.of('BAT'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                              color: Colors.black45,
                                              letterSpacing: 0.6,
                                              fontSize: 12,
                                            ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${bats(count)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .color,
                                              letterSpacing: 0.6,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                      ),
                                      Expanded(child: SizedBox()),
                                      Text(
                                        AppLocalizations.of('AR'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                              color: Colors.black45,
                                              letterSpacing: 0.6,
                                              fontSize: 12,
                                            ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${alls(count)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .color,
                                              letterSpacing: 0.6,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                      ),
                                      Expanded(child: SizedBox()),
                                      Text(
                                        AppLocalizations.of('BOWL'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                              color: Colors.black45,
                                              letterSpacing: 0.6,
                                              fontSize: 12,
                                            ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${bowls(count)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .color,
                                              letterSpacing: 0.6,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/team.webp',
                        fit: BoxFit.cover,
                        scale: 1.5,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Oops! you have not created any team',
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText2.color,
                              letterSpacing: 0.6,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget playerDetail(String txt1, String txt2, Widget image1) {
    return Stack(
      //alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Container(height: 55, width: 55, child: image1),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: Colors.white,
                child: Container(
                  width: 55,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 6, right: 2, top: 2, bottom: 2),
                    child: Text(
                      txt1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Colors.black,
                            letterSpacing: 0.1,
                            fontWeight: FontWeight.bold,
                            fontSize: 8,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 18,
          width: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border:
                Border.all(color: Theme.of(context).textTheme.headline6.color),
          ),
          child: Center(
            child: Text(
              txt2,
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: Colors.black,
                    letterSpacing: 0.6,
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    fetchPoints();
    currentTime = new DateTime.now().add(Duration(hours: 5, minutes: 30));
    Future.delayed(Duration.zero, () {
      if (mounted) {
        setState(() {
          widget.data = filterContent(ConstanceData.mylist, widget.match_id);
          widget.onTap();
        });
      } else {
        widget.data = filterContent(ConstanceData.mylist, widget.match_id);
        widget.onTap();
      }
    });
    Future.delayed(Duration(seconds: 1), () {
      // showLoaderDialog(context);
      access_network().getTeam().then((value) => {
            setValues(value),
          });
    });
    if (widget.time.isBefore(DateTime.now())) {
      if (mounted) {
        try {
          setState(() {
            isLive = true;
          });
        } catch (e) {
          print(e);
          isLive = true;
        }
      } else {
        isLive = true;
      }
    } else {}

    super.initState();
  }

  List<GetTeam> filterContent(List<GetTeam> mylist, match_id) {
    List<GetTeam> list = new List<GetTeam>();
    for (var i in mylist) {
      if (i.match_id.toString() == match_id.toString()) {
        list.add(i);
      } else {}
    }
    return list;
  }

  getCap(count) {
    var current = widget.data[count];
    var capId = current.team_B.toString().split(',')[0];

    for (var p in ConstanceData.teamCombine) {
      if (capId.toString() == p.pid.toString()) {
        return p;
      }
    }
  }

  getVice(count) {
    var current = widget.data[count];
    var viceId = current.team_B.toString().split(',')[1];
    for (var p in ConstanceData.teamCombine) {
      if (viceId.toString() == p.pid.toString()) {
        return p;
      }
    }
  }

  getTeam(count) {
    if (widget.type == constance.CompetitionType.def) {
    } else if (widget.type == constance.CompetitionType.live) {
    } else if (widget.type == constance.CompetitionType.upcoming) {
    } else {}
  }

  wks(count) {
    int cnt = 0;
    var current = widget.data[count];
    for (var i in current.team_A.toString().split(',')) {
      for (var j in ConstanceData.teamCombine) {
        if (i == j.pid.toString() && j.playing_role == 'wk') {
          cnt++;
        }
      }
    }
    return cnt;
  }

  bats(count) {
    int cnt = 0;
    var current = widget.data[count];
    for (var i in current.team_A.toString().split(',')) {
      for (var j in ConstanceData.teamCombine) {
        if (i == j.pid.toString() && j.playing_role == 'bat') {
          cnt++;
        }
      }
    }
    return cnt;
  }

  alls(count) {
    int cnt = 0;
    var current = widget.data[count];
    for (var i in current.team_A.toString().split(',')) {
      for (var j in ConstanceData.teamCombine) {
        if (i == j.pid.toString() && j.playing_role == 'all') {
          cnt++;
        }
      }
    }
    return cnt;
  }

  bowls(count) {
    int cnt = 0;
    var current = widget.data[count];
    for (var i in current.team_A.toString().split(',')) {
      for (var j in ConstanceData.teamCombine) {
        if (i == j.pid.toString() && j.playing_role == 'bowl') {
          cnt++;
        }
      }
    }
    return cnt;
  }

  getTotalPoint(count) async {
    totalpoint = 0;
    access_network().getMatchPlayerPoint(widget.data[0].id).then((value) {
      if (value.status ?? false) {
        // points = value.players;
        // total_points = value.total_point;
        return value.total_point;
      } else {
        print('error');
        return 0;
      }
    });
  }

  List<players> getTeamA(count) {
    List<players> list = new List<players>();
    for (var i in widget.data[count].team_A.toString().split(',')) {
      for (var j in ConstanceData.teamCombine) {
        if (i == j.pid.toString()) {
          list.add(j);
        }
      }
    }
    return list;
  }

  List<players> getTeamB(int count) {
    List<players> list = new List<players>();
    for (var i in widget.data[count].team_B.toString().split(',')) {
      for (var j in ConstanceData.teamCombine) {
        if (i == j.pid.toString()) {
          list.add(j);
        }
      }
    }
    return list;
  }

  List<players> filterWK(List<players> teamCombine) {
    List<players> list = new List<players>();
    for (var i in teamCombine) {
      if (i.playing_role == "wk") {
        list.add(i);
      }
    }

    return list;
  }

  List<players> filterALL(List<players> teamCombine) {
    List<players> list = new List<players>();
    for (var i in teamCombine) {
      if (i.playing_role == "all") {
        list.add(i);
      }
    }

    return list;
  }

  List<players> filterbat(List<players> teamCombine) {
    List<players> list = new List<players>();
    for (var i in teamCombine) {
      if (i.playing_role == "bat") {
        list.add(i);
      }
    }

    return list;
  }

  List<players> filterbowl(List<players> teamCombine) {
    List<players> list = new List<players>();
    for (var i in teamCombine) {
      if (i.playing_role == "bowl") {
        list.add(i);
      }
    }

    return list;
  }

  getTeamBCount(count) {
    var countB = 0;
    var current = widget.data[count];
    for (var i in current.team_A.toString().split(',')) {
      for (var j in ConstanceData.teamB) {
        if (i == j.pid.toString()) {
          countB++;
        }
      }
    }
    return countB;
  }

  getTeamAcount(count) {
    var countA = 0;
    var current = widget.data[count];
    for (var i in current.team_A.toString().split(',')) {
      for (var j in ConstanceData.teamA) {
        if (i == j.pid.toString()) {
          countA++;
        }
      }
    }
    return countA;
  }

  setValues(value) {
    if (value != null && value.length != 0) {
      if (mounted) {
        setState(() {
          ConstanceData.setMyList(value);
          widget.data = filterContent(ConstanceData.mylist, widget.match_id);

          widget.onTap();
        });
      } else {
        ConstanceData.setMyList(value);
        widget.data = filterContent(ConstanceData.mylist, widget.match_id);

        widget.onTap();
      }
      if (alert != null) {
        Navigator.pop(context);
      } else {}
    } else {
      if (alert != null) {
        Navigator.pop(context);
      } else {}
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

  bool findthismatch(GetTeam data) {
    for (var i in ConstanceData.specific_contests) {
      for (var j in i.team) {
        if (j.id.toString() == data.id.toString()) {
          return true;
        }
      }
    }
    return false;
  }

  short_the_name(title) {
    try {
      var txt = title.toString().split(' ');
      return '${txt[0].substring(0, 1)}. ${txt[1]}';
    } catch (e) {
      print(e);
      return title;
    }
  }

  Future<void> fetchPoints() async {
    for (var i in widget.data) {
      final response = await access_network().getMatchPlayerPoint(i.id);
      if (response.status) {
        total_points.add(response.total_point);
      } else {
        total_points.add(0);
      }
    }
  }
}
