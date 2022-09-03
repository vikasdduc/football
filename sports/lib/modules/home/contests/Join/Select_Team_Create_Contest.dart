import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../Language/appLocalizations.dart';
import '../../../../Networking/AccessNetwork.dart';
import '../../../../constance/constance.dart';

class select_team_create_contest extends StatefulWidget {
  final dataTeams, match, name, totalPrize, fee, size, winners, coupon;

  select_team_create_contest(this.dataTeams, this.match, this.name,
      this.totalPrize, this.fee, this.size, this.winners, this.coupon);

  @override
  State<select_team_create_contest> createState() =>
      _select_team_create_contestState();
}

class _select_team_create_contestState
    extends State<select_team_create_contest> {
  int selectedRadioTile;

  @override
  void initState() {
    super.initState();
    // selectedRadio = 0;
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      child: Column(
        children: [
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
                            AppLocalizations.of('Select Team'),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
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
          Expanded(
            child: Container(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 15.0),
                itemCount: widget.dataTeams.length,
                itemBuilder: (cont, count) {
                  return Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 35),
                        child: Card(
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                                left: 20, right: 20),
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
                                                        letterSpacing: 0.6,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                      ),
                                                ),
                                                Expanded(child: SizedBox()),
                                                // !isLive
                                                //     ? GestureDetector(
                                                //   onTap: () {
                                                //     if (!isLive) {
                                                //       Navigator.push(
                                                //         context,
                                                //         MaterialPageRoute(
                                                //           builder: (context) =>
                                                //               TeamPreViewPage(
                                                //                   getTeamA(
                                                //                       count),
                                                //                   getTeamB(count)[
                                                //                   0]
                                                //                       .pid,
                                                //                   getTeamB(count)[
                                                //                   1]
                                                //                       .pid,
                                                //                   widget
                                                //                       .match
                                                //                       .teama
                                                //                       .short_name,
                                                //                   widget
                                                //                       .match
                                                //                       .teamb
                                                //                       .short_name),
                                                //         ),
                                                //       );
                                                //     } else {
                                                //       Navigator.push(
                                                //         context,
                                                //         MaterialPageRoute(
                                                //           builder: (context) => team_points_preview(
                                                //               getTeamB(count)[
                                                //               0]
                                                //                   .pid,
                                                //               getTeamB(count)[
                                                //               1]
                                                //                   .pid,
                                                //               getTeamA(count),
                                                //               getTotalPoint(
                                                //                   count),
                                                //               widget
                                                //                   .match
                                                //                   .teama
                                                //                   .short_name,
                                                //               widget
                                                //                   .match
                                                //                   .teamb
                                                //                   .short_name),
                                                //         ),
                                                //       );
                                                //     }
                                                //   },
                                                //   child: Icon(
                                                //     Icons.folder,
                                                //     color: Colors.white,
                                                //     size: 18,
                                                //   ),
                                                // )
                                                //     : Container(),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
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
                                                          fontSize: 14,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 100,
                                                    child: Center(
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
                                                  ),
                                                  // GestureDetector(
                                                  //   onTap: () {
                                                  //     Navigator.push(
                                                  //       context,
                                                  //       MaterialPageRoute(
                                                  //         builder: (context) => team_points_preview(
                                                  //             getTeamB(count)[
                                                  //             0]
                                                  //                 .pid,
                                                  //             getTeamB(count)[
                                                  //             1]
                                                  //                 .pid,
                                                  //             getTeamA(count),
                                                  //             getTotalPoint(
                                                  //                 count),
                                                  //             widget
                                                  //                 .match
                                                  //                 .teama
                                                  //                 .short_name,
                                                  //             widget
                                                  //                 .match
                                                  //                 .teamb
                                                  //                 .short_name),
                                                  //       ),
                                                  //     );
                                                  //   },
                                                  //   child: Text(
                                                  //     "${getTotalPoint(count)}",
                                                  //     textAlign:
                                                  //     TextAlign.center,
                                                  //     style: Theme.of(context)
                                                  //         .textTheme
                                                  //         .caption
                                                  //         .copyWith(
                                                  //       color:
                                                  //       Colors.white,
                                                  //       letterSpacing:
                                                  //       0.6,
                                                  //       fontWeight:
                                                  //       FontWeight
                                                  //           .bold,
                                                  //       fontSize: 14,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Column(
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
                                                          fontSize: 14,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(child: SizedBox()),
                                              playerDetail(
                                                AppLocalizations.of(
                                                    '${getCap(count) != null ? short_the_name(getCap(count).title) : ''}'),
                                                "C",
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  child: Image.asset(
                                                    'assets/images/${getCap(count).title.toString().trim().toLowerCase()}.webp',
                                                    fit: BoxFit.fill,
                                                    height: 25,
                                                    width: 25,
                                                    errorBuilder: (BuildContext
                                                            context,
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
                                                width: 5,
                                              ),
                                              playerDetail(
                                                AppLocalizations.of(
                                                    '${getVice(count) != null ? short_the_name(getVice(count).title) : ''}'),
                                                "VC",
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  child: Image.asset(
                                                    'assets/images/${getVice(count).title.toString().trim().toLowerCase()}.webp',
                                                    fit: BoxFit.fill,
                                                    errorBuilder: (BuildContext
                                                            context,
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
                      ),
                      Radio(
                        groupValue: selectedRadioTile,
                        onChanged: (val) {
                          setState(() {
                            setSelectedRadioTile(val);
                          });
                        },
                        value: count,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Card(
            elevation: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: 15,
                bottom: 15,
                right: 10,
                left: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      child: InkWell(
                        splashColor: Colors.grey.shade800,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        onTap: () {
                          access_network()
                              .create_contest(
                                  '0',
                                  widget.totalPrize,
                                  widget.fee,
                                  widget.size,
                                  ConstanceData.prof.id.toString(),
                                  widget.name,
                                  widget.winners)
                              .then((value1) {
                            access_network()
                                .join_contest(
                                    value1['contest_id'].toString(),
                                    ConstanceData.prof.id.toString(),
                                    widget.match.match_id.toString(),
                                    widget.match.cid.toString(),
                                    widget.dataTeams[selectedRadioTile].id
                                        .toString(),
                                    widget.coupon)
                                .then((value2) {
                              Fluttertoast.showToast(
                                  msg: "${value2.message}",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              if (value2.status) {
                                access_network().getTeam().then((value3) {
                                  fetchContest();
                                  // Navigator.pushReplacementNamed(context, Routes.HOME);
                                });
                              }
                            });
                          });
                        },
                        child: Container(
                          height: 40,
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              'Join Contest',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  wks(count) {
    int cnt = 0;
    var current = widget.dataTeams[count];
    for (var i in current.team_A.toString().split(',')) {
      for (var j in ConstanceData.teamCombine) {
        if (i == j.pid.toString() && j.playing_role == 'wk') {
          cnt++;
        }
      }
    }
    return cnt;
  }

  void fetchContest() {
    access_network()
        .getCompletions(widget.match.match_id.toString())
        .then((value) => {
              ConstanceData.setContests(value),
              Navigator.popUntil(context, ModalRoute.withName("/home")),
            });
  }

  bats(count) {
    int cnt = 0;
    var current = widget.dataTeams[count];
    for (var i in current.team_A.toString().split(',')) {
      for (var j in ConstanceData.teamCombine) {
        if (i == j.pid.toString() && j.playing_role == 'bat') {
          cnt++;
        }
      }
    }
    return cnt;
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

  alls(count) {
    int cnt = 0;
    var current = widget.dataTeams[count];
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
    var current = widget.dataTeams[count];
    for (var i in current.team_A.toString().split(',')) {
      for (var j in ConstanceData.teamCombine) {
        if (i == j.pid.toString() && j.playing_role == 'bowl') {
          cnt++;
        }
      }
    }
    return cnt;
  }

  getTeamAcount(count) {
    var countA = 0;
    var current = widget.dataTeams[count];
    for (var i in current.team_A.toString().split(',')) {
      for (var j in ConstanceData.teamA) {
        if (i == j.pid.toString()) {
          countA++;
        }
      }
    }
    return countA;
  }

  getTeamBCount(count) {
    var countB = 0;
    var current = widget.dataTeams[count];
    for (var i in current.team_A.toString().split(',')) {
      for (var j in ConstanceData.teamB) {
        if (i == j.pid.toString()) {
          countB++;
        }
      }
    }
    return countB;
  }

  getCap(count) {
    var current = widget.dataTeams[count];
    var capId = current.team_B.toString().split(',')[0];

    for (var p in ConstanceData.teamCombine) {
      if (capId.toString() == p.pid.toString()) {
        return p;
      }
    }
  }

  getVice(count) {
    var current = widget.dataTeams[count];
    var viceId = current.team_B.toString().split(',')[1];
    for (var p in ConstanceData.teamCombine) {
      if (viceId.toString() == p.pid.toString()) {
        return p;
      }
    }
  }

  short_the_name(title) {
    var txt = title.toString().split(' ');
    return '${txt[0].substring(0, 1)}. ${txt[1]}';
  }
}
