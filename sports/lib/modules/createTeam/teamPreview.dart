import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/Players.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TeamPreViewPage extends StatefulWidget {
  final cap, vc, teama, teamb;
  List<players> list;

  TeamPreViewPage(this.list, this.cap, this.vc, this.teama, this.teamb);

  @override
  _TeamPreViewPageState createState() => _TeamPreViewPageState();
}

class _TeamPreViewPageState extends State<TeamPreViewPage> {
  List<players> wk = new List<players>(),
      all = new List<players>(),
      bat = new List<players>(),
      bowl = new List<players>();

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
                image: AssetImage(ConstanceData.cricketGround),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SingleChildScrollView(
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
                            AppLocalizations.of('${ConstanceData.prof.team_name}'),
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
                        AppLocalizations.of('Wicket Keepers'),
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
                    WicketKeepers(),
                    SizedBox(height: 20,),
                    Center(
                      child: Text(
                        AppLocalizations.of('BatsMen'),
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
                    batsmens(),
                    SizedBox(height: 20,),
                    Center(
                      child: Text(
                        AppLocalizations.of('All-Rounders'),
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
                    allrounders(),
                    SizedBox(height: 20,),
                    Center(
                      child: Text(
                        AppLocalizations.of('Bowlers'),
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
                    bowlers(),
                    SizedBox(
                      height: 15,
                    ),
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
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
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
  short_the_name(title) {
    try {
      var txt = title.toString().split(' ');
      return '${txt[0].substring(0,1)}. ${txt[1]}';
    } catch (e) {
      print(e);
      return title;
    }
  }
  @override
  void initState() {
    super.initState();
    filter(widget.list);
  }

  void filter(List<players> selectedPlayers) {
    for (var i in selectedPlayers) {
      if (i.playing_role == 'wk') {
        wk.add(i);
      } else if (i.playing_role == 'bat') {
        bat.add(i);
      } else if (i.playing_role == 'all') {
        all.add(i);
      } else {
        bowl.add(i);
      }
    }
  }

  batsmens() {
    print(bat.length);
    if (bat != null && bat.length > 0) {
      return Column(
            children: [
              Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < getBatmanSize(); i++)
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          playerDetail(
                            AppLocalizations.of('${bat[i].short_title}'),
                            AppLocalizations.of(
                                '${bat[i].fantasy_player_rating.toString()}'),
                            AppLocalizations.of('${bat[i].playing_role}'),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: Image.asset(
                                'assets/images/${bat[i].title.toString().trim().toLowerCase()}.webp',
                                fit: BoxFit.fill,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace stackTrace) {
                                  return Image.asset(
                                      ConstanceData.defaultPlayer);
                                },
                              ),
                            ),
                            whichTeam(bat[i].pid) == 'a'
                                ? Theme.of(context).appBarTheme.color
                                : Theme.of(context).textTheme.headline6.color,
                            whichTeam(bat[i].pid) == 'a'
                                ? Theme.of(context).textTheme.headline6.color
                                : Theme.of(context).appBarTheme.color,
                          ),
                          Container(
                            padding: EdgeInsets.all(
                              bat[i].pid.toString() == widget.cap.toString() ?6:3,
                            ),
                            decoration:bat[i].pid.toString() == widget.cap.toString()|| bat[i].pid.toString() == widget.vc.toString()? BoxDecoration(
                              shape: BoxShape.circle,
                              color:whichTeam(bat[i].pid) == 'a'
                                  ? Colors.black:Colors.white,

                              border: Border.all(
                                color: whichTeam(bat[i].pid) == 'a'
                                    ? Colors.white:Colors.black,
                              ),
                            ):BoxDecoration(),
                            child: Text(
                              '${bat[i].pid.toString() == widget.cap.toString() ? 'C' : bat[i].pid.toString() == widget.vc.toString() ? 'VC' : ''}',
                              style: TextStyle(
                                fontSize: 13,
                                color:whichTeam(bat[i].pid) == 'a'
                                    ? Colors.white:Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              bat.length > 3
                  ? Container(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 3; i < bat.length; i++)
                            Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                playerDetail(
                                  AppLocalizations.of('${bat[i].short_title}'),
                                  AppLocalizations.of(
                                      '${bat[i].fantasy_player_rating.toString()}'),
                                  AppLocalizations.of('${bat[i].playing_role}'),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Image.asset(
                                      'assets/images/${bat[i].title.toString().trim().toLowerCase()}.webp',
                                      fit: BoxFit.fill,
                                      errorBuilder: (BuildContext context,
                                          Object exception, StackTrace stackTrace) {
                                        return Image.asset(
                                            ConstanceData.defaultPlayer);
                                      },
                                    ),
                                  ),
                                  whichTeam(bat[i].pid) == 'a'
                                      ? Theme.of(context).appBarTheme.color
                                      : Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                  whichTeam(bat[i].pid) == 'a'
                                      ? Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color
                                      : Theme.of(context).appBarTheme.color,
                                ),
                                Container(
                                  padding: EdgeInsets.all(
                                    bat[i].pid.toString() == widget.cap.toString() ?7:3,
                                  ),
                                  decoration:bat[i].pid.toString() == widget.cap.toString()|| bat[i].pid.toString() == widget.vc.toString()? BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:whichTeam(bat[i].pid) == 'a'
                                        ? Colors.black:Colors.white,

                                    border: Border.all(
                                      color: whichTeam(bat[i].pid) == 'a'
                                          ? Colors.white:Colors.black,
                                    ),
                                  ):BoxDecoration(),
                                  child: Text(
                                    '${bat[i].pid.toString() == widget.cap.toString() ? 'C' : bat[i].pid.toString() == widget.vc.toString() ? 'VC' : ''}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: whichTeam(bat[i].pid) == 'a'
                                          ? Colors.white:Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          );
    } else {
      return Container();
    }
  }

  allrounders() {
    return all != null && all.length > 0
        ? Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < all.length; i++)
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      playerDetail(
                        AppLocalizations.of('${all[i].short_title}'),
                        AppLocalizations.of(
                            '${all[i].fantasy_player_rating.toString()}'),
                        AppLocalizations.of('${all[i].playing_role}'),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.asset(
                            'assets/images/${all[i].title.toString().trim().toLowerCase()}.webp',
                            fit: BoxFit.fill,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace stackTrace) {
                              return Image.asset(
                                  ConstanceData.defaultPlayer);
                            },
                          ),
                        ),
                        whichTeam(all[i].pid) == 'a'
                            ? Theme.of(context).appBarTheme.color
                            : Theme.of(context).textTheme.headline6.color,
                        whichTeam(all[i].pid) == 'a'
                            ? Theme.of(context).textTheme.headline6.color
                            : Theme.of(context).appBarTheme.color,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                          all[i].pid.toString() == widget.cap.toString() ?7:3,
                        ),
                        decoration:all[i].pid.toString() == widget.cap.toString()||all[i].pid.toString() == widget.vc.toString()? BoxDecoration(
                          shape: BoxShape.circle,
                          color:whichTeam(all[i].pid) == 'a'
                              ? Colors.black:Colors.white,

                          border: Border.all(
                            color: whichTeam(all[i].pid) == 'a'
                                ? Colors.white:Colors.black,
                          ),
                        ):BoxDecoration(),
                        child: Text(
                          '${all[i].pid.toString() == widget.cap.toString() ? 'C' : all[i].pid.toString() == widget.vc.toString() ? 'VC' : ''}',
                          style: TextStyle(
                            // fontSize: all[i].pid.toString() == widget.cap.toString() ?20:17,
                            fontSize: 13,
                            color: whichTeam(all[i].pid) == 'a'
                                ? Colors.white:Colors.black,
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

  bowlers() {
    return bowl != null && bowl.length > 0
        ? Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < getBowlerSize(); i++)
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          playerDetail(
                            AppLocalizations.of('${bowl[i].short_title}'),
                            AppLocalizations.of(
                                '${bowl[i].fantasy_player_rating.toString()}'),
                            AppLocalizations.of('${bowl[i].playing_role}'),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: Image.asset(
                                'assets/images/${bowl[i].title.toString().trim().toLowerCase()}.webp',
                                fit: BoxFit.fill,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace stackTrace) {
                                  return Image.asset(
                                      ConstanceData.defaultPlayer);
                                },
                              ),
                            ),
                            whichTeam(bowl[i].pid) == 'a'
                                ? Theme.of(context).appBarTheme.color
                                : Theme.of(context).textTheme.headline6.color,
                            whichTeam(bowl[i].pid) == 'a'
                                ? Theme.of(context).textTheme.headline6.color
                                : Theme.of(context).appBarTheme.color,
                          ),
                          Container(
                            padding: EdgeInsets.all(
                              bowl[i].pid.toString() == widget.cap.toString() ?7:3,
                            ),
                            decoration:bowl[i].pid.toString() == widget.cap.toString()||bowl[i].pid.toString() == widget.vc.toString()? BoxDecoration(
                              shape: BoxShape.circle,
                              color:whichTeam(bowl[i].pid) == 'a'
                                  ? Colors.black:Colors.white,

                              border: Border.all(
                                color: whichTeam(bowl[i].pid) == 'a'
                                    ? Colors.white:Colors.black,
                              ),
                            ):BoxDecoration(),
                            child: Text(
                              '${bowl[i].pid.toString() == widget.cap.toString() ? 'C' : bowl[i].pid.toString() == widget.vc.toString() ? 'VC' : ''}',
                              style: TextStyle(
                                fontSize: 13,
                                color: whichTeam(bowl[i].pid) == 'a'
                                    ? Colors.white:Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              bowl.length > 3
                  ? Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 3; i < bowl.length; i++)
                            Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                playerDetail(
                                  AppLocalizations.of('${bowl[i].short_title}'),
                                  AppLocalizations.of(
                                      '${bowl[i].fantasy_player_rating.toString()}'),
                                  AppLocalizations.of(
                                      '${bowl[i].playing_role}'),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Image.asset(
                                      'assets/images/${bowl[i].title.toString().trim().toLowerCase()}.webp',
                                      fit: BoxFit.fill,
                                      errorBuilder: (BuildContext context,
                                          Object exception, StackTrace stackTrace) {
                                        return Image.asset(
                                            ConstanceData.defaultPlayer);
                                      },
                                    ),
                                  ),
                                  whichTeam(bowl[i].pid) == 'a'
                                      ? Theme.of(context).appBarTheme.color
                                      : Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                  whichTeam(bowl[i].pid) == 'a'
                                      ? Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color
                                      : Theme.of(context).appBarTheme.color,
                                ),
                                Container(
                                  padding: EdgeInsets.all(
                                    bowl[i].pid.toString() == widget.cap.toString() ?7:3,
                                  ),
                                  decoration:bowl[i].pid.toString() == widget.cap.toString()||bowl[i].pid.toString() == widget.vc.toString()? BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:whichTeam(bowl[i].pid) == 'a'
                                        ? Colors.black:Colors.white,

                                    border: Border.all(
                                      color: whichTeam(bowl[i].pid) == 'a'
                                          ? Colors.white:Colors.black,
                                    ),
                                  ):BoxDecoration(),
                                  child: Text(
                                    '${bowl[i].pid.toString() == widget.cap.toString() ? 'C' : bowl[i].pid.toString() == widget.vc.toString() ? 'VC' : ''}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: whichTeam(bowl[i].pid) == 'a'
                                          ? Colors.white:Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          )
        : Container();
  }

  num getBatmanSize() {
    if (bat.length < 3) {
      print('return 3 ${bat.length}');
      return bat.length;
    } else {
      print('return  ${bat.length}');
      return 3;
    }
  }

  num getBowlerSize() {
    if (bowl.length < 3) {
      print('return 3 ${bat.length}');
      return bowl.length;
    } else {
      print('return  ${bat.length}');
      return 3;
    }
  }

  WicketKeepers() {
    return wk.length != null && wk.length > 0
        ? Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < wk.length; i++)
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      playerDetail(
                        AppLocalizations.of('${wk[i].short_title}'),
                        AppLocalizations.of(
                            '${wk[i].fantasy_player_rating.toString()}'),
                        AppLocalizations.of('${wk[i].playing_role}'),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.asset(
                            'assets/images/${wk[i].title.toString().trim().toLowerCase()}.webp',
                            fit: BoxFit.fill,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace stackTrace) {
                              return Image.asset(
                                  ConstanceData.defaultPlayer);
                            },
                          ),
                        ),
                        whichTeam(wk[i].pid) == 'a'
                            ? Theme.of(context).appBarTheme.color
                            : Theme.of(context).textTheme.headline6.color,
                        whichTeam(wk[i].pid) == 'a'
                            ? Theme.of(context).textTheme.headline6.color
                            : Theme.of(context).appBarTheme.color,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                          wk[i].pid.toString() == widget.cap.toString() ?6:3,
                        ),
                        decoration:wk[i].pid.toString() == widget.cap.toString()||wk[i].pid.toString() == widget.vc.toString()? BoxDecoration(
                          shape: BoxShape.circle,
                          color:whichTeam(wk[i].pid) == 'a'
                              ? Colors.black
                              : Colors.white,

                          border: Border.all(
                            color: whichTeam(wk[i].pid) == 'a'
                                ? Colors.white:Colors.black,
                          ),
                        ):BoxDecoration(),
                        child: Text(
                          '${wk[i].pid.toString() == widget.cap.toString() ? 'C' : wk[i].pid.toString() == widget.vc.toString() ? 'VC' : ''}',
                          style: TextStyle(
                            fontSize: 13,
                            color: whichTeam(wk[i].pid) == 'a'
                                ? Colors.white:Colors.black,
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
}
