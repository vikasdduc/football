import 'package:fantacySports/Model/generic_response.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../Language/appLocalizations.dart';
import '../../../../Model/GetTeam.dart';
import '../../../../Model/Players.dart';
import '../../../../Networking/AccessNetwork.dart';
import '../../../../constance/constance.dart';
import '../Admin Contests/addToWallet_admin.dart';

class select_team extends StatefulWidget {
  final match, contestId, coupon, data,index,time,compId,matchID;
  List<GetTeam> dataTeams;

  select_team(
      this.match, this.dataTeams, this.contestId, this.coupon, this.data,this.index,this.time,this.compId,this.matchID);

  @override
  State<select_team> createState() => _select_teamState();
}

class _select_teamState extends State<select_team> {
  List<int> selectedRadioTile;
  int selectedRadio = 0;

  @override
  void initState() {
    initList();
    super.initState();
  }

  setSelectedRadioTile(int val, ind) {
    print(val);
    setState(() {
      selectedRadioTile[ind] = val;
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
                                              left: 10, right: 5),
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                              ),
                                              // Column(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.center,
                                              //   crossAxisAlignment:
                                              //       CrossAxisAlignment.center,
                                              //   children: [
                                              //     SizedBox(
                                              //       width: 100,
                                              //       child: Center(
                                              //         child: Text(
                                              //           "${widget.match.short_title}",
                                              //           softWrap: true,
                                              //           style: Theme.of(context)
                                              //               .textTheme
                                              //               .caption
                                              //               .copyWith(
                                              //                 color:
                                              //                     Colors.white,
                                              //                 letterSpacing:
                                              //                     0.6,
                                              //                 fontWeight:
                                              //                     FontWeight
                                              //                         .bold,
                                              //                 fontSize: 10,
                                              //               ),
                                              //         ),
                                              //       ),
                                              //     ),
                                              //     // GestureDetector(
                                              //     //   onTap: () {
                                              //     //     Navigator.push(
                                              //     //       context,
                                              //     //       MaterialPageRoute(
                                              //     //         builder: (context) => team_points_preview(
                                              //     //             getTeamB(count)[
                                              //     //             0]
                                              //     //                 .pid,
                                              //     //             getTeamB(count)[
                                              //     //             1]
                                              //     //                 .pid,
                                              //     //             getTeamA(count),
                                              //     //             getTotalPoint(
                                              //     //                 count),
                                              //     //             widget
                                              //     //                 .match
                                              //     //                 .teama
                                              //     //                 .short_name,
                                              //     //             widget
                                              //     //                 .match
                                              //     //                 .teamb
                                              //     //                 .short_name),
                                              //     //       ),
                                              //     //     );
                                              //     //   },
                                              //     //   child: Text(
                                              //     //     "${getTotalPoint(count)}",
                                              //     //     textAlign:
                                              //     //     TextAlign.center,
                                              //     //     style: Theme.of(context)
                                              //     //         .textTheme
                                              //     //         .caption
                                              //     //         .copyWith(
                                              //     //       color:
                                              //     //       Colors.white,
                                              //     //       letterSpacing:
                                              //     //       0.6,
                                              //     //       fontWeight:
                                              //     //       FontWeight
                                              //     //           .bold,
                                              //     //       fontSize: 14,
                                              //     //     ),
                                              //     //   ),
                                              //     // ),
                                              //   ],
                                              // ),

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
                                              SizedBox(
                                                width: 10,
                                              ),
                                              // Expanded(child: SizedBox()),
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
                        groupValue: selectedRadioTile[count],
                        onChanged: (val) {
                          setState(() {
                            setSelectedRadioTile(val, count);
                          });
                        },
                        value: int.parse(widget.dataTeams[count].id),
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
                          if (int.parse(
                                  ConstanceData.prof.balance.toString()) >=
                              int.parse(widget.data.entry.toString()) *
                                  selectedRadioTile.length) {
                            JoinContest();
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddToWalletAdmin(
                                      (getFee()).toString(),
                                      List<players>.empty(),
                                      widget.index,
                                      widget.time,
                                      widget.compId,
                                      widget.matchID,
                                      widget.contestId,
                                      widget.dataTeams,
                                      widget.coupon,
                                      widget.data.entry.toString(),
                                      selectedRadioTile[0].toString(),
                                      selectedRadioTile),
                                ));
                          }
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
  getFee() {
    return int.parse(widget.data.entry.toString());
    // var amount = int.parse(widget.data.entry.toString()) -
    //     int.parse(ConstanceData.prof.balance.toString());
    // if (amount >= 0) {
    //   return amount;
    // } else {
    //   return int.parse(widget.data.entry.toString()).toString();
    // }
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

  void initList() {
    selectedRadioTile = [];
    for (var i in widget.dataTeams) {
      selectedRadioTile.add(0);
    }
  }

  Future<GenericResponse> join(int length) async {
    if (length > 1) {
      return await access_network().join_multiple_contest(
          widget.contestId.toString(),
          ConstanceData.prof.id.toString(),
          widget.match.match_id.toString(),
          widget.match.cid.toString(),
          // widget.dataTeams[selectedRadioTile[0]].id.toString(),
          selectedRadioTile[0].toString(),
          widget.coupon,
          selectedRadioTile);
    } else {
      return await access_network().join_contest(
          widget.contestId.toString(),
          ConstanceData.prof.id.toString(),
          widget.match.match_id.toString(),
          widget.match.cid.toString(),
          selectedRadioTile[0].toString(),
          widget.coupon);
    }
  }

  void JoinContest() {
    join(selectedRadioTile.length).then((value2) {
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
          print('${value2.message}');
          if (value2.status) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return new AlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Text(
                        'Contest Joined Successfully',
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                      ),
                    ],
                  ),
                  content: Container(
                    height: 85,
                    decoration: BoxDecoration(
                        // color: Colors.green.withOpacity(0.1),
                        // border: Border(bottom: BorderSide(color: Colors.green)),
                        ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 12, left: 10, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of('Total Fee'),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.black,
                                      letterSpacing: 0.6,
                                      fontSize: 12,
                                    ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${ConstanceData.contest_joined_bill.total_fee}',
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
                                      fontSize: 16,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(
                                    'To be deducted from wallet'),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.black,
                                      letterSpacing: 0.6,
                                      fontSize: 12,
                                    ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${ConstanceData.contest_joined_bill.deducted}',
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
                                      fontSize: 16,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of('Total payable'),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.black,
                                      letterSpacing: 0.6,
                                      fontSize: 12,
                                    ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${ConstanceData.contest_joined_bill.payable}',
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
                                      fontSize: 16,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Card(
                        color: Colors.green,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(
                                color: Colors.green,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          padding: EdgeInsets.all(7),
                          child: new Text(
                            'Done',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ).whenComplete(() {
              ConstanceData.contest_joined_bill = null;
              fetchContest();
            });
          } else {
            ConstanceData.contest_joined_bill = null;
            fetchContest();
          }
          // Navigator.pushReplacementNamed(context, Routes.HOME);
        });
      }
    });
  }
}
