import 'package:fantacySports/Model/Soccer/soccer_player.dart';
import 'package:flutter/material.dart';

import '../../../Language/appLocalizations.dart';
import '../../../constance/constance.dart';

class SoccerTeamPreview extends StatefulWidget {
  final int cap, vc;
  final String teama, teamb;
  List<SoccerPlayer> list;

  SoccerTeamPreview(this.cap, this.vc, this.teama, this.teamb, this.list);

  @override
  State<SoccerTeamPreview> createState() => _SoccerTeamPreviewState();
}

class _SoccerTeamPreviewState extends State<SoccerTeamPreview> {
  List<SoccerPlayer> gk = [], mid = [], def = [], st = [];

  @override
  void initState() {
    super.initState();
    filter(widget.list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Theme.of(context).textTheme.headline6.color,
          ),
          Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ConstanceData.soccerGround),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(
                              '${ConstanceData.prof.team_name}'),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.6,
                                fontSize: 14,
                              ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: Theme.of(context).appBarTheme.color,
                            size: 24,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      AppLocalizations.of('GOAL-KEEPER'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.6,
                            fontSize: 11,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  player_list(gk),
                  Spacer(),
                  Center(
                    child: Text(
                      AppLocalizations.of('DEFENDER'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.6,
                            fontSize: 11,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  player_list(def),
                  Spacer(),
                  Center(
                    child: Text(
                      AppLocalizations.of('MID-FIELDER'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.6,
                            fontSize: 11,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  player_list(mid),
                  Spacer(),
                  Center(
                    child: Text(
                      AppLocalizations.of('FORWARD'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.6,
                            color: Colors.white,
                            fontSize: 11,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  player_list(st),
                  Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 8,
                          width: 8,
                          child: Container(
                            color: Theme.of(context).appBarTheme.color,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          AppLocalizations.of('${widget.teama}'),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.6,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 8,
                          width: 8,
                          child: Container(
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          AppLocalizations.of('${widget.teamb}'),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.6,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  player_list(List<SoccerPlayer> list) {
    return list.length != null && list.length > 0
        ? Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < list.length; i++)
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      playerDetail(
                        AppLocalizations.of('${list[i].name}'),
                        AppLocalizations.of(
                            '${list[i].fantasy_player_rating.toString()}'),
                        AppLocalizations.of('${list[i].positiontype}'),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.asset(
                            'assets/images/${list[i].name.toString().trim().toLowerCase()}.webp',
                            fit: BoxFit.fill,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace stackTrace) {
                              return Image.asset(ConstanceData.defaultPlayer);
                            },
                          ),
                        ),
                        whichTeam(list[i].pid) == 'a'
                            ? Theme.of(context).appBarTheme.color
                            : Theme.of(context).textTheme.headline6.color,
                        whichTeam(list[i].pid) == 'a'
                            ? Theme.of(context).textTheme.headline6.color
                            : Theme.of(context).appBarTheme.color,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                          list[i].pid.toString() == widget.cap.toString()
                              ? 6
                              : 3,
                        ),
                        decoration: list[i].pid.toString() ==
                                    widget.cap.toString() ||
                                list[i].pid.toString() == widget.vc.toString()
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                color: whichTeam(list[i].pid) == 'a'
                                    ? Colors.black
                                    : Colors.white,
                                border: Border.all(
                                  color: whichTeam(list[i].pid) == 'a'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              )
                            : BoxDecoration(),
                        child: Text(
                          '${list[i].pid.toString() == widget.cap.toString() ? 'C' : list[i].pid.toString() == widget.vc.toString() ? 'VC' : ''}',
                          style: TextStyle(
                            fontSize: 13,
                            color: whichTeam(list[i].pid) == 'a'
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          )
        : Container();
  }

  Widget playerDetail(String txt1, String txt2, String text3, Widget image1,
      Color color, Color txtColor) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Container(
            height: 55,
            width: 55,
            child: image1,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  color: color,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 6, right: 6, top: 2, bottom: 2),
                    child: SizedBox(
                      width: 60,
                      child: Text(
                        short_the_name(txt1),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: txtColor,
                              letterSpacing: 0.6,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                      ),
                    ),
                  ),
                ),
                Text(
                  txt2,
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Colors.white,
                        letterSpacing: 0.6,
                        fontSize: 10,
                      ),
                ),
              ],
            )),
      ],
    );
  }

  String whichTeam(pid) {
    for (var a in ConstanceData.soccerTeamA) {
      if (a.pid.toString() == pid.toString()) {
        // print('a ${a.}');
        return 'a';
      }
    }
    for (var b in ConstanceData.soccerTeamB) {
      if (b.pid.toString() == pid.toString()) {
        // print('b ${b.title}');
        return 'b';
      }
    }
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

  void filter(List<SoccerPlayer> selectedPlayers) {
    for (var i in selectedPlayers) {
      if (i.positiontype == 'G') {
        gk.add(i);
      } else if (i.positiontype == 'M') {
        mid.add(i);
      } else if (i.positiontype == 'D') {
        def.add(i);
      } else {
        st.add(i);
      }
    }
  }
}
