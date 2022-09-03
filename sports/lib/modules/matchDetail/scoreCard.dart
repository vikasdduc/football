import 'package:fantacySports/Model/Scorecard/Batsman.dart';
import 'package:fantacySports/Model/Scorecard/Bowler.dart';
import 'package:fantacySports/Model/Scorecard/FOW.dart';
import 'package:fantacySports/Model/Scorecard/Innings.dart';
import 'package:fantacySports/Model/Scorecard/YetToBatPlayer.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:flutter/material.dart';

class Scorecard extends StatefulWidget {
  const Scorecard({Key key}) : super(key: key);

  @override
  _ScorecardState createState() => _ScorecardState();
}

class _ScorecardState extends State<Scorecard> {
  List<bool> visible = new List<bool>();

  @override
  void initState() {
    super.initState();
    for (var i in ConstanceData.Innings) {
      visible.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          // physics: NeverScrollableScrollPhysics(),
          itemCount: ConstanceData.Innings.length,
          itemBuilder: (con, index) {
            innings data = ConstanceData.Innings[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 0.3,
                      ),
                    ),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width:200,
                        child: Text(
                          data.short_name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        data.scores_full,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            visible[index] = !visible[index];
                          });
                        },
                        child: Icon(visible[index]
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: visible[index],
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 8.0, right: 2),
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 0.25,
                              ),
                            ),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 200, child: Text('Batter')),
                                SizedBox(
                                    width: 20,
                                    child: Text(
                                      'R',
                                      textAlign: TextAlign.right,
                                    )),
                                SizedBox(
                                    width: 20,
                                    child: Text(
                                      'B',
                                      textAlign: TextAlign.right,
                                    )),
                                SizedBox(
                                    width: 20,
                                    child: Text(
                                      '4s',
                                      textAlign: TextAlign.right,
                                    )),
                                SizedBox(
                                    width: 20,
                                    child: Text(
                                      '6s',
                                      textAlign: TextAlign.right,
                                    )),
                                SizedBox(
                                    width: 50,
                                    child: Text(
                                      'S/R',
                                      textAlign: TextAlign.right,
                                    )),
                              ]),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height,
                              minHeight:
                                  MediaQuery.of(context).size.height / 2.6),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: data.batsmen.length,
                            itemBuilder: (con, index) {
                              batsman bat = data.batsmen[index];
                              return Container(
                                padding: EdgeInsets.only(
                                    left: 8.0, top: 8.0, right: 2.0),

                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black,
                                        width: 0.2,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: 200,
                                              child: Text(bat.name)),
                                          SizedBox(
                                              width: 25,
                                              child: Text(
                                                '${bat.runs}',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              )),
                                          SizedBox(
                                              width: 25,
                                              child: Text(
                                                '${bat.balls_faced}',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              )),
                                          SizedBox(
                                              width: 25,
                                              child: Text(
                                                '${bat.fours}',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              )),
                                          SizedBox(
                                              width: 25,
                                              child: Text(
                                                '${bat.sixes}',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              )),
                                          SizedBox(
                                              width: 50,
                                              child: Text(
                                                '${bat.strike_rate}',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          bat.how_out,
                                          softWrap: true,
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 0.2,
                              ),
                            ),
                          ),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('EXTRAS'),
                                      Text(
                                        '${data.extra_run.total}',
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      data.extra_run.toString(),
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        getYetToBat(data.did_not_bat) != null &&
                                getYetToBat(data.did_not_bat) != 'null' &&
                                getYetToBat(data.did_not_bat) != ''
                            ? Container(
                                padding: EdgeInsets.all(8.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 0.2,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Text('DID NOT BAT'),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                                '${getYetToBat(data.did_not_bat)}',
                                                softWrap: true,
                                                style: TextStyle(fontSize: 13)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        Container(
                          padding: EdgeInsets.only(top: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  bottom: 5,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 0.2,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: 150,
                                        child: Text('Bowler')),
                                    SizedBox(
                                        width: 25,
                                        child: Text(
                                          'O',
                                          textAlign: TextAlign.right,
                                        )),
                                    SizedBox(
                                        width: 25,
                                        child: Text(
                                          'M',
                                          textAlign: TextAlign.right,
                                        )),
                                    SizedBox(
                                        width: 25,
                                        child: Text(
                                          'R',
                                          textAlign: TextAlign.right,
                                        )),
                                    SizedBox(
                                        width: 25,
                                        child: Text(
                                          'W',
                                          textAlign: TextAlign.right,
                                        )),
                                    SizedBox(
                                        width: 50,
                                        child: Text(
                                          'Eco',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 13,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight: 200, minHeight: 100),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: data.bowlers.length,
                                  itemBuilder: (con, index) {
                                    bowler bowlers = data.bowlers[index];
                                    return Container(
                                      padding: EdgeInsets.only(
                                          left: 8.0, top: 8.0, right: 2.0),
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black,
                                                    width: 0.2,
                                                  ),
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 150,
                                                        child: Text(
                                                          bowlers.name,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: 25,
                                                          child: Text(
                                                            '${bowlers.overs}',
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                            ),
                                                          )),
                                                      SizedBox(
                                                          width: 25,
                                                          child: Text(
                                                            '${bowlers.maidens}',
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                            ),
                                                          )),
                                                      SizedBox(
                                                          width: 25,
                                                          child: Text(
                                                            '${bowlers.runs_conceded}',
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                            ),
                                                          )),
                                                      SizedBox(
                                                          width: 25,
                                                          child: Text(
                                                            '${bowlers.wickets}',
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 13,
                                                            ),
                                                          )),
                                                      SizedBox(
                                                          width: 50,
                                                          child: Text(
                                                            '${bowlers.econ}',
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 30, bottom: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  bottom: 5,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 0.2,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: 150,
                                        child: Text('Fall of Wickets')),
                                    SizedBox(width: 50, child: Text('Score')),
                                    SizedBox(width: 50, child: Text('Overs')),
                                  ],
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight: 200, minHeight: 100),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: data.fows.length,
                                  itemBuilder: (con, index) {
                                    fow fows = data.fows[index];
                                    return Container(
                                      padding:
                                          EdgeInsets.only(left: 8.0, top: 8.0),
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 8.0),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black,
                                                    width: 0.2,
                                                  ),
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 150,
                                                        child: Text(
                                                          '${fows.name}',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 50,
                                                        child: Text(
                                                          '${fows.score_at_dismissal}',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 50,
                                                        child: Text(
                                                          '${fows.overs_at_dismissal}',
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  String getYetToBat(List<yet_to_bat_player> did_not_bat) {
    String txt = '';
    for (int i = 0; i < did_not_bat.length; i++) {
      if (i == 0) {
        if (did_not_bat.length == 0) {
          txt = did_not_bat[i].name;
        } else {
          txt = did_not_bat[i].name + ", ";
        }
      } else if (i == did_not_bat.length - 1) {
        txt = txt + did_not_bat[i].name;
      } else {
        txt = txt + did_not_bat[i].name + ", ";
      }
    }
    return txt;
  }
}
