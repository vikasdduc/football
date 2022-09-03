import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/Matche.dart';
import 'package:fantacySports/Model/Players.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:flutter/material.dart';

class stats extends StatefulWidget {
  final List<players> list;
  final match data;

  stats({Key key, this.list, this.data}) : super(key: key);

  @override
  _statsState createState() => _statsState();
}

class _statsState extends State<stats> {

  AlertDialog alert;
  bool point = false;
  bool selby = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              padding: EdgeInsets.only(
                right: 20,
                left: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 170,
                    child: Text(
                      'PLAYERS',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        point = !point;
                      });
                    },
                    child: SizedBox(
                      width: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'POINTS',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Icon(
                            point?Icons.arrow_downward:Icons.arrow_upward,
                            size: 11,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selby = !selby;
                      });
                    },
                    child: SizedBox(
                      width: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '%SEL BY',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Icon(
                            selby?Icons.arrow_downward:Icons.arrow_upward,
                            size: 11,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: widget.list != null && widget.list.length > 1
                    ? ListView.builder(
                        padding: EdgeInsets.all(0.0),
                        itemCount: widget.list.length,
                        shrinkWrap: true,
                        itemBuilder: (cont, index) {
                          var data = widget.list[index];
                          return Column(
                            children: [
                              cardView(
                                AppLocalizations.of(''),
                                "${data.playing_role}",
                                AppLocalizations.of('${data.title}'),
                                "${whichTeam(data.pid.toString()) == 'a' ? widget.data.teama.short_name : widget.data.teamb.short_name}",
                                "${getPoint(data.pid).toString()}",
                                "${getSelby(data.pid.toString())}",
                                ClipRRect(
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
                                index,
                                  whichTeam(data.pid.toString())
                              ),
                              SizedBox(
                                height: 0.25,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                   color: Colors.grey.shade900,
                                ),
                              ),
                            ],
                          );
                        })
                    : Center(
                        child: Text('Data not available'),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  setValues(value) {
    if (value != null && value.length != 0) {
      print('sdr');
      setState(() {
        ConstanceData.setMyList(value);
      });
    } else {
      print('ad');
    }
  }

  String getPlayers() {
    String players;
    for (int i = 0; i < widget.list.length; i++) {
      if (i == 0) {
        players = widget.list[i].pid.toString();
        players += ',';
      } else if (i == widget.list.length - 1) {
        players += widget.list[i].pid.toString();
      } else {
        players += widget.list[i].pid.toString();
        players += ',';
      }
    }
    return players;
  }

  getPoint(pid) {
    for (var i in ConstanceData.teamCombine_points) {
      if (pid.toString() == i.pid.toString()) {
        return i.point.toString();
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

  calculatePoint(data, index) {
    if (data == null || data == 'null') {
      return 0;
    } else {
      return int.parse(data);
    }
  }

  getDef() {
    return Container();
  }

  Widget cardView(String txt1, String txt2, String txt3, String txt4,
      String txt5, String txt6, Widget image1, int index,String team) {
    String point = calculatePoint(txt5, index).toString();
    return Container(
      color: team=='a'?Colors.yellow.shade100:Theme.of(context).disabledColor.withOpacity(0.02),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 20,
          top: 10,
          bottom: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 170,
              child: Row(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                        ),
                        child: image1,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(2),
                                bottomLeft: Radius.circular(2),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                txt1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                      letterSpacing: 0.6,
                                      fontSize: 8,
                                    ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffD0C1AB),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(2),
                                bottomRight: Radius.circular(2),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                txt2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                      letterSpacing: 0.6,
                                      fontSize: 8,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          txt3,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyText2.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                    letterSpacing: 0.6,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        txt4,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText2.color,
                              letterSpacing: 0.6,
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 70,
              child: Text(
                '${point}',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(
              width: 70,
              child: Text(
                txt6,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String whichTeam(pid) {
    for (var a in ConstanceData.teamA) {
      if (a.pid.toString() == pid.toString()) {
        print('a ${a.title}');
        return 'a';
      }
    }
    for (var b in ConstanceData.teamB) {
      if (b.pid.toString() == pid.toString()) {
        print('b ${b.title}');
        return 'b';
      }
    }
  }
  getSelby(String pid) {
    if (ConstanceData.selby_Player_list.length <= 0) {
      return '0%';
    } else {
      for (var i in ConstanceData.selby_Player_list) {
        if (i.player_id.toString() == pid) {
          return '${i.select_ratio}%';
        }
      }
      return '0%';
    }
  }

  @override
  void initState() {
    super.initState();

  }
}
