import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/Players.dart';
import 'package:fantacySports/modules/createTeam/chooseCaptain.dart';
import 'package:fantacySports/modules/createTeam/teamPreview.dart';
import 'package:fantacySports/widget/teamCardView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Model/player_point.dart';
import '../../Networking/AccessNetwork.dart';
import '../../constance/constance.dart';
import '../../widget/customButton.dart';

class CreateTeamPage extends StatefulWidget {
  final list, index, compId, matchID, time;

  CreateTeamPage(this.list, this.index, this.compId, this.matchID, this.time);

  @override
  _CreateTeamPageState createState() => _CreateTeamPageState();
}

enum selectedTeam { TeamA, TeamB, Both }

class _CreateTeamPageState extends State<CreateTeamPage> {
  bool isWk = true;
  bool isBAT = false;
  bool isAR = false;
  bool isBowl = false;
  var wks, alls, bats, bowls;
  int WK = 0, ALL = 0, BAT = 0, BOWL = 0;
  int teama = 0, teamb = 0;
  double totalCredit = 100.0;
  List<int> vals = [0, 1, 2];
  bool creditDeceandWk = false;

  selectedTeam _currentFilter = selectedTeam.Both;
  List<player_point> Pointlist = new List<player_point>();

  @override
  void initState() {
    super.initState();
    fetchPoints();
    totalCredit = double.parse(ConstanceData.prof.credit.toString());
    if (ConstanceData.selectedPlayers.isNotEmpty ||
        ConstanceData.selectedPlayers.length > 0) {
      if (mounted) {
        setState(() {
          double cal = 0.0;
          for (var i in ConstanceData.selectedPlayers) {
            cal += i.fantasy_player_rating;
            addTeam(i.pid.toString());
          }
          totalCredit -= cal;
          WK = filterWK(ConstanceData.selectedPlayers).length;
          ALL = filterALL(ConstanceData.selectedPlayers).length;
          BAT = filterbat(ConstanceData.selectedPlayers).length;
          BOWL = filterbowl(ConstanceData.selectedPlayers).length;
        });
      } else {
        double cal = 0.0;
        for (var i in ConstanceData.selectedPlayers) {
          cal += i.fantasy_player_rating;
          addTeam(i.pid.toString());
        }
        totalCredit -= cal;
        WK = filterWK(ConstanceData.selectedPlayers).length;
        ALL = filterALL(ConstanceData.selectedPlayers).length;
        BAT = filterbat(ConstanceData.selectedPlayers).length;
        BOWL = filterbowl(ConstanceData.selectedPlayers).length;
      }
    }
    wks = filterWK(ConstanceData.teamCombine);
    alls = filterALL(ConstanceData.teamCombine);
    bats = filterbat(ConstanceData.teamCombine);
    bowls = filterbowl(ConstanceData.teamCombine);
    if (creditDeceandWk) {
      wks = quickSort(wks, 0, wks.length - 1);
      bats = quickSort(bats, 0, bats.length - 1);
      alls = quickSort(alls, 0, alls.length - 1);
      bowls = quickSort(bowls, 0, bowls.length - 1);
    } else {
      wks = quickSort(wks, 0, wks.length - 1).reversed.toList(growable: false);
      bats =
          quickSort(bats, 0, bats.length - 1).reversed.toList(growable: false);
      alls =
          quickSort(alls, 0, alls.length - 1).reversed.toList(growable: false);
      bowls = quickSort(bowls, 0, bowls.length - 1)
          .reversed
          .toList(growable: false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).padding.top,
                color: Colors.grey.shade900,
              ),
              appBar(),
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: selectedTeam.TeamA,
                                                groupValue: _currentFilter,
                                                onChanged: (value) {
                                                  setState(() {
                                                    setIt(() {
                                                      _currentFilter = value;
                                                      wks = filterTeamA(
                                                          filterWK(ConstanceData
                                                              .teamCombine));
                                                      alls = filterTeamA(
                                                          filterALL(ConstanceData
                                                              .teamCombine));
                                                      bowls = filterTeamA(
                                                          filterbowl(
                                                              ConstanceData
                                                                  .teamCombine));
                                                      bats = filterTeamA(
                                                          filterbat(ConstanceData
                                                              .teamCombine));
                                                      if (creditDeceandWk) {
                                                        wks = quickSort(wks, 0,
                                                            wks.length - 1);
                                                        bats = quickSort(bats,
                                                            0, bats.length - 1);
                                                        alls = quickSort(alls,
                                                            0, alls.length - 1);
                                                        bowls = quickSort(
                                                            bowls,
                                                            0,
                                                            bowls.length - 1);
                                                      } else {
                                                        wks = quickSort(wks, 0,
                                                                wks.length - 1)
                                                            .reversed
                                                            .toList(
                                                                growable:
                                                                    false);
                                                        bats = quickSort(
                                                                bats,
                                                                0,
                                                                bats.length - 1)
                                                            .reversed
                                                            .toList(
                                                                growable:
                                                                    false);
                                                        alls = quickSort(
                                                                alls,
                                                                0,
                                                                alls.length - 1)
                                                            .reversed
                                                            .toList(
                                                                growable:
                                                                    false);
                                                        bowls = quickSort(
                                                                bowls,
                                                                0,
                                                                bowls.length -
                                                                    1)
                                                            .reversed
                                                            .toList(
                                                                growable:
                                                                    false);
                                                      }
                                                    });
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              Text(
                                                  '${widget.list[widget.index].teama.short_name}')
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: selectedTeam.TeamB,
                                                groupValue: _currentFilter,
                                                onChanged: (value) {
                                                  setState(() {
                                                    setIt(() {
                                                      _currentFilter = value;
                                                      wks = filterTeamB(
                                                          filterWK(ConstanceData
                                                              .teamCombine));
                                                      alls = filterTeamB(
                                                          filterALL(ConstanceData
                                                              .teamCombine));
                                                      bowls = filterTeamB(
                                                          filterbowl(
                                                              ConstanceData
                                                                  .teamCombine));
                                                      bats = filterTeamB(
                                                          filterbat(ConstanceData
                                                              .teamCombine));
                                                      if (creditDeceandWk) {
                                                        wks = quickSort(wks, 0,
                                                            wks.length - 1);
                                                        bats = quickSort(bats,
                                                            0, bats.length - 1);
                                                        alls = quickSort(alls,
                                                            0, alls.length - 1);
                                                        bowls = quickSort(
                                                            bowls,
                                                            0,
                                                            bowls.length - 1);
                                                      } else {
                                                        wks = quickSort(wks, 0,
                                                                wks.length - 1)
                                                            .reversed
                                                            .toList(
                                                                growable:
                                                                    false);
                                                        bats = quickSort(
                                                                bats,
                                                                0,
                                                                bats.length - 1)
                                                            .reversed
                                                            .toList(
                                                                growable:
                                                                    false);
                                                        alls = quickSort(
                                                                alls,
                                                                0,
                                                                alls.length - 1)
                                                            .reversed
                                                            .toList(
                                                                growable:
                                                                    false);
                                                        bowls = quickSort(
                                                                bowls,
                                                                0,
                                                                bowls.length -
                                                                    1)
                                                            .reversed
                                                            .toList(
                                                                growable:
                                                                    false);
                                                      }
                                                    });
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              Text(
                                                  '${widget.list[widget.index].teamb.short_name}')
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: selectedTeam.Both,
                                                groupValue: _currentFilter,
                                                onChanged: (value) {
                                                  setState(() {
                                                    setIt(() {
                                                      _currentFilter = value;
                                                      wks = filterTeams(
                                                          filterWK(ConstanceData
                                                              .teamCombine));
                                                      alls = filterTeams(
                                                          filterALL(ConstanceData
                                                              .teamCombine));
                                                      bowls = filterTeams(
                                                          filterbowl(
                                                              ConstanceData
                                                                  .teamCombine));
                                                      bats = filterTeams(
                                                          filterbat(ConstanceData
                                                              .teamCombine));
                                                      if (creditDeceandWk) {
                                                        wks = quickSort(wks, 0,
                                                            wks.length - 1);
                                                        bats = quickSort(bats,
                                                            0, bats.length - 1);
                                                        alls = quickSort(alls,
                                                            0, alls.length - 1);
                                                        bowls = quickSort(
                                                            bowls,
                                                            0,
                                                            bowls.length - 1);
                                                      } else {
                                                        wks = quickSort(wks, 0,
                                                                wks.length - 1)
                                                            .reversed
                                                            .toList(
                                                                growable:
                                                                    false);
                                                        bats = quickSort(
                                                                bats,
                                                                0,
                                                                bats.length - 1)
                                                            .reversed
                                                            .toList(
                                                                growable:
                                                                    false);
                                                        alls = quickSort(
                                                                alls,
                                                                0,
                                                                alls.length - 1)
                                                            .reversed
                                                            .toList(
                                                                growable:
                                                                    false);
                                                        bowls = quickSort(
                                                                bowls,
                                                                0,
                                                                bowls.length -
                                                                    1)
                                                            .reversed
                                                            .toList(
                                                                growable:
                                                                    false);
                                                      }
                                                    });
                                                  });
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
                              wks = quickSort(wks, 0, wks.length - 1);
                              bats = quickSort(bats, 0, bats.length - 1);
                              alls = quickSort(alls, 0, alls.length - 1);
                              bowls = quickSort(bowls, 0, bowls.length - 1);
                            } else {
                              wks = quickSort(wks, 0, wks.length - 1)
                                  .reversed
                                  .toList(growable: false);
                              bats = quickSort(bats, 0, bats.length - 1)
                                  .reversed
                                  .toList(growable: false);
                              alls = quickSort(alls, 0, alls.length - 1)
                                  .reversed
                                  .toList(growable: false);
                              bowls = quickSort(bowls, 0, bowls.length - 1)
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
              isWk == true
                  ? wk()
                  : isBAT == true
                      ? bat()
                      : isAR == true
                          ? ar()
                          : isBowl == true
                              ? bowl()
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
                      builder: (context) => TeamPreViewPage(
                          ConstanceData.selectedPlayers,
                          0,
                          0,
                          widget.list[widget.index].teama.short_name,
                          widget.list[widget.index].teamb.short_name),
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
                  if (WK >= 1 && WK <= 4) {
                    if (BAT >= 3 && BAT <= 6) {
                      if (ALL >= 1 && ALL <= 4) {
                        if (BOWL >= 3 && BOWL <= 6) {
                          if (ConstanceData.selectedPlayers.length == 11) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChooseCaptainPage(
                                    ConstanceData.selectedPlayers,
                                    widget.compId,
                                    widget.matchID,
                                    widget.time,
                                    widget.list[widget.index].teama.short_name,
                                    widget.list[widget.index].teamb.short_name),
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
                              msg: "Add at least three bowlers",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Add at least one allrounder",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Add at least three batsman",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: "Add at least one wicketkeeper",
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
          )
        ],
      ),
    );
  }

  Widget wk() {
    return Expanded(
      child: ConstanceData.teamCombine.isEmpty ||
              ConstanceData.teamCombine.length <= 0
          ? getWkWidget()
          : ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: wks.length,
              itemBuilder: (contx, index) {
                players data = wks[index];
                print(',en ${wks.length}');
                return InkWell(
                  onTap: () {
                    Add_remove(data, () {
                      if (WK == 0 || WK < 4) {
                        setState(() {
                          ConstanceData.selectedPlayers.add(data);
                          totalCredit -= data.fantasy_player_rating;
                          WK++;
                          addTeam(data.pid.toString());
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                "Minimum 1 and maximum 4 wicketkeepers allowed",
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
                        totalCredit += data.fantasy_player_rating;
                        WK--;
                      });
                    });
                  },
                  child: TeamCardView(
                    txt1:
                        "${whichTeam(data.pid.toString()) == 'a' ? widget.list[widget.index].teama.short_name : widget.list[widget.index].teamb.short_name}",
                    txt2: AppLocalizations.of('${data.title}'),
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
                        'assets/images/${data.title.toString().trim().toLowerCase()}.webp',
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

  Widget bat() {
    return Expanded(
      child: ConstanceData.teamCombine.isEmpty ||
              ConstanceData.teamCombine.length <= 0
          ? getBat()
          : ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: bats.length,
              itemBuilder: (contx, index) {
                players data = bats[index];
                return InkWell(
                  onTap: () {
                    Add_remove(data, () {
                      if (BAT >= 0 && BAT < 6) {
                        setState(() {
                          ConstanceData.selectedPlayers.add(data);
                          totalCredit -= data.fantasy_player_rating;
                          BAT++;
                          addTeam(data.pid.toString());
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Minimum 3 and maximum 6 batsman are allowed",
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
                        BAT--;
                        totalCredit += data.fantasy_player_rating;
                      });
                    });
                  },
                  child: TeamCardView(
                    txt1:
                        "${whichTeam(data.pid.toString()) == 'a' ? widget.list[widget.index].teama.short_name : widget.list[widget.index].teamb.short_name}",
                    txt2: AppLocalizations.of('${data.title}'),
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
                        'assets/images/${data.title.toString().trim().toLowerCase()}.webp',
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

  Widget ar() {
    return Expanded(
      child: ConstanceData.teamCombine.isEmpty ||
              ConstanceData.teamCombine.length <= 0
          ? getARwidget()
          : ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: alls.length,
              itemBuilder: (contx, index) {
                players data = alls[index];
                return InkWell(
                  onTap: () {
                    Add_remove(data, () {
                      if (ALL >= 0 && ALL < 4) {
                        setState(() {
                          ConstanceData.selectedPlayers.add(data);
                          totalCredit -= data.fantasy_player_rating;
                          ALL++;
                          addTeam(data.pid.toString());
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                "Minimum 1 and maximum 4 Allrounders are allowed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }, () {
                      minusTeam(data.pid);
                      removeIT(data);
                      setState(() {
                        ALL--;
                        totalCredit += data.fantasy_player_rating;
                      });
                    });
                  },
                  child: TeamCardView(
                    txt1:
                        "${whichTeam(data.pid.toString()) == 'a' ? widget.list[widget.index].teama.short_name : widget.list[widget.index].teamb.short_name}",
                    txt2: AppLocalizations.of('${data.title}'),
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
                        'assets/images/${data.title.toString().trim().toLowerCase()}.webp',
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

  Widget bowl() {
    return Expanded(
      child: ConstanceData.teamCombine.isEmpty ||
              ConstanceData.teamCombine.length <= 0
          ? getBowlWidget()
          : ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: bowls.length,
              itemBuilder: (contx, index) {
                players data = bowls[index];
                return InkWell(
                  onTap: () {
                    Add_remove(data, () {
                      if (BOWL >= 0 && BOWL < 6) {
                        setState(() {
                          ConstanceData.selectedPlayers.add(data);
                          totalCredit -= data.fantasy_player_rating;
                          BOWL++;
                          addTeam(data.pid.toString());
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Minimum 3 and maximum 6 bowlers are allowed",
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
                        BOWL--;
                        totalCredit += data.fantasy_player_rating;
                      });
                    });
                  },
                  child: TeamCardView(
                    txt1:
                        // "${bowls[index].nationality == null ? bowls[index].country : bowls[index].nationality}",
                        "${whichTeam(data.pid.toString()) == 'a' ? widget.list[widget.index].teama.short_name : widget.list[widget.index].teamb.short_name}",
                    txt2: AppLocalizations.of('${data.title}'),
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
                        'assets/images/${data.title.toString().trim().toLowerCase()}.webp',
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

  Widget tabBar() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isWk = true;
              isBAT = false;
              isAR = false;
              isBowl = false;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5, left: 20),
            child: Text(
              AppLocalizations.of('WK($WK)'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: isWk ? Theme.of(context).primaryColor : Colors.grey,
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
              isWk = false;
              isBAT = true;
              isAR = false;
              isBowl = false;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              AppLocalizations.of('BAT(${BAT})'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: isBAT ? Theme.of(context).primaryColor : Colors.grey,
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
              isWk = false;
              isBAT = false;
              isAR = true;
              isBowl = false;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5, right: 20),
            child: Text(
              AppLocalizations.of('AR($ALL)'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: isAR ? Theme.of(context).primaryColor : Colors.grey,
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
              isWk = false;
              isBAT = false;
              isAR = false;
              isBowl = true;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5, right: 20),
            child: Text(
              AppLocalizations.of('BOWL($BOWL)'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color:
                        isBowl ? Theme.of(context).primaryColor : Colors.grey,
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

  Widget appBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.grey.shade900,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                children: [
                  Padding(
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
                        Expanded(child: SizedBox()),
                        CountdownTimer(
                          endTime: widget.time,
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
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
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
                        Expanded(child: SizedBox()),
                        Icon(
                          Icons.help,
                          color: Colors.white,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
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
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
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
                                  "${ConstanceData.selectedPlayers.length}",
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
                            widget.list[widget.index].teama.logo_url,
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
                              "${widget.list[widget.index].teama.short_name}",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
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
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
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
                              "${widget.list[widget.index].teamb.short_name}",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
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
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
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
                            widget.list[widget.index].teamb.logo_url,
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
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
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
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
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
                            ConstanceData.selectedPlayers.length >= 1
                                ? Color(0xff0ebd01)
                                : Colors.white),
                        SizedBox(
                          width: 3,
                        ),
                        customContainer(
                            ConstanceData.selectedPlayers.length >= 2
                                ? Color(0xff0ebd01)
                                : Colors.white),
                        SizedBox(
                          width: 3,
                        ),
                        customContainer(
                            ConstanceData.selectedPlayers.length >= 3
                                ? Color(0xff0ebd01)
                                : Colors.white),
                        SizedBox(
                          width: 3,
                        ),
                        customContainer(
                            ConstanceData.selectedPlayers.length >= 4
                                ? Color(0xff0ebd01)
                                : Colors.white),
                        SizedBox(
                          width: 3,
                        ),
                        customContainer(
                            ConstanceData.selectedPlayers.length >= 5
                                ? Color(0xff0ebd01)
                                : Colors.white),
                        SizedBox(
                          width: 3,
                        ),
                        customContainer(
                            ConstanceData.selectedPlayers.length >= 6
                                ? Color(0xff0ebd01)
                                : Colors.white),
                        SizedBox(
                          width: 3,
                        ),
                        customContainer(
                            ConstanceData.selectedPlayers.length >= 7
                                ? Color(0xff0ebd01)
                                : Colors.white),
                        SizedBox(
                          width: 3,
                        ),
                        customContainer(
                            ConstanceData.selectedPlayers.length >= 8
                                ? Color(0xff0ebd01)
                                : Colors.white),
                        SizedBox(
                          width: 3,
                        ),
                        customContainer(
                            ConstanceData.selectedPlayers.length >= 9
                                ? Color(0xff0ebd01)
                                : Colors.white),
                        SizedBox(
                          width: 3,
                        ),
                        customContainer(
                            ConstanceData.selectedPlayers.length >= 10
                                ? Color(0xff0ebd01)
                                : Colors.white),
                        SizedBox(
                          width: 3,
                        ),
                        customContainer(
                            ConstanceData.selectedPlayers.length >= 11
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
      ],
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

  List<players> filterWK(List<players> teamCombine) {
    List<players> list = new List<players>();
    for (var i in teamCombine) {
      if (i.playing_role.toString().trim() == "wk") {
        list.add(i);
      }
    }

    return list;
  }

  List<players> filterALL(List<players> teamCombine) {
    List<players> list = new List<players>();
    for (var i in teamCombine) {
      if (i.playing_role.toString().trim() == "all") {
        list.add(i);
      }
    }

    return list;
  }

  List<players> filterbat(List<players> teamCombine) {
    List<players> list = new List<players>();
    for (var i in teamCombine) {
      if (i.playing_role.toString().trim() == "bat") {
        list.add(i);
      }
    }

    return list;
  }

  List<players> filterbowl(List<players> teamCombine) {
    List<players> list = new List<players>();
    for (var i in teamCombine) {
      if (i.playing_role.toString().trim() == "bowl") {
        list.add(i);
      }
    }

    return list;
  }

  void reduce(players selectedPlayer) {
    if (selectedPlayer.playing_role.toString().trim() == 'wk') {
      setState(() {
        WK--;
        minusTeam(selectedPlayer.pid.toString());
      });
    } else if (selectedPlayer.playing_role.toString().trim() == "all") {
      setState(() {
        ALL--;
        minusTeam(selectedPlayer.pid.toString());
      });
    } else if (selectedPlayer.playing_role.toString().trim() == "bat") {
      setState(() {
        BAT--;
        minusTeam(selectedPlayer.pid.toString());
      });
    } else {
      setState(() {
        BOWL--;
        minusTeam(selectedPlayer.pid.toString());
      });
    }
  }

  void isSatisfied(players selectedPlayer) {
    if (selectedPlayer.playing_role.toString().trim() == 'wk') {
    } else if (selectedPlayer.playing_role.toString().trim() == 'bat') {
    } else if (selectedPlayer.playing_role.toString().trim() == 'all') {
    } else {}
  }

  void removeIT(wk) {
    for (int i = 0; i < ConstanceData.selectedPlayers.length; i++) {
      if (ConstanceData.selectedPlayers[i].title == wk.title) {
        setState(() {
          ConstanceData.selectedPlayers.removeAt(i);
        });
      }
    }
  }

  getBat() {
    return Container();
  }

  getWkWidget() {
    return Container();
  }

  getARwidget() {
    return Container();
  }

  getBowlWidget() {
    return Container();
  }

  getPoint(pid) {
    for (var i in Pointlist) {
      if (pid.toString() == i.pid.toString()) {
        return i.total_point;
      }
    }
    return null;
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

  String whichTeam(pid) {
    for (var a in ConstanceData.teamA) {
      if (a.pid.toString() == pid.toString()) {
        return 'a';
      }
    }
    for (var b in ConstanceData.teamB) {
      if (b.pid.toString() == pid.toString()) {
        return 'b';
      }
    }
  }

  void mainReduce() {
    if (ConstanceData.selectedPlayers.length == 11) {
      setState(() {
        reduce(ConstanceData
            .selectedPlayers[ConstanceData.selectedPlayers.length - 1]);
        totalCredit += ConstanceData
            .selectedPlayers[ConstanceData.selectedPlayers.length - 1]
            .fantasy_player_rating;
        ConstanceData.selectedPlayers.removeLast();
      });
    } else {
      if (ConstanceData.selectedPlayers.length == 10) {
        setState(() {
          reduce(ConstanceData
              .selectedPlayers[ConstanceData.selectedPlayers.length - 1]);
          totalCredit += ConstanceData
              .selectedPlayers[ConstanceData.selectedPlayers.length - 1]
              .fantasy_player_rating;
          ConstanceData.selectedPlayers.removeLast();
        });
      } else {
        if (ConstanceData.selectedPlayers.length == 9) {
          setState(() {
            reduce(ConstanceData
                .selectedPlayers[ConstanceData.selectedPlayers.length - 1]);
            totalCredit += ConstanceData
                .selectedPlayers[ConstanceData.selectedPlayers.length - 1]
                .fantasy_player_rating;
            ConstanceData.selectedPlayers.removeLast();
          });
        } else {
          if (ConstanceData.selectedPlayers.length == 8) {
            setState(() {
              reduce(ConstanceData
                  .selectedPlayers[ConstanceData.selectedPlayers.length - 1]);
              totalCredit += ConstanceData
                  .selectedPlayers[ConstanceData.selectedPlayers.length - 1]
                  .fantasy_player_rating;
              ConstanceData.selectedPlayers.removeLast();
            });
          } else {
            if (ConstanceData.selectedPlayers.length == 7) {
              setState(() {
                reduce(ConstanceData
                    .selectedPlayers[ConstanceData.selectedPlayers.length - 1]);
                totalCredit += ConstanceData
                    .selectedPlayers[ConstanceData.selectedPlayers.length - 1]
                    .fantasy_player_rating;
                ConstanceData.selectedPlayers.removeLast();
              });
            } else {
              if (ConstanceData.selectedPlayers.length == 6) {
                setState(() {
                  reduce(ConstanceData.selectedPlayers[
                      ConstanceData.selectedPlayers.length - 1]);
                  totalCredit += ConstanceData
                      .selectedPlayers[ConstanceData.selectedPlayers.length - 1]
                      .fantasy_player_rating;
                  ConstanceData.selectedPlayers.removeLast();
                });
              } else {
                if (ConstanceData.selectedPlayers.length == 5) {
                  setState(() {
                    reduce(ConstanceData.selectedPlayers[
                        ConstanceData.selectedPlayers.length - 1]);
                    totalCredit += ConstanceData
                        .selectedPlayers[
                            ConstanceData.selectedPlayers.length - 1]
                        .fantasy_player_rating;
                    ConstanceData.selectedPlayers.removeLast();
                  });
                } else {
                  if (ConstanceData.selectedPlayers.length == 4) {
                    setState(() {
                      reduce(ConstanceData.selectedPlayers[
                          ConstanceData.selectedPlayers.length - 1]);
                      totalCredit += ConstanceData
                          .selectedPlayers[
                              ConstanceData.selectedPlayers.length - 1]
                          .fantasy_player_rating;
                      ConstanceData.selectedPlayers.removeLast();
                    });
                  } else {
                    if (ConstanceData.selectedPlayers.length == 3) {
                      setState(() {
                        reduce(ConstanceData.selectedPlayers[
                            ConstanceData.selectedPlayers.length - 1]);
                        totalCredit += ConstanceData
                            .selectedPlayers[
                                ConstanceData.selectedPlayers.length - 1]
                            .fantasy_player_rating;
                        ConstanceData.selectedPlayers.removeLast();
                      });
                    } else {
                      if (ConstanceData.selectedPlayers.length == 2) {
                        setState(() {
                          reduce(ConstanceData.selectedPlayers[
                              ConstanceData.selectedPlayers.length - 1]);
                          totalCredit += ConstanceData
                              .selectedPlayers[
                                  ConstanceData.selectedPlayers.length - 1]
                              .fantasy_player_rating;
                          ConstanceData.selectedPlayers.removeLast();
                        });
                      } else {
                        if (ConstanceData.selectedPlayers.length == 1) {
                          reduce(ConstanceData.selectedPlayers[
                              ConstanceData.selectedPlayers.length - 1]);
                          totalCredit += ConstanceData
                              .selectedPlayers[
                                  ConstanceData.selectedPlayers.length - 1]
                              .fantasy_player_rating;
                          setState(() {
                            ConstanceData.selectedPlayers.removeLast();
                          });
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  void Add_remove(
      players data, void Function() param1, void Function() param2) {
    if (contains(data)) {
      if (ConstanceData.selectedPlayers != null &&
          ConstanceData.selectedPlayers.length >= 0) {
        if (ConstanceData.selectedPlayers.length < 11) {
          if (totalCredit >= data.fantasy_player_rating) {
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

  checkIfAnounced(String id) {
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
    return false;
  }

  filterTeamA(wks) {
    List<players> list = new List<players>();
    for (var i in wks) {
      for (var j in ConstanceData.teamA) {
        if (i.pid.toString() == j.pid.toString()) {
          list.add(i);
        }
      }
    }
    return list;
  }

  filterTeamB(wks) {
    List<players> list = new List<players>();
    for (var i in wks) {
      for (var j in ConstanceData.teamB) {
        if (i.pid.toString() == j.pid.toString()) {
          list.add(i);
        }
      }
    }
    return list;
  }

  filterTeams(wks) {
    List<players> list = new List<players>();
    for (var i in wks) {
      for (var j in ConstanceData.teamA) {
        if (i.pid.toString() == j.pid.toString()) {
          list.add(i);
        }
      }
      for (var k in ConstanceData.teamB) {
        if (i.pid.toString() == k.pid.toString()) {
          list.add(i);
        }
      }
    }
    return list;
  }

  getSelby(String string) {
    for (var i in ConstanceData.selby_Player_list) {
      if (i.player_id.toString() == string) {
        return double.parse(i.select_ratio.toString()).toInt();
      }
    }
    return 0;
  }

  void fetchPoints() async {
    print('iqw ${widget.compId.toString()}');
    access_network().player_points(widget.compId.toString()).then((_) {
      setState(() {
        print('va ');
        Pointlist = _;
      });
    });
  }

  lastMatchPlayed(pid) {
    for (var i in Pointlist) {
      if (pid.toString() == i.pid.toString()) {
        return i.lastMatchPlayed ? "Played last match" : "";
      }
    }
    return "";
  }
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

List<players> quickSort(List<players> list, int low, int high) {
  if (low < high) {
    int pi = partition(list, low, high);
    print("pivot: ${list[pi]} now at index $pi");

    quickSort(list, low, pi - 1);
    quickSort(list, pi + 1, high);
  }
  return list;
}

int partition(List<players> list, low, high) {
  // Base check
  if (list.isEmpty) {
    return 0;
  }
  // Take our last element as pivot and counter i one less than low
  players pivot = list[high];

  int i = low - 1;
  for (int j = low; j < high; j++) {
    // When j is < than pivot element we increment i and swap arr[i] and arr[j]
    if (list[j].fantasy_player_rating < pivot.fantasy_player_rating) {
      i++;
      swap(list, i, j);
    }
  }
  // Swap the last element and place in front of the i'th element
  swap(list, i + 1, high);
  return i + 1;
}

// Swapping using a temp variable
void swap(List<players> list, int i, int j) {
  players temp = list[i];
  list[i] = list[j];
  list[j] = temp;
}

bool contains(wk) {
  if (ConstanceData.selectedPlayers.length <= 0) {
    return true;
  }
  for (var i in ConstanceData.selectedPlayers) {
    if (i.title == wk.title) {
      return false;
    }
  }
  return true;
}
